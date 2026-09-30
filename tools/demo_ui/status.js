/* Панель состояния: дёргает /api/status каждые 15 с. Никаких моделей не грузит. */
"use strict";

const $ = (id) => document.getElementById(id);
const root = document.documentElement;
function applyTheme(mode) {
  root.classList.toggle("dark", mode === "dark");
  $("themeBtn").textContent = mode === "dark" ? "☀️" : "🌙";
  try { localStorage.setItem("omni-theme", mode); } catch (e) {}
}
applyTheme(localStorage.getItem("omni-theme") || "dark");
$("themeBtn").onclick = () => applyTheme(root.classList.contains("dark") ? "light" : "dark");

const dot = (on) => on
  ? '<span class="inline-block w-2 h-2 rounded-full bg-emerald-500 mr-1.5"></span>'
  : '<span class="inline-block w-2 h-2 rounded-full bg-slate-400/40 mr-1.5"></span>';

const fmtLoss = (v) => (v == null ? "—" : v === 0 ? "0 (сошёлся)" : v.toExponential(2));

function row(cells, right) {
  return `<tr class="border-b border-slate-100 dark:border-[#202836]">${
    cells.map((c, i) => `<td class="py-1.5 pr-3 ${i === 0 ? "font-medium" : ""}">${c}</td>`).join("")}</tr>`;
}

async function refresh() {
  let s;
  try { s = await (await fetch("/api/status")).json(); }
  catch (e) { $("updated").textContent = "нет связи с сервером"; return; }

  $("env").innerHTML = [
    `GPU: <b>${s.environment.gpu || "—"}</b> (${s.environment.vram_gb ?? "?"} GiB VRAM)`,
    `CUDA: ${s.environment.cuda ? "доступна" : "нет"} · torch ${s.environment.torch}`,
    `OpenSCAD: ${s.environment.openscad === "present" ? "есть (manifold)" : "<b>нет</b>"}`,
    `Рабочая точка: <code>zero_point</code> ${s.zero_point === "present" ? "цел ✓" : "<b>ОТСУТСТВУЕТ</b>"}`,
  ].map((x) => `<li>${x}</li>`).join("");

  $("proc").innerHTML = [
    ...Object.entries(s.processes).map(([k, v]) => `<li>${dot(v)}${k}</li>`),
    `<li class="pt-1 text-slate-400">ветка ${s.git.branch} · commit ${s.git.commit} · грязных файлов: ${s.git.uncommitted}</li>`,
  ].join("");

  const c = s.corpus || {};
  $("corpus").innerHTML = c.combined_v6 == null
    ? "сводный корпус не найден"
    : `<div class="flex flex-wrap gap-x-6 gap-y-1">
        <span><b>${c.combined_v6}</b> строк v6</span>
        ${Object.entries(c.layers || {}).map(([k, v]) => `<span>${k}: <b>${v}</b></span>`).join("")}
        <span>сплит: ${c.train}/${c.validation}/${c.test}</span>
        <span>voxel-grids: ${c.voxel_grids}</span>
      </div>`;

  $("trained").innerHTML = Object.keys(s.trained).length
    ? Object.entries(s.trained).map(([layer, t]) =>
        row([layer, t.step, fmtLoss(t.lm_loss), fmtLoss(t.aux_loss), `<span class="text-slate-400">${t.data || ""}</span>`]))
      .join("")
    : row(["<i>нет обученных слоёв</i>", "", "", "", ""]);

  $("evals").innerHTML = s.evals.length
    ? s.evals.map((e) => row([
        e.name, e.rows,
        `<b>${e.compiled}</b> (${e.rows ? Math.round((100 * e.compiled) / e.rows) : 0}%)`,
        `${e.watertight} (${e.rows ? Math.round((100 * e.watertight) / e.rows) : 0}%)`,
        e.bbox_mean != null ? (e.bbox_mean * 100).toFixed(1) + "%" : "—",
      ])).join("")
    : row(["<i>eval-артефактов нет</i>", "", "", "", ""]);

  $("updated").textContent = "обновлено " + new Date().toLocaleTimeString();
}

refresh();
setInterval(refresh, 15000);
