
/* --- extracted block #1 --- */
// ---- helpers ----
  function hideElements(nodeList) {
    nodeList.forEach(function(el){ el.style.visibility = "hidden"; el.style.display = "none"; });
  }
  function realYearHeaders() {
    var years = Array.from(document.querySelectorAll("p.year"));
    return years.filter(function(el){ return el.id !== "confCount"; });
  }

  // (1) ALL button
  function showAll() {
    var allItems = document.querySelectorAll("ol li");
    var years = realYearHeaders();
    var confCountBar = document.getElementById("confCount");

    // show everything
    allItems.forEach(function(el){ el.style.visibility = "visible"; el.style.display = "list-item"; });
    years.forEach(function(el){ el.style.visibility = "visible"; el.style.display = "block"; });

    // reset controls
    var subj = document.getElementById("subjectSelect");
    var year = document.getElementById("yearSelect");
    var conf = document.getElementById("conferenceSelect");
    if (subj) subj.value = "0";
    if (year) year.value = "0";
    if (conf) conf.value = "0";

    // hide conference counter
    if (confCountBar) { confCountBar.style.display = "none"; confCountBar.textContent = ""; }
  }

  // (2) Subject selector
  function selectSubject(val) {
    var PAPER_CLASSES = ["general","Cmpsoc","Csec","Cfault","Cenergy","Cnoc","CSDN","Cmapping","Cmigration","Cfpga","CRV5","CML"];
    var allItems = document.querySelectorAll("ol li");
    var years = realYearHeaders();
    var confCountBar = document.getElementById("confCount");

    if (val === "0") { showAll(); return; }

    // Reset other controls
    var year = document.getElementById("yearSelect"); if (year) year.value = "0";
    var conf = document.getElementById("conferenceSelect"); if (conf) conf.value = "0";

    // Hide years and counter bar, hide all items
    hideElements(years);
    if (confCountBar) { confCountBar.style.display = "none"; confCountBar.textContent = ""; }
    hideElements(allItems);

    // Show only items of the selected subject
    var idx = parseInt(val, 10);
    var cls = PAPER_CLASSES[idx];
    Array.from(document.getElementsByClassName(cls)).forEach(function(el){
      el.style.display = "list-item"; el.style.visibility = "visible";
    });
  }

  // (3) Year selector
  function selectYear(val) {
    var allItems = document.querySelectorAll("ol li");
    var years = realYearHeaders();
    var confCountBar = document.getElementById("confCount");

    if (val === "0") { showAll(); return; }

    // Reset other controls
    var subj = document.getElementById("subjectSelect"); if (subj) subj.value = "0";
    var conf = document.getElementById("conferenceSelect"); if (conf) conf.value = "0";

    // Hide all items and year headers
    hideElements(allItems);
    hideElements(years);

    // Show selected year header and its items
    var yearId = "a" + val;      // e.g., "2025" -> "a2025"
    var olId   = "ol" + val;     // e.g., "2025" -> "ol2025"
    var yhdr = document.getElementById(yearId);
    var ylist = document.getElementById(olId);
    if (yhdr) { yhdr.style.display = "block"; yhdr.style.visibility = "visible"; }
    if (ylist) {
      Array.from(ylist.getElementsByTagName("li")).forEach(function(el){
        el.style.display = "list-item"; el.style.visibility = "visible";
      });
    }

    // Hide conference counter
    if (confCountBar) { confCountBar.style.display = "none"; confCountBar.textContent = ""; }

    if (yhdr) { yhdr.scrollIntoView({ behavior: 'instant', block: 'start' }); }
  }

  // (4) Conference selector
  function selectConference(conf) {
    var allItems = document.querySelectorAll("ol li");
    var years = realYearHeaders();
    var confCountBar = document.getElementById("confCount");

    if (conf === "0") { showAll(); return; }

    // Reset other controls
    var subj = document.getElementById("subjectSelect"); if (subj) subj.value = "0";
    var year = document.getElementById("yearSelect"); if (year) year.value = "0";

    // Hide all items and years
    hideElements(allItems);
    hideElements(years);

    // Show only items containing "In: <conf>,"
    var match = "In: " + conf + ",";
    var count = 0;
    allItems.forEach(function(item){
      if (item.innerHTML.indexOf(match) !== -1) {
        item.style.display = "list-item";
        item.style.visibility = "visible";
        count++;
      }
    });

    // Update blue conference counter (before the list)
    if (confCountBar) {
      var total = getTotalArticles();
      confCountBar.textContent = conf + " (" + count + " articles from " + total + ")";
      confCountBar.style.display = "block";
      confCountBar.style.visibility = "visible";
    }
  }

  // ---- Counters ----
  function getTotalArticles() {
    var years = realYearHeaders();
    var total = 0;
    years.forEach(function(y){
      var ol = document.getElementById("ol" + y.id.substring(1));
      if (ol) total += ol.getElementsByTagName("li").length;
    });
    return total;
  }

  function countArticlesPerYear() {
    var years = realYearHeaders();
    var total = 0;
    years.forEach(function(y){
      var ol = document.getElementById("ol" + y.id.substring(1));
      if (ol) total += ol.getElementsByTagName("li").length;
    });
    years.forEach(function(y){
      var ol = document.getElementById("ol" + y.id.substring(1));
      if (ol) {
        var n = ol.getElementsByTagName("li").length;
        var baseText = y.textContent.split(" (")[0];
        y.textContent = baseText + " (" + n + " articles from " + total + ")";
      }
    });
  }

  // Populate "Year" select dynamically
  function populateYearSelect() {
    var sel = document.getElementById("yearSelect");
    if (!sel) return;
    var years = realYearHeaders().map(function(y){ return y.id.substring(1); })
                 .sort(function(a,b){ return b.localeCompare(a); });
    while (sel.options.length > 1) sel.remove(1);
    years.forEach(function(y){
      var opt = document.createElement("option");
      opt.value = y;
      opt.textContent = " " + y + " ";
      sel.appendChild(opt);
    });
  }

  window.onload = function() {
    countArticlesPerYear();
    populateYearSelect();
    showAll();
  };


      // ####################################################################################-
    function checkPassword(url) {
           const actualEncryptedArray = [432, 160, 72, 208, 240, 64, 704, 584, 600, 584, 576];
           let savedPassword = sessionStorage.getItem("savedPassword");
       
           if (savedPassword) {
               const encryptedSavedPassword = encrypt(savedPassword);
               if (arraysEqual(encryptedSavedPassword, actualEncryptedArray)) {
                   window.location = "../docs/papers/" + url + ".pdf";
                   return;
               }
           }
       
           let input = prompt("Please enter the password (or e-mail to fernando.moraes@pucrs.br");
           const encryptedInput = encrypt(input);
       
           if (arraysEqual(encryptedInput, actualEncryptedArray)) {
               sessionStorage.setItem("savedPassword", input);
               window.location = "../docs/papers/" + url + ".pdf";
           } else {
               alert("Incorrect password!");
           }
    }

    // ####################################################################################-
    function arraysEqual(a, b) {
          if (a === b) return true;
          if (a == null || b == null) return false;
          if (a.length !== b.length) return false;
      
          for (let i = 0; i < a.length; i++) {
              if (a[i] !== b[i]) return false;
          }
          return true;
    }

    // ####################################################################################-
    function encrypt(plainText) {
          let encrypted = [];
          for (let i = 0; i < plainText.length; i++) {
              let charCode = plainText.charCodeAt(i);
              charCode = (charCode ^ 123) << 3;
              encrypted.push(charCode);
          }
          return encrypted;
    }

  function generateReport() {
    // Helper: escape a string for use inside RegExp
    function escapeRegex(s) {
      return s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
    }

    // Build conference name list from the <select>
    var confSelect = document.getElementById("conferenceSelect");
    if (!confSelect) { alert("conferenceSelect not found."); return; }
    var seen = new Set();
    var conferences = [];
    Array.from(confSelect.options).forEach(opt => {
      var rawVal = (opt.value || "").trim();
      var label  = (opt.textContent || "").trim();
      if (!rawVal) return;
      if (rawVal.toUpperCase() === "0" || rawVal.toUpperCase() === "ALL" || label.toUpperCase().includes("ALL")) return;
      var id = Number.parseInt(rawVal, 10);
      var name = null;
      if (!Number.isNaN(id)) {
        if (typeof CONF_MAP !== "undefined" && CONF_MAP && CONF_MAP[id]) {
          name = CONF_MAP[id];
        } else {
          name = label;
        }
      } else {
        name = rawVal || label;
      }
      if (name && !seen.has(name)) { seen.add(name); conferences.push(name); }
    });

    // Collect all items once
    var allItems = Array.from(document.querySelectorAll("ol li"));
    var lines = [];

    // --- Section 1: Publications by conference ---
    conferences.forEach(confName => {
      var count = 0;
      var yearsSet = new Set();
      var confPattern = new RegExp("In:\\s*" + escapeRegex(confName) + ",\\s*(\\d{4})");
      allItems.forEach(item => {
        var txt = item.textContent || "";
        var m = txt.match(confPattern);
        if (m) { count++; yearsSet.add(m[1]); }
      });
      if (count > 0) {
        var years = Array.from(yearsSet).sort((a, b) => b.localeCompare(a));
        var confFixed = (confName + "               ").slice(0, 15);
        var countStr  = String(count).padStart(2, " ");
        lines.push(confFixed + " " + countStr + " [" + years.join(", ") + "]");
      }
    });

    // --- Section 2: Publications by year (data for chart) ---
    var yearHeaders = Array.from(document.querySelectorAll("p.year"))
      .filter(el => el.id !== "confCount");
    var perYear = [];
    var grandTotal = 0;
    yearHeaders.forEach(yh => {
      var y = yh.id.substring(1); // drop leading 'a'
      var ol = document.getElementById("ol" + y);
      var n = ol ? ol.getElementsByTagName("li").length : 0;
      grandTotal += n;
      perYear.push({ year: y, n: n });
    });
    perYear.sort((a, b) => a.year.localeCompare(b.year)); // ascending on X

    lines.push("");
    lines.push("Publicações por ano:");
    perYear.slice().sort((a,b)=>b.year.localeCompare(a.year)).forEach(({ year, n }) => { lines.push(year + ": " + n); });
    lines.push("Total: " + grandTotal);

    // --- Render popup with chart + report ---
    var reportWin = window.open("", "ReportWindow");
    if (!reportWin) { alert("Pop-up blocked. Please allow pop-ups for this site."); return; }
    var doc = reportWin.document;
    doc.open();
    doc.write('<!DOCTYPE html><html><head><meta charset="utf-8"><title>Conference Report</title>' +
      '<style>body{font-family:system-ui,-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;margin:16px}'+
      'h1{font-size:18px;margin:0 0 8px} .row{display:flex;gap:24px;align-items:flex-start;flex-wrap:wrap}'+
      '.box{flex:1 1 520px;min-width:320px} pre{font:12px/1.4 monospace;background:#f6f8fa;padding:12px;border-radius:8px;overflow:auto;max-height:70vh}'+
      'canvas{width:100%;height:360px;max-height:60vh;border:1px solid #ddd;border-radius:8px}'+
      '.note{font-size:12px;color:#555;margin-top:6px}'+
      '</style></head><body></body></html>');
    doc.close();

    // Layout
    var h1 = doc.createElement("h1"); h1.textContent = "Conference Report & Yearly Publications";
    var row = doc.createElement("div"); row.className = "row";
    row.style.flexDirection = "column";   // <-- add this line
    var chartBox = doc.createElement("div"); chartBox.className = "box";
    var preBox = doc.createElement("div"); preBox.className = "box";
    var canvas = doc.createElement("canvas"); canvas.width = 1200; canvas.height = 450; // DPR-safe sizing handled below
    var note = doc.createElement("div"); note.className = "note"; note.textContent = "X: year  |  Y: number of publications";
    var pre = doc.createElement("pre"); pre.textContent = lines.join("\n");

    chartBox.appendChild(canvas);
    chartBox.appendChild(note);
    preBox.appendChild(pre);
    row.appendChild(chartBox);
    row.appendChild(preBox);
    doc.body.appendChild(h1);
    doc.body.appendChild(row);

    // --- Draw column chart (vanilla Canvas, colored bars) ---
    (function drawBarChart() {
      var ctx = canvas.getContext("2d");
      // Handle HiDPI
      var dpr = reportWin.devicePixelRatio || 1;
      var cssW = canvas.clientWidth, cssH = canvas.clientHeight;
      if (canvas.width !== Math.round(cssW * dpr)) {
        canvas.width  = Math.round(cssW * dpr);
        canvas.height = Math.round(cssH * dpr);
      }
      ctx.setTransform(dpr, 0, 0, dpr, 0, 0); // logical coords in CSS pixels

      // Data
      var data = perYear.filter(d => d.n > 0);
      if (data.length === 0) { ctx.font = "14px sans-serif"; ctx.fillText("No data.", 12, 24); return; }

      // Geometry
      var padL = 48, padR = 16, padT = 20, padB = 64;
      var W = canvas.clientWidth, H = canvas.clientHeight;
      var plotW = W - padL - padR, plotH = H - padT - padB;

      // Scales
      var maxY = Math.max.apply(null, data.map(d => d.n));
      var yTick = Math.max(1, Math.ceil(maxY / 6));
      var barGap = 12;
      var barW = Math.max(10, Math.floor((plotW - barGap*(data.length-1)) / data.length));

      // Axes
      ctx.clearRect(0, 0, W, H);
      ctx.strokeStyle = "#333"; ctx.lineWidth = 1;
      // Y axis
      ctx.beginPath();
      ctx.moveTo(padL, padT);
      ctx.lineTo(padL, padT + plotH);
      ctx.lineTo(padL + plotW, padT + plotH);
      ctx.stroke();

      // Grid + Y labels
      ctx.font = "12px sans-serif"; ctx.fillStyle = "#222";
      ctx.textAlign = "right"; ctx.textBaseline = "middle";
      for (var y = 0; y <= maxY; y += yTick) {
        var yPos = padT + plotH - (y / maxY) * plotH;
        ctx.strokeStyle = "#e6e6e6";
        ctx.beginPath(); ctx.moveTo(padL, yPos); ctx.lineTo(padL + plotW, yPos); ctx.stroke();
        ctx.fillStyle = "#444"; ctx.fillText(String(y), padL - 6, yPos);
      }

      // Bars + X labels
      var x = padL;
      ctx.textAlign = "center"; ctx.textBaseline = "top";
      data.forEach(function(d, i){
        // Color palette (distinct hues)
        var hue = Math.round((i / data.length) * 300); // 0..300
        ctx.fillStyle = "hsl(" + hue + " 70% 50%)";
        var h = (d.n / maxY) * plotH;
        ctx.fillRect(x, padT + plotH - h, barW, h);

        // Value label
        ctx.fillStyle = "#000";
        ctx.font = "11px sans-serif";
        ctx.textBaseline = "bottom";
        ctx.fillText(String(d.n), x + barW/2, padT + plotH - h - 2);

        // X tick
        ctx.textBaseline = "top";
        ctx.save();
        ctx.translate(x + barW/2, padT + plotH + 6);
        ctx.rotate(-Math.PI/8); // slight tilt for readability
        ctx.fillText(d.year, 0, 0);
        ctx.restore();

        x += barW + barGap;
      });

      // Title
      ctx.font = "14px sans-serif"; ctx.fillStyle = "#111"; ctx.textAlign = "left"; ctx.textBaseline = "top";
      ctx.fillText("Publications per Year", padL, 4);
    })();
  }
