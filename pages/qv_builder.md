---
layout: page
intro_image_hide_on_mobile: true
show_call_box: false
---

<body>
<h1>QV builder</h1>
  <!-- 1. About -->
  <section>
    <p>Build a QV YAML by adding statement lines in a simple <code>key=value</code> format (quote values with spaces). Use <code>meta</code> for set info, <code>filters</code> and <code>criteria</code> for rules, and optional <code>notes</code>. The preview shows the structured YAML.</p>
  </section>

  <!-- 2. Examples (click to copy or insert) -->
  <section>
    <h3>Examples</h3>
    <p><small>Click an example to copy it.</small></p>
    <div id="examples" class="examples">
      <div class="copy-example" data-text='meta qv_set_id="qv_gwas_common_v1_20250827"'><code>meta qv_set_id="qv_gwas_common_v1_20250827"</code></div>
      <div class="copy-example" data-text='meta version="1.0.0"'><code>meta version="1.0.0"</code></div>
      <div class="copy-example" data-text='meta title="GWAS common QC"'><code>meta title="GWAS common QC"</code></div>
      <div class="copy-example" data-text='meta description="Common GWAS criteria expressed in tool-agnostic form"'><code>meta description="Common GWAS criteria expressed in tool-agnostic form"</code></div>
      <div class="copy-example" data-text='meta created="2025-08-27"'><code>meta created="2025-08-27"</code></div>
      <div class="copy-example" data-text='meta authors=Alice,Bob'><code>meta authors=Alice,Bob</code></div>
      <div class="copy-example" data-text='meta tags=GWAS,QC,PCA'><code>meta tags=GWAS,QC,PCA</code></div>
      <div class="copy-example" data-text='note "implementations are hints only"'><code>note "implementations are hints only"</code></div>
      <div class="copy-example" data-text='filter maf_minimum field=MAF operator=">=" value=0.01 desc="Minimum MAF"'><code>filter maf_minimum field=MAF operator=">=" value=0.01 desc="Minimum MAF"</code></div>
      <div class="copy-example" data-text='filter hwe field=HWE_P operator=">=" value=1e-6 logic=keep_if'><code>filter hwe field=HWE_P operator=">=" value=1e-6 logic=keep_if</code></div>
      <div class="copy-example" data-text='criteria pm2 field=gnomAD_AF operator="<" value=1e-6 logic=and desc="Absent or rare"'><code>criteria pm2 field=gnomAD_AF operator="<" value=1e-6 logic=and desc="Absent or rare"</code></div>
      <div class="copy-example" data-text='criteria ps5 field=IMPACT operator="==" value=HIGH desc="Comp het with HIGH"'><code>criteria ps5 field=IMPACT operator==" value=HIGH desc="Comp het with HIGH"</code></div>
      <div class="copy-example" data-text='criteria ps5 group_by=sample,SYMBOL count=">=2"'><code>criteria ps5 group_by=sample,SYMBOL count="&gt;=2"</code></div>
      <div class="copy-example" data-text='filter region_include desc="include panel" field=OVERLAP(targets.exome.bed) operator=">=" value=1 logic=keep_if'><code>filter region_include desc="include panel" field=OVERLAP(targets.exome.bed) operator="&gt;=" value=1 logic=keep_if</code></div>
      <div class="copy-example" data-text='criteria disease_panel logic=and desc="HIGH impact within panel"&#10;criteria disease_panel field=IMPACT operator="==" value=HIGH&#10;criteria disease_panel field=OVERLAP(targets.exome.bed) operator=">=" value=1'><code>criteria disease_panel logic=and desc="HIGH impact within panel"<br>criteria disease_panel field=IMPACT operator="==" value=HIGH<br>criteria disease_panel field=OVERLAP(targets.exome.bed) operator="&gt;=" value=1</code></div>
      <div class="copy-example" data-text='meta description_patient="There is a strong family history of early heart attacks. I would like clear information on any inherited cardiac risk and what I can do next."'><code>meta description_patient="There is a strong family history of early heart attacks. I would like clear information on any inherited cardiac risk and what I can do next."</code></div>
      <div class="copy-example" data-text='meta description_ppie="The PPIE working group reviewed the qualifying criteria and approved their recommendation document on 2025-08-15."'><code>meta description_ppie="The PPIE working group reviewed the qualifying criteria and approved the final protocol on 2025-08-15."</code></div>
      <div class="copy-example" data-text='criteria ACMG_PVS1 logic=and description="Null variants (IMPACT == HIGH) in genes where loss of function causes disease. Includes homozygous variants, compound heterozygous cases, or dominant inheritance. Warning to phase check compound heterozygosity."
        criteria ACMG_PVS1 field=IMPACT operator="==" value=HIGH
        criteria ACMG_PVS1 group=any_of:start
        criteria ACMG_PVS1 field=genotype operator="==" value=2
        criteria ACMG_PVS1 field=Inheritance operator="==" value=AD
        criteria ACMG_PVS1 field=comp_het_flag operator="==" value=1
        criteria ACMG_PVS1 group=any_of:end'><code>criteria ACMG_PVS1 logic=and description="Null variants (IMPACT == HIGH) in genes where loss of function causes disease. Includes homozygous variants, compound heterozygous cases, or dominant inheritance. Warning to phase check compound heterozygosity."
        criteria ACMG_PVS1 field=IMPACT operator="==" value=HIGH
        criteria ACMG_PVS1 group=any_of:start
        criteria ACMG_PVS1 field=genotype operator="==" value=2
        criteria ACMG_PVS1 field=Inheritance operator="==" value=AD
        criteria ACMG_PVS1 field=comp_het_flag operator="==" value=1
        criteria ACMG_PVS1 group=any_of:end</code></div>
  </div>
  </section>

<!-- 3. Add statement (full width, resizable textarea with wrapping) -->
<section>
  <h3>Add statement</h3>
  <textarea
    id="stmt"
    rows="6"
    wrap="soft"
    placeholder='e.g.
meta qv_set_id="qv_gwas_common_v1_20250827"
meta version="1.0.0"
note "implementation tools included are optional"'
    style="width:100%; padding:8px; font-family: ui-monospace, monospace; resize: vertical; white-space: pre-wrap; overflow-wrap: anywhere;"
  ></textarea>
  <div style="margin-top:6px;">
    <button onclick="addFromTextarea()">Add</button>
    <button onclick="resetAll()">Reset all</button>
  </div>
  <div id="error" class="error" style="color:red; margin-top:4px;"></div>
</section>


  <!-- 4. QV set YAML preview -->
  <section>
    <h3>YAML Preview</h3>
    <div style="outline: 1px solid #999; padding: 0.5em; border-radius: 6px;">
      <pre id="yaml" style="white-space:pre; overflow:auto; background:#f8f8f8; padding:0.5em; margin:0;"></pre>
      <div style="margin-top:6px;">
        <button onclick="copyYaml()">Copy</button>
        <button onclick="downloadYaml()">Download</button>
      </div>
    </div>
  </section>

  <!-- 5. Added lines -->
  <section>
    <h3>Added lines</h3>
    <p><small>Click a line to delete it.</small></p>
    <div id="chips" class="chips"></div>
  </section>

  <style>
    .examples { display:block; }
    .copy-example {
      border: 1px solid #ccc;
      border-radius: 6px;
      padding: 6px 8px;
      margin: 6px 0;
      cursor: pointer;
      background: #fafafa;
      user-select: none;
    }
    .copy-example:active { background:#f0f0f0; }
    .chips { display:block; }
    .chip {
      display:block;
      border: 1px dashed #999;
      border-radius: 6px;
      padding: 6px 8px;
      margin: 6px 0;
      cursor: pointer;
      background:#fff;
      font-family: ui-monospace, monospace;
      user-select: none;
    }
    code { font-family: ui-monospace, SFMono-Regular, Menlo, Consolas, monospace; }
  </style>

  <script src="https://cdn.jsdelivr.net/npm/js-yaml@4.1.0/dist/js-yaml.min.js"></script>
  <script>
    let lines = [];

    // examples: click copies, shift-click inserts
    document.addEventListener("click", (e) => {
      const el = e.target.closest(".copy-example");
      if (!el) return;
      const txt = el.getAttribute("data-text");
      navigator.clipboard?.writeText(txt);
      if (e.shiftKey) {
        try {
          parseLine(txt);
          lines.push(txt);
          render();
        } catch (err) {
          document.getElementById("error").textContent = err.message;
        }
      }
    });

    function addLine() {
      const stmt = document.getElementById("stmt").value.trim();
      if (!stmt) return;
      try {
        parseLine(stmt);
        lines.push(stmt);
        document.getElementById("stmt").value = "";
        document.getElementById("error").textContent = "";
        render();
      } catch (e) {
        document.getElementById("error").textContent = e.message;
      }
    }

    function resetAll() {
      lines = [];
      render();
    }

    function removeLine(i) {
      lines.splice(i,1);
      render();
    }

    <!-- function render() { -->
    <!--   // chips -->
    <!--   const chipsHtml = lines.map((l,i)=>`<div class="chip" title="Click to delete" onclick="removeLine(${i})">${escapeHtml(l)}</div>`).join(""); -->
    <!--   document.getElementById("chips").innerHTML = chipsHtml; -->
    <!---->
    <!--   // yaml -->
    <!--   const obj = buildYaml(lines); -->
    <!--   document.getElementById("yaml").textContent = jsyaml.dump(obj, { lineWidth: -1 }); -->
    <!-- } -->

    // simple head tokeniser
    function headTokens(line) {
      const m = line.trim().match(/^(\S+)(?:\s+(\S+))?(?:\s+(.*))?$/);
      if (!m) return [];
      return [m[1] || "", m[2] || "", m[3] || ""];
    }

    function parseLine(line) {
      const [kind] = headTokens(line);
      if (!kind) throw new Error("Empty line");
      if (!["meta","filter","criteria","note"].includes(kind))
        throw new Error("Unknown keyword: " + kind);
      // soft validation: prefer operator=".." not operator>=
      if (/operator[<>=]/.test(line) && !/operator\s*=\s*["']?[<>=]/.test(line)) {
        // still allow, normalise later
      }
      return true;
    }

    // key=value parser, normalises operator>= to operator=">="
    function parseKeyValsStr(rest) {
      const obj = {};
      let i = 0;

      const decodeOperatorEntity = (s) =>
        s.replace(/&lt;=?/g, m => m === "&lt;" ? "<" : "<=")
         .replace(/&gt;=?/g, m => m === "&gt;" ? ">" : ">=");

      const setKV = (k, v) => {
        if (!k) return;
        let key = k.trim();
        let val = v == null ? null : String(v).trim();

        // normalise bare operator forms like operator>=
        if (key.toLowerCase().startsWith("operator") && key.length > 8 && !val) {
          val = key.slice(8);
          key = "operator";
        }

        if (key === "desc") key = "description";
        if (key === "groupby") key = "group_by";

        if (val != null) {
          val = decodeOperatorEntity(val);
          // ensure operator is quoted
          if (key === "operator" && !/^["']/.test(val)) val = `"${val}"`;
          obj[key] = parseValue(val);
        } else {
          obj[key] = null;
        }
      };

      while (i < rest.length) {
        while (i < rest.length && /\s/.test(rest[i])) i++;
        if (i >= rest.length) break;

        if (!rest.slice(i).includes("=")) {
          const token = rest.slice(i).trim();
          if (token) setKV(token, null);
          break;
        }

        let kStart = i;
        while (i < rest.length && rest[i] !== "=" && !/\s/.test(rest[i])) i++;
        let key = rest.slice(kStart, i);

        while (i < rest.length && /\s/.test(rest[i])) i++;
        if (rest[i] !== "=") {
          const j = rest.indexOf(" ", kStart);
          const token = rest.slice(kStart, j === -1 ? rest.length : j);
          setKV(token, null);
          i = j === -1 ? rest.length : j + 1;
          continue;
        }
        i++; // '='

        while (i < rest.length && /\s/.test(rest[i])) i++;
        if (i >= rest.length) { setKV(key, ""); break; }

        let val = "";
        const quote = rest[i] === '"' || rest[i] === "'" ? rest[i] : null;
        if (quote) {
          i++;
          const start = i;
          while (i < rest.length && rest[i] !== quote) i++;
          val = rest.slice(start, i);
          if (i < rest.length && rest[i] === quote) i++;
          val = quote + val + quote;
        } else {
          const start = i;
          while (i < rest.length && !/\s/.test(rest[i])) i++;
          val = rest.slice(start, i);
        }

        setKV(key, val);
      }

      return obj;
    }

    function buildYaml(lines) {
      const out = {};
      const filters = {};
      const criteria = {};
      const notes = [];
      const meta = {};

      for (const line of lines) {
        const [kind, maybeLabel, restRaw] = headTokens(line);

        if (kind === "meta") {
          const rest = (maybeLabel ? maybeLabel + (restRaw ? " " + restRaw : "") : "").trim();
          if (!rest) continue;

          const eqIdx = rest.indexOf("=");
          if (eqIdx !== -1) {
            const kv = parseKeyValsStr(rest);
            Object.entries(kv).forEach(([k,v]) => meta[k] = v);
          } else {
            const sp = rest.split(/\s+/, 2);
            const k = sp[0];
            const v = sp.length === 2 ? sp[1] : "";
            meta[k] = parseValue(v);
          }
        }

        else if (kind === "note") {
          const raw = line.replace(/^note\s+/i,'').trim();
          notes.push(unquote(raw));
        }

        else if (kind === "filter") {
          const label = maybeLabel;
          if (!label) continue;
          filters[label] = filters[label] || {};
          const kv = parseKeyValsStr(restRaw || "");
          if (kv.description) { filters[label].description = kv.description; delete kv.description; }
          if (kv.logic){ filters[label].logic = kv.logic; delete kv.logic; }
          Object.assign(filters[label], kv);
        }

        else if (kind === "criteria") {
          const label = maybeLabel;
          if (!label) continue;
          criteria[label] = criteria[label] || { conditions: [] };
          const kv = parseKeyValsStr(restRaw || "");
          if (kv.description) { criteria[label].description = kv.description; delete kv.description; }
          if (kv.logic){ criteria[label].logic = kv.logic; delete kv.logic; }
          if (Object.keys(kv).length) criteria[label].conditions.push(kv);
        }
      }

      if (meta.qv_set_id) out.qv_set_id = meta.qv_set_id;
      if (meta.version)   out.version   = meta.version;
      if (meta.title)     out.title     = meta.title;
      if (meta.description) out.description = meta.description;

      const metaCopy = { ...meta };
      delete metaCopy.qv_set_id;
      delete metaCopy.version;
      delete metaCopy.title;
      delete metaCopy.description;
      if (Object.keys(metaCopy).length) out.metadata = metaCopy;

      if (Object.keys(filters).length) out.filters = filters;
      if (Object.keys(criteria).length) out.criteria = criteria;
      if (notes.length) out.notes = notes;

      return out;
    }

    function parseValue(v) {
      if (v === undefined || v === null) return null;
      const s = v.trim();

      if ((s.startsWith('"') && s.endsWith('"')) || (s.startsWith("'") && s.endsWith("'")))
        return s.slice(1,-1);

      if (/^(true|false)$/i.test(s)) return s.toLowerCase() === "true";
      if (s.toLowerCase() === "null") return null;

      if (/^-?\d+(\.\d+)?(e[+-]?\d+)?$/i.test(s)) return Number(s);

      if (s.includes(",")) return s.split(",").map(x => unquote(x.trim()));

      return s;
    }

    function unquote(t) {
      if ((t.startsWith('"') && t.endsWith('"')) || (t.startsWith("'") && t.endsWith("'")))
        return t.slice(1,-1);
      return t;
    }

    function copyYaml() {
      navigator.clipboard.writeText(document.getElementById("yaml").textContent);
    }

    function downloadYaml() {
      const obj = buildYaml(lines);
      const base = obj && obj.qv_set_id ? String(obj.qv_set_id) : "qv";
      const safe = base.replace(/[^A-Za-z0-9._-]/g, "_");
      const filename = `${safe}.yaml`;
    
      const content = jsyaml.dump(obj, { lineWidth: -1 });
      const blob = new Blob([content], { type: "text/yaml" });
      const a = document.createElement("a");
      a.href = URL.createObjectURL(blob);
      a.download = filename;
      a.click();
      URL.revokeObjectURL(a.href);
    }

    function escapeHtml(s) {
      return s.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;");
    }

    render();
  </script>

<!-- drop-in: add these helpers (below your other helpers) and replace render() -->

<script>
// helpers for human-friendly sorting of "Added lines"
function metaKeyWeight(k) {
  const order = ["qv_set_id","version","title","description","created","authors","tags"];
  const idx = order.indexOf(k);
  return idx === -1 ? 100 + (k || "").toLowerCase().charCodeAt(0) : idx;
}

function parseMetaKey(rest) {
  if (!rest) return "";
  const eq = rest.indexOf("=");
  if (eq !== -1) return rest.slice(0, eq).trim();
  const sp = rest.trim().split(/\s+/, 1);
  return sp[0] || "";
}

function getLineSortKey(line) {
  const [kind, label, rest] = headTokens(line);
  const cat = { meta: 0, filter: 1, criteria: 2, note: 3 }[kind] ?? 9;

  if (kind === "meta") {
    const metaRest = (label ? label + (rest ? " " + rest : "") : "");
    const k = parseMetaKey(metaRest);
    return `${String(cat).padStart(2,"0")}:${String(metaKeyWeight(k)).padStart(3,"0")}:${k.toLowerCase()}`;
  }
  if (kind === "filter") {
    return `${String(cat).padStart(2,"0")}:${(label || "").toLowerCase()}`;
  }
  if (kind === "criteria") {
    return `${String(cat).padStart(2,"0")}:${(label || "").toLowerCase()}`;
  }
  if (kind === "note") {
    return `${String(cat).padStart(2,"0")}:${(rest || line).toLowerCase()}`;
  }
  return `${String(cat)}:zzz:${line.toLowerCase()}`;
}

// Sorted display for added statement list 
function render() {
  // sorted chips but delete uses original indices
  const sorted = lines
    .map((l, idx) => ({ l, idx, key: getLineSortKey(l) }))
    .sort((a, b) => a.key.localeCompare(b.key));

  const chipsHtml = sorted
    .map(({ l, idx }) => `<div class="chip" title="Click to delete" onclick="removeLine(${idx})">${escapeHtml(l)}</div>`)
    .join("");
  document.getElementById("chips").innerHTML = chipsHtml;

  // yaml preview remains based on original lines order to preserve rule semantics
  const obj = buildYaml(lines);
  document.getElementById("yaml").textContent = jsyaml.dump(obj, { lineWidth: -1 });
}

// Helps multiline add statement entry
function addFromTextarea(){
  const ta = document.getElementById("stmt");
  const raw = ta.value;
  if (!raw.trim()) return;

  const linesIn = raw.split(/\r?\n/).map(s => s.trim()).filter(s => s.length > 0);

  for (const line of linesIn) {
    try {
      parseLine(line);
      lines.push(line);
    } catch (e) {
      document.getElementById("error").textContent = `${e.message}: ${line}`;
      render();
      return;
    }
  }

  ta.value = "";
  document.getElementById("error").textContent = "";
  render();
}
</script>


</body>

