# -*- coding: utf-8 -*-
"""Gera o word cloud (quadrado) a partir dos titulos de periodicos e
conferencias de 2019 a 2026 listados em frames/pub_journals.html e
frames/pub_conferences.html."""
import io, os, re, sys, collections
from wordcloud import WordCloud, STOPWORDS
import matplotlib

FRAMES = "/Users/moraes/GIT/page/frames"
Y0, Y1 = 2019, 2026

def strip_tags(s):
    s = re.sub(r"<[^>]+>", " ", s)
    s = (s.replace("&amp;", "&").replace("&ndash;", "-").replace("&nbsp;", " ")
          .replace("&quot;", '"').replace("&#39;", "'"))
    return re.sub(r"\s+", " ", s).strip()

def journal_titles():
    html = io.open(os.path.join(FRAMES, "pub_journals.html"), encoding="utf-8").read()
    out, year = [], None
    for row in html.split("<tr>")[1:]:
        m = re.search(r'year-marker[^<]*<br>\s*(\d{4})', row)
        if m:
            year = int(m.group(1))
        for b in re.findall(r"<b>(.*?)</b>", row, re.S):
            t = strip_tags(b)
            if len(t.split()) < 3:          # "pdf file", numeros, etc.
                continue
            if year and Y0 <= year <= Y1:
                out.append(t)
            break                           # so o primeiro <b> = titulo
    return out

def conference_titles():
    html = io.open(os.path.join(FRAMES, "pub_conferences.html"), encoding="utf-8").read()
    out = []
    parts = re.split(r'<ol\s+id="ol(\d{4})"', html)
    for i in range(1, len(parts), 2):
        year, body = int(parts[i]), parts[i + 1]
        if not (Y0 <= year <= Y1):
            continue
        for li in re.findall(r"<li\b.*?</li>", body, re.S):
            m = re.search(r"<b>(.*?)</b>", li, re.S)
            if m:
                t = strip_tags(m.group(1))
                if len(t.split()) >= 3:
                    out.append(t)
    return out

EXTRA_STOP = set("""
    using use used towards toward based via new novel approach approaches
    case study studies paper work towards a an the of for and with on in to
    from into over under between within through their its it is are be targeting
    """.split())

TOKEN = re.compile(r"[A-Za-z][A-Za-z0-9\-+/]*[A-Za-z0-9+]|[A-Za-z]")

# Variantes que so poluem a nuvem se aparecerem separadas.
CANON = {
    "manycore": "Many-core", "manycores": "Many-core",
    "many-core": "Many-core", "many-cores": "Many-core",
    "multicore": "Multicore", "multicores": "Multicore",
    "noc": "NoC", "nocs": "NoC",
}

# Paleta escura/quente, no espirito da nuvem anterior (legivel sobre branco).
PALETTE = ["#A22B28", "#C8492B", "#E0821E", "#E8B01C", "#8C7A20",
           "#6E8A2A", "#3F5E1E", "#8B2E2E"]

def color_func(word, font_size, position, orientation, random_state=None, **kw):
    import zlib
    return PALETTE[zlib.crc32(word.encode("utf-8")) % len(PALETTE)]

def frequencies(titles):
    counts, casing = collections.Counter(), collections.defaultdict(collections.Counter)
    stop = set(w.lower() for w in STOPWORDS) | EXTRA_STOP
    for t in titles:
        for w in TOKEN.findall(t):
            w = w.strip("-/")
            k = w.lower()
            if len(k) < 2 or k in stop or k.isdigit():
                continue
            if k in CANON:
                counts[CANON[k].lower()] += 1
                casing[CANON[k].lower()][CANON[k]] += 1
                continue
            counts[k] += 1
            casing[k][w] += 1
    return {casing[k].most_common(1)[0][0]: c for k, c in counts.items()}

def main():
    titles = journal_titles() + conference_titles()
    freq = frequencies(titles)
    sys.stderr.write("titulos: %d | palavras distintas: %d\n" % (len(titles), len(freq)))
    sys.stderr.write("top: %s\n" % sorted(freq.items(), key=lambda x: -x[1])[:25])

    font = os.path.join(os.path.dirname(matplotlib.__file__),
                        "mpl-data", "fonts", "ttf", "DejaVuSans-Bold.ttf")
    wc = WordCloud(width=1400, height=1400, background_color="white",
                   font_path=font, color_func=color_func, prefer_horizontal=0.75,
                   max_words=180, relative_scaling=0.5, margin=4,
                   random_state=20260914)
    wc.generate_from_frequencies(freq)
    out = sys.argv[1] if len(sys.argv) > 1 else "wordcloud_2019-2026.png"
    wc.to_file(out)
    print(out)

main()
