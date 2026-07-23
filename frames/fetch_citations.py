#!/usr/bin/env python3
"""
fetch_citations.py - gera citations.json com a contagem de citacoes por DOI.

Le um ou mais arquivos HTML de publicacoes, extrai os DOIs dos links,
consulta a API do OpenAlex (em lote) e, para os DOIs ausentes, a do Crossref.
Grava um JSON consumido por citations.js.

Uso:
    python3 fetch_citations.py pub_journals.html
    python3 fetch_citations.py pub_journals.html pub_conferences.html -o citations.json
    python3 fetch_citations.py pub_journals.html --mailto voce@pucrs.br

Sem dependencias externas (apenas biblioteca padrao).
Sugestao de cron semanal:
    0 3 * * 1  cd /caminho/do/site/pubs && /usr/bin/python3 fetch_citations.py pub_journals.html
"""

import argparse
import json
import re
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from datetime import datetime, timezone

OPENALEX = "https://api.openalex.org/works"
CROSSREF = "https://api.crossref.org/works/"
BATCH_SIZE = 50          # limite pratico do filtro doi:a|b|c do OpenAlex
TIMEOUT = 30             # segundos
RETRIES = 3
PAUSE = 1.0              # segundos entre requisicoes

DOI_RE = re.compile(r'href="[^"]*?doi\.org/(10\.[^"\s?#]+)"', re.IGNORECASE)


# --------------------------------------------------------------------------
# extracao dos DOIs
# --------------------------------------------------------------------------

def normalize(doi):
    """Minusculas e sem pontuacao final; e a forma usada como chave no JSON."""
    return doi.strip().rstrip(".,;").lower()


def extract_dois(paths):
    """Retorna a lista de DOIs unicos, preservando a ordem de aparicao."""
    seen = []
    for path in paths:
        try:
            with open(path, encoding="utf-8") as fh:
                html = fh.read()
        except OSError as err:
            sys.stderr.write("aviso: nao foi possivel ler %s (%s)\n" % (path, err))
            continue
        for raw in DOI_RE.findall(html):
            doi = normalize(raw)
            if doi not in seen:
                seen.append(doi)
    return seen


# --------------------------------------------------------------------------
# acesso as APIs
# --------------------------------------------------------------------------

def get_json(url, mailto):
    """GET com retentativa e recuo exponencial. Retorna dict ou None."""
    headers = {"User-Agent": "pub-citations/1.0 (mailto:%s)" % mailto,
               "Accept": "application/json"}
    for attempt in range(RETRIES):
        req = urllib.request.Request(url, headers=headers)
        try:
            with urllib.request.urlopen(req, timeout=TIMEOUT) as resp:
                return json.loads(resp.read().decode("utf-8"))
        except urllib.error.HTTPError as err:
            if err.code == 404:
                return None
            if err.code in (429, 500, 502, 503, 504) and attempt < RETRIES - 1:
                time.sleep(PAUSE * (2 ** attempt))
                continue
            sys.stderr.write("HTTP %s em %s\n" % (err.code, url))
            return None
        except Exception as err:                      # rede, timeout, JSON
            if attempt < RETRIES - 1:
                time.sleep(PAUSE * (2 ** attempt))
                continue
            sys.stderr.write("falha em %s (%s)\n" % (url, err))
            return None
    return None


def query_openalex(dois, mailto):
    """Consulta o OpenAlex em lotes. Retorna {doi: citacoes}."""
    found = {}
    for start in range(0, len(dois), BATCH_SIZE):
        chunk = dois[start:start + BATCH_SIZE]
        params = urllib.parse.urlencode({
            "filter": "doi:" + "|".join(chunk),
            "select": "doi,cited_by_count",
            "per-page": str(BATCH_SIZE),
            "mailto": mailto,
        })
        data = get_json("%s?%s" % (OPENALEX, params), mailto)
        if data:
            for work in data.get("results", []):
                url = work.get("doi") or ""
                doi = normalize(url.replace("https://doi.org/", ""))
                if doi:
                    found[doi] = int(work.get("cited_by_count") or 0)
        sys.stderr.write("openalex: lote %d-%d, %d/%d resolvidos\n"
                         % (start + 1, start + len(chunk), len(found), len(dois)))
        time.sleep(PAUSE)
    return found


def query_crossref(doi, mailto):
    """Consulta um DOI no Crossref. Retorna int ou None."""
    url = CROSSREF + urllib.parse.quote(doi) + "?mailto=" + urllib.parse.quote(mailto)
    data = get_json(url, mailto)
    if not data:
        return None
    msg = data.get("message") or {}
    count = msg.get("is-referenced-by-count")
    return int(count) if count is not None else None


# --------------------------------------------------------------------------
# principal
# --------------------------------------------------------------------------

def main():
    ap = argparse.ArgumentParser(description="gera citations.json a partir dos DOIs das paginas")
    ap.add_argument("html", nargs="+", help="arquivos HTML de publicacoes")
    ap.add_argument("-o", "--output", default="citations.json", help="arquivo de saida")
    ap.add_argument("--mailto", default="fernando.moraes@pucrs.br",
                    help="e-mail enviado as APIs (pool cortes do OpenAlex/Crossref)")
    ap.add_argument("--no-crossref", action="store_true",
                    help="nao consultar o Crossref para os DOIs ausentes no OpenAlex")
    args = ap.parse_args()

    dois = extract_dois(args.html)
    if not dois:
        sys.stderr.write("nenhum DOI encontrado; nada a fazer\n")
        return 1
    sys.stderr.write("%d DOIs extraidos de %s\n" % (len(dois), ", ".join(args.html)))

    counts = {}
    for doi, n in query_openalex(dois, args.mailto).items():
        counts[doi] = {"citations": n, "source": "openalex"}

    missing = [d for d in dois if d not in counts]
    if missing and not args.no_crossref:
        sys.stderr.write("crossref: consultando %d DOIs ausentes\n" % len(missing))
        for doi in missing:
            n = query_crossref(doi, args.mailto)
            if n is not None:
                counts[doi] = {"citations": n, "source": "crossref"}
            time.sleep(PAUSE)

    unresolved = [d for d in dois if d not in counts]
    payload = {
        "generated": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "dois_found": len(dois),
        "dois_resolved": len(counts),
        "total_citations": sum(v["citations"] for v in counts.values()),
        "unresolved": unresolved,
        "counts": counts,
    }

    # so sobrescreve o arquivo se a coleta foi razoavelmente completa,
    # evitando zerar a pagina apos uma falha de rede
    if counts and len(counts) < len(dois) / 2:
        sys.stderr.write("apenas %d de %d DOIs resolvidos; %s nao foi alterado\n"
                         % (len(counts), len(dois), args.output))
        return 2

    with open(args.output, "w", encoding="utf-8") as fh:
        json.dump(payload, fh, ensure_ascii=False, indent=1, sort_keys=True)

    sys.stderr.write("%s gravado: %d DOIs, %d citacoes no total\n"
                     % (args.output, len(counts), payload["total_citations"]))
    if unresolved:
        sys.stderr.write("nao resolvidos: %s\n" % ", ".join(unresolved))
    return 0


if __name__ == "__main__":
    sys.exit(main())
