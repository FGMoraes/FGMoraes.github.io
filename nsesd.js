/* ====================================================================
   nsesd.js - ponto UNICO de configuracao dos caminhos do site.

     load_repo(arquivo)         arquivo na raiz do repositorio (nome SEM ".pdf")
     load_dissertacao(nome)     dissertacao  (nome SEM ".pdf")
     load_tese(nome)            tese         (nome SEM ".pdf")
     load_tcc(nome)             TCC          (nome SEM ".pdf")
     load_doc(nome)             journal      (nome SEM ".pdf")
     load_paper(nome)           conferencia  (nome SEM ".pdf")
     load_photo(arquivo)        foto         (nome COM extensao)
     load_fig(arquivo)          figura       (nome COM extensao)
     load_mono(arquivo)         monografia   (nome COM extensao: .doc/.pdf/.ppt)
     load_capa(arquivo)         capa de periodico (nome COM extensao)

   E, para links/imagens estaticos, os atributos data-* abaixo, que
   sao reescritos automaticamente na carga da pagina:

     <img data-figs="doi.png" width="25" alt=" ">
     <img data-fotos="defesa_ze.jpg" width="120" alt=" ">
     <img data-capas="JICS.jpg" class="capa" alt=" ">
     <a   data-fotos="defesa_ze.jpg">foto</a>
     <a   data-doi="10.1109/TC.2026.3700461"></a>   (o logo DOI e inserido)
   ==================================================================== */

/* =============================== CONFIGURACAO =============================== */

var PAGE_BASE = "https://nsesd.pucrs.br/moraes/";
var DIR_REPO  = PAGE_BASE + "repo/";

var DIR_MONOGRAFIAS  = DIR_REPO + "monografias/";
var DIR_DISSERTACOES = DIR_REPO + "dissertacoes/";
var DIR_TESES        = DIR_REPO + "teses/";
var DIR_TCC          = DIR_REPO + "tcc/";
var DIR_JOURNALS     = DIR_REPO + "journals/";
var DIR_PAPERS       = DIR_REPO + "papers/";
var DIR_FIGS         = PAGE_BASE + "figs/";
var DIR_FOTOS        = PAGE_BASE + "fotos/";
var DIR_CAPAS        = PAGE_BASE + "capas/";

/* Base do DOI e largura, em pixels, do logo inserido por data-doi. */
var DOI_BASE  = "https://doi.org/";
var DOI_WIDTH = 20;

/* ============================= FIM DA CONFIGURACAO ========================== */


/* Abre qualquer URL em outra janela/aba. */
function open_url(url) {
  window.open(url, "_blank", "noopener");
}

function load_repo(file) { open_url(DIR_REPO + file + ".pdf"); }

function load_mono(file) { open_url(DIR_MONOGRAFIAS + file); }

function load_dissertacao(name) { open_url(DIR_DISSERTACOES + name + ".pdf"); }

function load_tese(name) { open_url(DIR_TESES + name + ".pdf"); }

function load_tcc(name) { open_url(DIR_TCC + name + ".pdf"); }

function load_doc(name) { open_url(DIR_JOURNALS + name + ".pdf"); }

function load_paper(name) { open_url(DIR_PAPERS + name + ".pdf"); }

function load_photo(file) { open_url(DIR_FOTOS + file); }

function load_fig(file) { open_url(DIR_FIGS + file); }

function load_capa(file) { open_url(DIR_CAPAS + file); }

/* Resolve os atributos data-* dos links e imagens estaticos.
   Em <img> preenche o "src"; nos demais (<a>), o "href". */
document.addEventListener("DOMContentLoaded", function () {
  var BASE = {
    "data-figs":  DIR_FIGS,
    "data-fotos": DIR_FOTOS,
    "data-capas": DIR_CAPAS
  };

  for (var name in BASE) {
    var nodes = document.querySelectorAll("[" + name + "]");
    for (var i = 0; i < nodes.length; i++) {
      var el = nodes[i];
      el.setAttribute(el.tagName === "IMG" ? "src" : "href",
                      BASE[name] + el.getAttribute(name));
    }
  }

  /* data-doi: monta o link para doi.org e, se o <a> estiver vazio,
     insere o logo do DOI. */
  var links = document.querySelectorAll("a[data-doi]");
  for (var k = 0; k < links.length; k++) {
    var a = links[k];
    a.setAttribute("href", DOI_BASE + a.getAttribute("data-doi"));
    a.setAttribute("target", "_blank");
    a.setAttribute("rel", "noopener");
    if (a.firstChild) continue;                 // o <a> ja tem conteudo proprio
    var img = document.createElement("img");
    img.src   = DIR_FIGS + "doi.png";
    img.width = DOI_WIDTH;
    img.alt   = " ";
    a.appendChild(img);
  }
});
