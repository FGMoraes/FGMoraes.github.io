/*
 * citations.js - insere a contagem de citacoes em cada linha da tabela de
 * publicacoes e um resumo acima dela, a partir de citations.json.
 *
 * Instalacao: acrescentar uma linha antes de </body> nas paginas desejadas:
 *     <script src="citations.js" defer></script>
 *
 * Nenhuma outra alteracao no HTML e necessaria: o DOI de cada publicacao e
 * lido do proprio link ja presente na linha. Linhas sem DOI sao ignoradas.
 * Se citations.json faltar ou estiver corrompido, a pagina permanece intacta.
 *
 * Observacao: fetch() nao funciona sob file://. Testar por HTTP.
 */

(function () {
  "use strict";

  var JSON_URL = "citations.json";
  var SHOW_SUMMARY = true;     // linha de resumo acima da tabela
  var SHOW_ZERO = false;        // exibir tambem os artigos com 0 citacoes
  var LABEL = "cited by";      // rotulo do contador por artigo

  var DOI_RE = /doi\.org\/(10\.[^\s"?#]+)/i;

  function normalize(doi) {
    return doi.trim().replace(/[.,;]+$/, "").toLowerCase();
  }

  function injectStyle() {
    var css =
      ".cit-badge{display:inline-block;margin-left:6px;padding:1px 7px;" +
      "border-radius:9px;background:#f26b18;color:#fff;font-size:11px;" +
      "font-weight:bold;vertical-align:middle;white-space:nowrap}" +
      ".cit-badge.cit-zero{background:#bbb}" +
      ".cit-summary{margin:0 0 10px 6px;font-size:12px;color:#444}" +
      ".cit-summary strong{color:#f26b18}";
    var el = document.createElement("style");
    el.appendChild(document.createTextNode(css));
    document.head.appendChild(el);
  }

  function rowDoi(row) {
    var links = row.querySelectorAll('a[href*="doi.org/"]');
    for (var i = 0; i < links.length; i++) {
      var m = DOI_RE.exec(links[i].getAttribute("href") || "");
      if (m) {
        return normalize(m[1]);
      }
    }
    return null;
  }

  function badge(n) {
    var span = document.createElement("span");
    span.className = "cit-badge" + (n === 0 ? " cit-zero" : "");
    span.textContent = LABEL + " " + n;
    span.title = "Fonte: OpenAlex/Crossref. Nao inclui o Google Scholar.";
    return span;
  }

  function anchorCell(row) {
    // ultima celula da linha: a que contem os metadados e os links
    var cells = row.querySelectorAll("td");
    return cells.length ? cells[cells.length - 1] : null;
  }

  function summary(data, shown, matched) {
    var p = document.createElement("p");
    p.className = "cit-summary";
    var date = (data.generated || "").slice(0, 10);
    p.innerHTML =
      "Citations: <strong>" + shown + "</strong> across " + matched +
      " indexed articles &middot; source: OpenAlex/Crossref &middot; updated " +
      date;
    return p;
  }

  function apply(data) {
    var counts = data.counts || {};
    var rows = document.querySelectorAll("table tr");
    var total = 0;
    var matched = 0;

    for (var i = 0; i < rows.length; i++) {
      var doi = rowDoi(rows[i]);
      if (!doi || !Object.prototype.hasOwnProperty.call(counts, doi)) {
        continue;
      }
      var n = counts[doi].citations;
      if (typeof n !== "number") {
        continue;
      }
      total += n;
      matched += 1;
      if (n === 0 && !SHOW_ZERO) {
        continue;
      }
      var cell = anchorCell(rows[i]);
      if (cell) {
        cell.appendChild(badge(n));
      }
    }

    if (SHOW_SUMMARY && matched > 0) {
      var table = document.querySelector("table");
      if (table && table.parentNode) {
        table.parentNode.insertBefore(summary(data, total, matched), table);
      }
    }
  }

  function start() {
    injectStyle();
    fetch(JSON_URL, { cache: "no-cache" })
      .then(function (resp) {
        if (!resp.ok) {
          throw new Error("HTTP " + resp.status);
        }
        return resp.json();
      })
      .then(apply)
      .catch(function (err) {
        // falha silenciosa: a pagina continua utilizavel sem os contadores
        if (window.console) {
          console.warn("citations.js: " + err.message);
        }
      });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", start);
  } else {
    start();
  }
})();
