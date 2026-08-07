#!/usr/bin/env python3
"""
fetch_citations.py - gera citations.json com a contagem de citacoes por DOI.

Le um ou mais arquivos HTML de publicacoes, extrai os DOIs das chamadas
DOI('...') e dos links doi.org, consulta o OpenAlex (em lote) e, para os
DOIs ausentes, o Crossref. Grava um JSON consumido por citations.js.

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
import os
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
MIN_RESOLVED_RATIO = 0.5  # abaixo disso o arquivo de saida nao e reescrito

# DOI('10.1109/TC.2026.3700461')  -- as aspas sao obrigatorias, o que impede
# casar com a declaracao "function DOI(doi)" presente no cabecalho da pagina.
DOI_CALL_RE = re.compile(r"""DOI\(\s*['"]\s*(10\.[^'"\s)]+?)\s*['"]\s*\)""")
# href="http(s)://doi.org/10...." ou href=".../dx.doi.org/10...."
DOI_HREF_RE = re.compile(r'href="[^"]*?doi\.org/(10\.[^"\s?#]+)"', re.IGNORECASE)


# --------------------------------------------------------------------------
# extracao dos DOIs
# --------------------------------------------------------------------------

def clean_doi(raw):
    """Retorna o DOI nu, em minusculas, sem prefixo de URL nem pontuacao final."""
    doi = raw.strip().strip("'\" ").rstrip(".,;").lower()
    doi = re.sub(r'^https?://(dx\.)?doi\.org/', '', doi)
    return doi


def key_of(doi):
    """Chave usada no JSON; mantem o formato consumido por citations.js."""
    return "http://doi.org/" + doi


def extract_dois(paths):
    """Retorna a lista de DOIs nus e unicos, preservando a ordem de aparicao."""
    seen = []
    known = set()
    for path in paths:
        try:
            with open(path, encoding="utf-8") as fh:
                html = fh.read()
        except OSError as err:
            sys.stderr.write("aviso: nao foi possivel ler %s (%s)\n" % (path, err))
            continue
        raws = DOI_CALL_RE.findall(html) + DOI_HREF_RE.findall(html)
        for raw in raws:
            doi = clean_doi(raw)
            if doi and doi not in known:
                known.add(doi)
                seen.append(doi)
    return seen


# --------------------------------------------------------------------------
# acesso as APIs
# --------------------------------------------------------------------------

def get_json(url, mailto):
    """GET com retentativa e recuo exponencial. Retorna dict ou None."""
    headers = {"User-Agent": "pub-citations/1.1 (mailto:%s)" % mailto,
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


def batchable(doi):
    """DOIs com ':' , '|' ou ',' quebram a sintaxe do filtro do OpenAlex."""
    return not any(c in doi for c in ":|,")


def query_openalex_batch(dois, mailto):
    """Consulta o OpenAlex em lotes. Retorna {doi_nu: citacoes}."""
    found = {}
    if not dois:
        return found
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
                doi = clean_doi(work.get("doi") or "")
                if doi:
                    found[doi] = int(work.get("cited_by_count") or 0)
        sys.stderr.write("openalex (lote): %d-%d, %d/%d resolvidos\n"
                         % (start + 1, start + len(chunk), len(found), len(dois)))
        time.sleep(PAUSE)
    return found


def query_openalex_single(doi, mailto):
    """Consulta um unico DOI pelo endpoint de caminho. Retorna int ou None."""
    url = "%s/https://doi.org/%s?select=doi,cited_by_count&mailto=%s" % (
        OPENALEX, urllib.parse.quote(doi, safe="/()"),
        urllib.parse.quote(mailto))
    data = get_json(url, mailto)
    if not data:
        return None
    count = data.get("cited_by_count")
    return int(count) if count is not None else None


def query_crossref(doi, mailto):
    """Consulta um DOI no Crossref. Retorna int ou None."""
    url = CROSSREF + urllib.parse.quote(doi, safe="/()") \
        + "?mailto=" + urllib.parse.quote(mailto)
    data = get_json(url, mailto)
    if not data:
        return None
    msg = data.get("message") or {}
    count = msg.get("is-referenced-by-count")
    return int(count) if count is not None else None


def load_previous(path):
    """Le o citations.json anterior para preservar valores nao resolvidos."""
    if not os.path.exists(path):
        return {}
    try:
        with open(path, encoding="utf-8") as fh:
            return (json.load(fh) or {}).get("counts", {}) or {}
    except Exception as err:
        sys.stderr.write("aviso: %s ilegivel (%s)\n" % (path, err))
        return {}


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
    ap.add_argument("--no-merge", action="store_true",
                    help="nao reaproveitar valores do citations.json anterior")
    args = ap.parse_args()

    dois = extract_dois(args.html)
    if not dois:
        sys.stderr.write("nenhum DOI encontrado; nada a fazer\n")
        return 1
    sys.stderr.write("%d DOIs extraidos de %s\n" % (len(dois), ", ".join(args.html)))

    counts = {}

    # 1. OpenAlex em lote, apenas com DOIs compativeis com o filtro
    lote = [d for d in dois if batchable(d)]
    especiais = [d for d in dois if not batchable(d)]
    for doi, n in query_openalex_batch(lote, args.mailto).items():
        counts[doi] = {"citations": n, "source": "openalex"}

    # 2. OpenAlex individual para os DOIs com ':' e para os ausentes do lote
    faltando = [d for d in dois if d not in counts]
    if faltando:
        sys.stderr.write("openalex (individual): %d DOIs (%d com caractere especial)\n"
                         % (len(faltando), len(especiais)))
        for doi in faltando:
            n = query_openalex_single(doi, args.mailto)
            if n is not None:
                counts[doi] = {"citations": n, "source": "openalex"}
            time.sleep(PAUSE)

    # 3. Crossref para o que restou
    faltando = [d for d in dois if d not in counts]
    if faltando and not args.no_crossref:
        sys.stderr.write("crossref: consultando %d DOIs ausentes\n" % len(faltando))
        for doi in faltando:
            sys.stderr.write("  - %s\n" % doi)
            n = query_crossref(doi, args.mailto)
            if n is not None:
                counts[doi] = {"citations": n, "source": "crossref"}
            time.sleep(PAUSE)

    resolvidos = len(counts)

    # so sobrescreve o arquivo se a coleta foi razoavelmente completa,
    # evitando zerar a pagina apos uma falha de rede
    if resolvidos < len(dois) * MIN_RESOLVED_RATIO:
        sys.stderr.write("apenas %d de %d DOIs resolvidos; %s nao foi alterado\n"
                         % (resolvidos, len(dois), args.output))
        return 2

    # reaproveita a contagem anterior dos DOIs nao resolvidos nesta execucao
    payload_counts = {key_of(d): dict(v, doi=d) for d, v in counts.items()}
    previous = {} if args.no_merge else load_previous(args.output)
    reaproveitados = 0
    for d in dois:
        k = key_of(d)
        if k not in payload_counts and k in previous:
            entry = dict(previous[k])
            entry["stale"] = True
            payload_counts[k] = entry
            reaproveitados += 1

    unresolved = [key_of(d) for d in dois if key_of(d) not in payload_counts]
    payload = {
        "generated": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "dois_found": len(dois),
        "dois_resolved": resolvidos,
        "dois_reused": reaproveitados,
        "total_citations": sum(v["citations"] for v in payload_counts.values()),
        "unresolved": unresolved,
        "counts": payload_counts,
    }

    with open(args.output, "w", encoding="utf-8") as fh:
        json.dump(payload, fh, ensure_ascii=False, indent=1, sort_keys=True)

    sys.stderr.write("%s gravado: %d DOIs resolvidos, %d reaproveitados, %d citacoes no total\n"
                     % (args.output, resolvidos, reaproveitados, payload["total_citations"]))
    if unresolved:
        sys.stderr.write("nao resolvidos: %s\n" % ", ".join(unresolved))
    return 0


if __name__ == "__main__":
    sys.exit(main())
