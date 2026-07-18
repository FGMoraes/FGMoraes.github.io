/* ============================================================================
   pub_conferences.js  -  publication list: indexing, filtering and reporting
   ----------------------------------------------------------------------------
   Design
     - Every <li> is indexed once at load into ENTRIES: {el, conf, year, subjects}.
     - Subject, Year and Conference are three INDEPENDENT criteria; applyFilters()
       shows the intersection, so combinations such as "Csec + ISCAS" work.
     - Visibility is a CSS class (.is-hidden), never inline styles.
     - The Conference <select> is generated from the data, so it cannot go stale.
   Requires in the HTML:  .is-hidden { display: none; }
   ========================================================================== */

"use strict";

var ENTRIES = [];   // one record per <li>
var TOTAL   = 0;    // number of indexed entries
var $ = function (id) { return document.getElementById(id); };

/* ---------------------------------------------------------------- indexing */

function indexEntries() {
  ENTRIES = [];
  Array.prototype.forEach.call(
    document.querySelectorAll("ol[id^='ol'] > li"),
    function (li) {
      var m = li.textContent.match(/In:\s*([^,<]+),\s*(\d{4})/);
      ENTRIES.push({
        el:       li,
        conf:     m ? m[1].trim() : null,          // null: entry has no "In: X, YYYY"
        year:     m ? m[2] : li.parentNode.id.substring(2),
        subjects: li.className.split(/\s+/).filter(Boolean)
      });
    }
  );
  TOTAL = ENTRIES.length;
  return TOTAL;
}

/* --------------------------------------------------------------- filtering */

function applyFilters() {
  var s = $("subjectSelect").value;
  var y = $("yearSelect").value;
  var c = $("conferenceSelect").value;
  var filtered = (s !== "0" || y !== "0" || c !== "0");
  var shown = 0;

  ENTRIES.forEach(function (e) {
    var ok = (s === "0" || e.subjects.indexOf(s) !== -1) &&
             (y === "0" || e.year === y) &&
             (c === "0" || e.conf === c);
    e.el.classList.toggle("is-hidden", !ok);
    if (ok) shown++;
  });

  updateYearHeaders(filtered);
  updateCounterBar(filtered, shown, s, y, c);
  return shown;
}

/* A year header is visible only while that year still has a visible entry. */
function updateYearHeaders(filtered) {
  yearHeaders().forEach(function (h) {
    var ol = $("ol" + h.id.substring(1));
    if (!ol) return;
    var total   = ol.getElementsByTagName("li").length;
    var visible = ol.querySelectorAll("li:not(.is-hidden)").length;
    h.classList.toggle("is-hidden", visible === 0);
    h.textContent = filtered
      ? h.id.substring(1) + " (" + visible + " of " + total + ")"
      : h.id.substring(1) + " (" + total + " articles from " + TOTAL + ")";
  });
}

function updateCounterBar(filtered, shown, s, y, c) {
  var bar = $("confCount");
  if (!bar) return;
  if (!filtered) {
    bar.classList.add("is-hidden");
    bar.textContent = "";
    return;
  }
  var parts = [];
  if (s !== "0") parts.push(subjectLabel(s));
  if (c !== "0") parts.push(c);
  if (y !== "0") parts.push(y);
  bar.textContent = parts.join(" | ") + "  -  " + shown + " of " + TOTAL + " papers";
  bar.classList.remove("is-hidden");
}

function subjectLabel(value) {
  var opt = $("subjectSelect").querySelector('option[value="' + value + '"]');
  return opt ? opt.textContent.replace(/\s*\(\d+\)\s*$/, "").trim() : value;
}

function showAll() {
  $("subjectSelect").value    = "0";
  $("yearSelect").value       = "0";
  $("conferenceSelect").value = "0";
  applyFilters();
  window.scrollTo(0, 0);
}

/* ------------------------------------------------------- select population */

function yearHeaders() {
  return Array.prototype.filter.call(
    document.querySelectorAll("p.year"),
    function (el) { return el.id !== "confCount"; }
  );
}

function populateYearSelect() {
  var sel = $("yearSelect");
  if (!sel) return;
  while (sel.options.length > 1) sel.remove(1);

  var counts = {};
  ENTRIES.forEach(function (e) { counts[e.year] = (counts[e.year] || 0) + 1; });

  Object.keys(counts)
    .sort(function (a, b) { return Number(b) - Number(a); })   // newest first
    .forEach(function (y) {
      var o = document.createElement("option");
      o.value = y;
      o.textContent = y + " (" + counts[y] + ")";
      sel.appendChild(o);
    });
}

function populateConferenceSelect() {
  var sel = $("conferenceSelect");
  if (!sel) return;
  while (sel.options.length > 1) sel.remove(1);

  var counts = {};
  ENTRIES.forEach(function (e) { if (e.conf) counts[e.conf] = (counts[e.conf] || 0) + 1; });

  Object.keys(counts)
    .sort(function (a, b) { return counts[b] - counts[a] || a.localeCompare(b); })
    .forEach(function (name) {
      var o = document.createElement("option");
      o.value = name;
      o.textContent = name + " (" + counts[name] + ")";
      sel.appendChild(o);
    });
}

/* Append the entry count to each subject option label. */
function annotateSubjectSelect() {
  var sel = $("subjectSelect");
  if (!sel) return;
  var counts = {};
  ENTRIES.forEach(function (e) {
    e.subjects.forEach(function (s) { counts[s] = (counts[s] || 0) + 1; });
  });
  Array.prototype.forEach.call(sel.options, function (o) {
    if (o.value === "0") return;
    o.textContent = o.textContent.replace(/\s*\(\d+\)\s*$/, "") + " (" + (counts[o.value] || 0) + ")";
  });
}

/* -------------------------------------------------------------- PDF access */

function checkPassword(url) {
  var actualEncryptedArray = [432, 160, 72, 208, 240, 64, 704, 584, 600, 584, 576];
  var saved = sessionStorage.getItem("savedPassword");

  if (saved && arraysEqual(encrypt(saved), actualEncryptedArray)) {
    window.location = "../docs/papers/" + url + ".pdf";
    return;
  }

  var input = prompt("Please enter the password (or e-mail fernando.moraes@pucrs.br)");
  if (input === null) return;                       // user pressed Cancel

  if (arraysEqual(encrypt(input), actualEncryptedArray)) {
    sessionStorage.setItem("savedPassword", input);
    window.location = "../docs/papers/" + url + ".pdf";
  } else {
    alert("Incorrect password!");
  }
}

function arraysEqual(a, b) {
  if (a === b) return true;
  if (a == null || b == null || a.length !== b.length) return false;
  for (var i = 0; i < a.length; i++) if (a[i] !== b[i]) return false;
  return true;
}

function encrypt(plainText) {
  var out = [];
  for (var i = 0; i < plainText.length; i++) out.push((plainText.charCodeAt(i) ^ 123) << 3);
  return out;
}

/* ------------------------------------------------------------------ report */

function generateReport() {
  var byConf = {}, byYear = {}, noConf = 0;

  ENTRIES.forEach(function (e) {
    byYear[e.year] = (byYear[e.year] || 0) + 1;
    if (!e.conf) { noConf++; return; }
    if (!byConf[e.conf]) byConf[e.conf] = { n: 0, years: {} };
    byConf[e.conf].n++;
    byConf[e.conf].years[e.year] = true;
  });

  var lines = ["PUBLICATIONS BY CONFERENCE", ""];
  Object.keys(byConf)
    .sort(function (a, b) { return byConf[b].n - byConf[a].n || a.localeCompare(b); })
    .forEach(function (name) {
      var years = Object.keys(byConf[name].years).sort(function (a, b) { return Number(b) - Number(a); });
      lines.push((name + "               ").slice(0, 15) + " " +
                 String(byConf[name].n).padStart(3, " ") + "  [" + years.join(", ") + "]");
    });

  if (noConf) lines.push("", "(" + noConf + " entries carry no \"In: <conference>, <year>\" record)");

  var perYear = Object.keys(byYear)
    .sort(function (a, b) { return Number(a) - Number(b); })      // ascending for the chart
    .map(function (y) { return { year: y, n: byYear[y] }; });

  lines.push("", "PUBLICATIONS BY YEAR", "");
  perYear.slice().reverse().forEach(function (d) { lines.push(d.year + ": " + d.n); });
  lines.push("", "Total: " + TOTAL);

  renderReportWindow(lines.join("\n"), perYear);
}

function renderReportWindow(text, perYear) {
  var win = window.open("", "ReportWindow");
  if (!win) { alert("Pop-up blocked. Please allow pop-ups for this site."); return; }

  var doc = win.document;
  doc.open();
  doc.write('<!DOCTYPE html><html><head><meta charset="utf-8"><title>Conference Report</title>' +
    '<style>body{font-family:system-ui,-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;margin:16px}' +
    'h1{font-size:18px;margin:0 0 8px}' +
    'pre{font:12px/1.4 monospace;background:#f6f8fa;padding:12px;border-radius:8px;overflow:auto}' +
    'canvas{width:100%;height:360px;border:1px solid #ddd;border-radius:8px}' +
    '</style></head><body></body></html>');
  doc.close();

  var h1 = doc.createElement("h1");
  h1.textContent = "Conference Report & Yearly Publications (Total: " + TOTAL + ")";
  var canvas = doc.createElement("canvas");
  var pre = doc.createElement("pre");
  pre.textContent = text;

  doc.body.appendChild(h1);
  doc.body.appendChild(canvas);
  doc.body.appendChild(pre);

  drawBarChart(win, canvas, perYear.filter(function (d) { return d.n > 0; }));
}

function drawBarChart(win, canvas, data) {
  var ctx = canvas.getContext && canvas.getContext("2d");
  if (!ctx) { canvas.style.display = "none"; return; }   // canvas unsupported: keep the text report
  var dpr = win.devicePixelRatio || 1;
  canvas.width  = Math.round(canvas.clientWidth  * dpr);
  canvas.height = Math.round(canvas.clientHeight * dpr);
  ctx.setTransform(dpr, 0, 0, dpr, 0, 0);

  var W = canvas.clientWidth, H = canvas.clientHeight;
  if (!data.length) { ctx.font = "14px sans-serif"; ctx.fillText("No data.", 12, 24); return; }

  var padL = 48, padR = 16, padT = 24, padB = 56;
  var plotW = W - padL - padR, plotH = H - padT - padB;
  var maxY = Math.max.apply(null, data.map(function (d) { return d.n; }));
  var tick = Math.max(1, Math.ceil(maxY / 6));
  var gap = 6;
  var barW = Math.max(6, Math.floor((plotW - gap * (data.length - 1)) / data.length));

  ctx.clearRect(0, 0, W, H);
  ctx.strokeStyle = "#333"; ctx.lineWidth = 1;
  ctx.beginPath();
  ctx.moveTo(padL, padT); ctx.lineTo(padL, padT + plotH); ctx.lineTo(padL + plotW, padT + plotH);
  ctx.stroke();

  ctx.font = "12px sans-serif"; ctx.textAlign = "right"; ctx.textBaseline = "middle";
  for (var v = 0; v <= maxY; v += tick) {
    var yPos = padT + plotH - (v / maxY) * plotH;
    ctx.strokeStyle = "#e6e6e6";
    ctx.beginPath(); ctx.moveTo(padL, yPos); ctx.lineTo(padL + plotW, yPos); ctx.stroke();
    ctx.fillStyle = "#444"; ctx.fillText(String(v), padL - 6, yPos);
  }

  var x = padL;
  ctx.textAlign = "center";
  data.forEach(function (d) {
    var h = (d.n / maxY) * plotH;
    ctx.fillStyle = shadeFor(d.n, data);
    ctx.fillRect(x, padT + plotH - h, barW, h);

    ctx.fillStyle = "#000"; ctx.font = "10px sans-serif"; ctx.textBaseline = "bottom";
    ctx.fillText(String(d.n), x + barW / 2, padT + plotH - h - 2);

    ctx.textBaseline = "top";
    ctx.save();
    ctx.translate(x + barW / 2, padT + plotH + 6);
    ctx.rotate(-Math.PI / 4);
    ctx.textAlign = "right";
    ctx.fillText(d.year, 0, 0);
    ctx.restore();
    ctx.textAlign = "center";

    x += barW + gap;
  });

  ctx.font = "14px sans-serif"; ctx.fillStyle = "#111";
  ctx.textAlign = "left"; ctx.textBaseline = "top";
  ctx.fillText("Publications per Year", padL, 4);
}

/* Darker blue = more publications. */
function shadeFor(n, data) {
  var vals = data.map(function (d) { return d.n; });
  var min = Math.min.apply(null, vals), max = Math.max.apply(null, vals);
  var t = (max === min) ? 0.5 : (n - min) / (max - min);
  return "hsl(220 70% " + (85 - t * 50).toFixed(1) + "%)";
}

/* ------------------------------------------------------------------ startup */

document.addEventListener("DOMContentLoaded", function () {
  indexEntries();
  populateYearSelect();
  populateConferenceSelect();
  annotateSubjectSelect();
  applyFilters();          // no filter active: shows everything, fills year headers
});
