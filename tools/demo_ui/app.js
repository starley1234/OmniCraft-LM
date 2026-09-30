/* OmniCraft-LM demo UI: AJAX + three.js STL viewer + day/night. Все библиотеки локальные (/vendor). */
"use strict";

const $ = (id) => document.getElementById(id);

// ---------- тема ----------
const root = document.documentElement;
function applyTheme(mode) {
  root.classList.toggle("dark", mode === "dark");
  $("themeBtn").textContent = mode === "dark" ? "☀️" : "🌙";
  try { localStorage.setItem("omni-theme", mode); } catch (e) {}
  if (window.__sceneSetTheme) window.__sceneSetTheme(mode);
}
applyTheme(localStorage.getItem("omni-theme") || "dark");
$("themeBtn").onclick = () =>
  applyTheme(root.classList.contains("dark") ? "light" : "dark");

// ---------- примеры ----------
const CANVAS_COLOR = {
  voxel: "bg-emerald-600/15 text-emerald-700 dark:text-emerald-400",
  wire: "bg-amber-600/15 text-amber-700 dark:text-amber-400",
  sketch: "bg-purple-600/15 text-purple-700 dark:text-purple-400",
  brep: "bg-slate-600/15 text-slate-600 dark:text-slate-300",
  assembly: "bg-cyan-600/15 text-cyan-700 dark:text-cyan-400",
  auto: "bg-blue-600/15 text-blue-700 dark:text-blue-400",
};

async function loadExamples() {
  const data = await (await fetch("/api/examples")).json();
  $("trainedNote").textContent = data.trained.length ? data.trained.join(", ") : "нет (zero point)";
  const sel = $("canvas");
  data.canvases.forEach((c) => sel.add(new Option(c + (data.trained.includes(c) ? " ✓" : " ◦ zero"), c)));
  sel.add(new Option("auto (из текста)", "auto"));
  const box = $("examples");
  data.examples.forEach((ex) => {
    const b = document.createElement("button");
    b.className = `chip px-3 py-1.5 rounded-lg text-sm text-left ${CANVAS_COLOR[ex.canvas] || CANVAS_COLOR.auto}`;
    b.title = ex.prompt;
    b.innerHTML = `<span class="opacity-60 mr-1">[${ex.canvas}]</span>${ex.label}`;
    b.onclick = () => { $("prompt").value = ex.prompt; $("canvas").value = ex.canvas; generate(); };
    box.appendChild(b);
  });
}

// ---------- 3D-вьювер ----------
let scene, camera, renderer, controls, meshObj;
function initViewer() {
  const canvas = $("stlView");
  renderer = new THREE.WebGLRenderer({ canvas, antialias: true });
  scene = new THREE.Scene();
  camera = new THREE.PerspectiveCamera(45, 2, 0.1, 5000);
  camera.position.set(120, 90, 140);
  const hemi = new THREE.HemisphereLight(0xffffff, 0x334455, 0.9);
  const dir = new THREE.DirectionalLight(0xffffff, 0.6); dir.position.set(1, 1.4, 1);
  scene.add(hemi, dir);
  const grid = new THREE.GridHelper(200, 20, 0x5b6472, 0x394150); grid.name = "grid";
  scene.add(grid);
  controls = new THREE.OrbitControls(camera, canvas);
  window.__sceneSetTheme = (mode) => {
    scene.background = new THREE.Color(mode === "dark" ? 0x0b0e14 : 0xf1f5f9);
    grid.material.opacity = mode === "dark" ? 1 : 0.5;
  };
  window.__sceneSetTheme(root.classList.contains("dark") ? "dark" : "light");
  (function loop() {
    const w = canvas.parentElement.clientWidth, h = canvas.parentElement.clientHeight;
    if (canvas.width !== w || canvas.height !== h) {
      renderer.setSize(w, h, false); camera.aspect = w / h; camera.updateProjectionMatrix();
    }
    controls.update(); renderer.render(scene, camera);
    requestAnimationFrame(loop);
  })();
}
function showStl(url) {
  new THREE.STLLoader().load(url, (geometry) => {
    geometry.computeBoundingBox();
    const bb = geometry.boundingBox;
    const c = new THREE.Vector3(); bb.getCenter(c);
    const size = bb.getSize(new THREE.Vector3()).length() || 1;
    if (meshObj) scene.remove(meshObj);
    meshObj = new THREE.Mesh(geometry, new THREE.MeshStandardMaterial({ color: 0x7fb4ff, metalness: 0.25, roughness: 0.55 }));
    meshObj.position.copy(c).negate();
    scene.add(meshObj);
    controls.target.set(0, 0, 0);
    camera.position.set(size * 0.8, size * 0.6, size * 0.9);
    $("stlView").classList.remove("hidden"); $("pngView").classList.add("hidden");
    $("viewerHint").style.display = "none";
  });
}
function showPng(url) {
  $("pngView").src = url;
  $("pngView").classList.remove("hidden"); $("stlView").classList.add("hidden");
  $("viewerHint").style.display = "none";
}
initViewer();

// ---------- генерация ----------
function badge(ok, text) {
  const cls = ok === true ? "bg-emerald-600/15 text-emerald-600 dark:text-emerald-400"
            : ok === false ? "bg-red-600/15 text-red-600 dark:text-red-400"
            : "bg-slate-500/15 text-slate-500";
  return `<span class="px-2.5 py-1 rounded-md text-sm font-medium ${cls}">${text}</span>`;
}

async function generate() {
  const prompt = $("prompt").value.trim();
  if (!prompt) return;
  $("genBtn").disabled = true; $("spinner").classList.remove("hidden"); $("spinner").classList.add("inline-flex");
  $("elapsed").textContent = "";
  const t0 = performance.now();
  try {
    const res = await fetch("/api/generate", {
      method: "POST", headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ prompt, canvas: $("canvas").value }),
    });
    const r = await res.json();
    if (r.error) { alert("Ошибка: " + r.error); return; }
    $("elapsed").textContent = `${r.elapsed_s.toFixed(1)} с · холст: ${r.canvas}`;
    $("specs").textContent = r.specs_text;
    $("code").textContent = r.code || "(код не извлечён из вывода модели)";
    $("verdict").innerHTML =
      r.compiled === true ? badge(true, "VALID — manifold собрал меш")
    : r.compiled === false ? badge(false, "OPENSCAD ОТКЛОНИЛ")
    : badge(null, "OpenSCAD недоступен — вердикт по заголовку");
    const rows = [];
    if (r.bbox) rows.push(`bbox: ${r.bbox.map((v) => v.toFixed(1)).join(" × ")} мм (цель ${r.bbox_target.map((v) => v.toFixed(1)).join(" × ")})`);
    if (r.bbox_rel_err != null) rows.push(`отклонение bbox: ${(r.bbox_rel_err * 100).toFixed(1)}% ${r.bbox_rel_err <= 0.15 ? "✓ ≤15%" : "✗ >15%"}`);
    if (r.watertight != null) rows.push(`watertight: ${r.watertight ? "да" : "нет"} · компонент: ${r.components_count ?? "?"}`);
    if (r.compile_log) rows.push(`log: ${r.compile_log}`);
    rows.push(`код: ${r.code_chars} символов`);
    $("metrics").innerHTML = rows.map((x) => `<li>${x}</li>`).join("");
    $("result").classList.remove("hidden");
    if (r.stl) showStl("/model/" + r.stl);
    else if (r.png) showPng("/preview/" + r.png);
    else { $("viewerHint").style.display = "flex"; $("viewerHint").textContent = "меш не собран — смотрите код и вердикт"; }
    loadHistory();
  } finally {
    $("genBtn").disabled = false; $("spinner").classList.add("hidden"); $("spinner").classList.remove("inline-flex");
  }
}
$("genBtn").onclick = generate;
$("prompt").addEventListener("keydown", (e) => { if (e.key === "Enter" && e.ctrlKey) generate(); });

$("copyBtn").onclick = async () => {
  await navigator.clipboard.writeText($("code").textContent);
  $("copyBtn").textContent = "скопировано ✓"; setTimeout(() => ($("copyBtn").textContent = "копировать код"), 1200);
};

// ---------- история ----------
async function loadHistory() {
  const h = await (await fetch("/api/history")).json();
  if (!h.items.length) return;
  $("historySection").classList.remove("hidden");
  $("history").innerHTML = h.items.map((it) => `
    <button class="text-left text-sm px-3 py-2 rounded-lg hover:bg-slate-500/10 flex items-center gap-2" onclick='restore(${JSON.stringify(it.prompt)}, "${it.canvas}")'>
      ${badge(it.compiled === true, it.canvas)}<span class="truncate">${it.prompt}</span><span class="ml-auto text-xs text-slate-400">${it.elapsed_s.toFixed(0)}с</span>
    </button>`).join("");
}
function restore(prompt, canvas) { $("prompt").value = prompt; if (canvas) $("canvas").value = canvas; $("prompt").focus(); }

loadExamples(); loadHistory();
