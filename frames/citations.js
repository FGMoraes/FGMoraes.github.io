/* citations.js - insere a contagem de citacoes como ultima linha de cada entrada.
 *
 * Le citations.json (gerado por fetch_citations.py) e acrescenta, ao final da
 * ultima celula de cada <tr>, uma linha com o numero de citacoes.
 *
 * Uso na pagina:  <script src="citations.js" defer></script>
 * CSS sugerido em pubs.css:
 *     .citations       { font-size: 0.85em; color: #555; }
 *     .citations.stale { color: #999; }
 */

(function () {
  "use strict";

  var JSON_FILE = "citations.json";

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

  function label(n) {
    return n === 1 ? "1 citation" : n + " citations";
  }

  function annotate(row, entry) {
    var cells = row.cells;
    if (!cells.length) { return false; }

    var cell = cells[cells.length - 1];          /* ultima celula da entrada */
    if (cell.querySelector(".citations")) { return false; }  /* nao duplica */

    var n = parseInt(entry.citations, 10);
    if (isNaN(n)) { return false; }

    var span = document.createElement("span");
    span.className = entry.stale ? "citations stale" : "citations";
    span.textContent = label(n);
    if (entry.source) {
      span.title = "source: " + entry.source + (entry.stale ? " (previous run)" : "");
    }

    cell.appendChild(document.createElement("br"));
    cell.appendChild(span);
    return true;
  }

  function apply(payload) {
    var index = buildIndex(payload.counts);
    var rows = document.querySelectorAll("table tr");
    var total = 0;
    var marked = 0;

    Array.prototype.forEach.call(rows, function (row) {
      var doi = doiOfRow(row);
      if (!doi) { return; }                       /* entradas sem DOI */
      var entry = index[doi];
      if (!entry) { return; }                     /* DOI nao resolvido */
      if (annotate(row, entry)) {
        marked += 1;
        total += parseInt(entry.citations, 10) || 0;
      }
    });

    document.documentElement.setAttribute("data-citations-total", String(total));
    document.documentElement.setAttribute("data-citations-entries", String(marked));
    return { entries: marked, total: total };
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
