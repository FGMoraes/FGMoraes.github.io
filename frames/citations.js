/* citations.js - insere a contagem de citacoes como ultima linha de cada entrada.
 *
 * Le citations.json (gerado por fetch_citations.py) e acrescenta, ao final da
 * ultima celula de cada <tr>, uma linha com o numero de citacoes.
 * Entradas com zero citacoes nao recebem linha (ver SHOW_ZERO).
 *
 * Uso na pagina:  <script src="citations.js" defer></script>
 * Resumo agregado: se existir <div id="citations-summary"></div> na pagina,
 * o total e escrito nele.
 *
 * CSS sugerido em pubs.css:
 *     .citations         { font-size: 0.85em; color: #555; }
 *     .citations.stale   { color: #999; }
 *     #citations-summary { font-size: 0.9em; color: #555; margin: 0 0 8px 0; }
 */

(function () {
  "use strict";

  var JSON_FILE = "citations.json";
  var SHOW_ZERO = false;   /* true para exibir tambem "0 citations" */

  /* Rotulo exibido para cada fonte de dados. */
  var SOURCE_NAMES = { openalex: "OpenAlex", crossref: "Crossref" };

  /* Retorna o DOI nu, em minusculas, a partir de um DOI ou de uma URL doi.org. */
  function bareDoi(value) {
    if (!value) { return ""; }
    return String(value)
      .trim()
      .replace(/^https?:\/\/(dx\.)?doi\.org\//i, "")
      .replace(/[.,;]+$/, "")
      .toLowerCase();
  }

  /* Converte counts em um mapa {doi_nu: entrada}, aceitando chaves nuas ou URL. */
  function buildIndex(counts) {
    var index = {};
    Object.keys(counts || {}).forEach(function (key) {
      var entry = counts[key] || {};
      var doi = bareDoi(entry.doi || key);
      if (doi) { index[doi] = entry; }
    });
    return index;
  }

  /* Localiza o DOI de uma linha: primeiro link para doi.org dentro do <tr>. */
  function doiOfRow(row) {
    var link = row.querySelector('a[href*="doi.org/"]');
    return link ? bareDoi(link.getAttribute("href")) : "";
  }

  function sourceName(source) {
    if (!source) { return ""; }
    return SOURCE_NAMES[String(source).toLowerCase()] || String(source);
  }

  /* "12 citations (OpenAlex)" ou "12 citations (OpenAlex, previous run)" */
  function label(n, entry) {
    var text = (n === 1 ? "1 citation" : n + " citations");
    var name = sourceName(entry.source);
    var note = entry.stale ? "previous run" : "";
    if (name && note) { return text + " (" + name + ", " + note + ")"; }
    if (name)         { return text + " (" + name + ")"; }
    if (note)         { return text + " (" + note + ")"; }
    return text;
  }

  function annotate(row, entry) {
    var cells = row.cells;
    if (!cells.length) { return false; }

    var cell = cells[cells.length - 1];          /* ultima celula da entrada */
    if (cell.querySelector(".citations")) { return false; }  /* nao duplica */

    var n = parseInt(entry.citations, 10);
    if (isNaN(n)) { return false; }
    if (n <= 0 && !SHOW_ZERO) { return false; }   /* entradas sem citacao */

    var span = document.createElement("span");
    span.className = entry.stale ? "citations stale" : "citations";
    span.textContent = label(n, entry);

    cell.appendChild(document.createElement("br"));
    cell.appendChild(span);
    return true;
  }

  /* Preenche o resumo agregado, se o elemento existir na pagina. */
  function renderSummary(payload, stats) {
    var box = document.getElementById("citations-summary");
    if (!box) { return; }
    var date = (payload.generated || "").slice(0, 10);
    var srcs = Object.keys(stats.bySource).sort().map(function (s) {
      return sourceName(s) + ": " + stats.bySource[s];
    }).join(", ");
    box.textContent = stats.entries + " entries \u00b7 "
      + stats.total.toLocaleString("en-US") + " citations"
      + (srcs ? " \u00b7 " + srcs : "")
      + (date ? " \u00b7 updated " + date : "");
  }

  function apply(payload) {
    var index = buildIndex(payload.counts);
    var rows = document.querySelectorAll("table tr");
    var total = 0;
    var marked = 0;
    var bySource = {};

    Array.prototype.forEach.call(rows, function (row) {
      var doi = doiOfRow(row);
      if (!doi) { return; }                       /* entradas sem DOI */
      var entry = index[doi];
      if (!entry) { return; }                     /* DOI nao resolvido */
      if (annotate(row, entry)) {
        marked += 1;
        total += parseInt(entry.citations, 10) || 0;
        var src = String(entry.source || "unknown").toLowerCase();
        bySource[src] = (bySource[src] || 0) + 1;
      }
    });

    document.documentElement.setAttribute("data-citations-total", String(total));
    document.documentElement.setAttribute("data-citations-entries", String(marked));

    var stats = { entries: marked, total: total, bySource: bySource };
    renderSummary(payload, stats);
    return stats;
  }

  function run() {
    fetch(JSON_FILE, { cache: "no-cache" })
      .then(function (resp) {
        if (!resp.ok) { throw new Error("HTTP " + resp.status); }
        return resp.json();
      })
      .then(apply)
      .catch(function (err) {
        /* falha na leitura do JSON nao altera a pagina */
        if (window.console) { console.warn("citations.js:", err.message); }
      });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", run);
  } else {
    run();
  }
})();
