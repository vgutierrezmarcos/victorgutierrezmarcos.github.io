#!/usr/bin/env node
// Prueba la pizarra de la versión web con un lápiz simulado, sin iPad: abre
// la app en un Chrome sin ventana (CDP), llega a la pizarra de practicar e
// inyecta en el DOM los eventos de puntero que manda Safari con el Apple
// Pencil, incluidos los que el navegador se traga al escribir deprisa
// (Scribble). Cuenta los trazos con el registro de la pizarra (?depurar=1).
//
//   node scripts/pizarra-cdp.mjs [--base /app/abrir/] [--captura salida.png] [--chrome ruta]
//
// Escenarios: A) cinco letras completas → 5 trazos; B) una letra sin
// pointerup y otra normal → 2 (sin el arreglo, 1 con una raya diagonal);
// C) pointerleave con buttons=0 antes del pointerup → 2; D) pointercancel → 1.
// Sale con código 1 si algún escenario no cuadra. Sirve el repositorio en
// 127.0.0.1:8765 (la app lee el contenido del mismo origen).
import { spawn } from 'node:child_process';
import { mkdtempSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';

const args = process.argv.slice(2);
const opcion = (nombre, porDefecto) => {
  const i = args.indexOf(nombre);
  return i >= 0 ? args[i + 1] : porDefecto;
};
const base = opcion('--base', '/app/abrir/');
const captura = opcion('--captura', null);
const chrome = opcion('--chrome', join(process.env.HOME, '.cache/hyperframes/chrome/chrome-headless-shell/linux-152.0.7977.30/chrome-headless-shell-linux64/chrome-headless-shell'));
const raiz = join(fileURLToPath(import.meta.url), '..', '..');
const puertoWeb = 8765;
const puertoCdp = 9333;

const espera = (ms) => new Promise((r) => setTimeout(r, ms));

// ------------------------------------------------------------ Servidor y Chrome
const servidor = spawn('python3', ['-m', 'http.server', String(puertoWeb), '--bind', '127.0.0.1'], { cwd: raiz, stdio: 'ignore' });
const perfil = mkdtempSync(join(tmpdir(), 'pizarra-cdp-'));
const navegador = spawn(chrome, [
  '--headless', '--no-sandbox', '--disable-gpu-sandbox', '--enable-unsafe-swiftshader', '--use-angle=swiftshader',
  `--remote-debugging-port=${puertoCdp}`, `--user-data-dir=${perfil}`, '--window-size=1200,800',
  '--ignore-certificate-errors', 'about:blank',
], { stdio: 'ignore', env: { ...process.env, LD_LIBRARY_PATH: `${process.env.HOME}/.local/share/chrome-libs/root/usr/lib/x86_64-linux-gnu:${process.env.LD_LIBRARY_PATH ?? ''}` } });
const cerrar = () => {
  navegador.kill();
  servidor.kill();
};
process.on('exit', cerrar);

async function conectar() {
  for (let i = 0; i < 50; i++) {
    try {
      const lista = await (await fetch(`http://127.0.0.1:${puertoCdp}/json`)).json();
      const pagina = lista.find((t) => t.type === 'page');
      if (pagina) return pagina.webSocketDebuggerUrl;
    } catch (_) {}
    await espera(200);
  }
  throw new Error('Chrome no responde en el puerto de depuración');
}

// Cliente CDP mínimo.
const ws = new WebSocket(await conectar());
await new Promise((ok, ko) => {
  ws.onopen = ok;
  ws.onerror = ko;
});
let siguienteId = 0;
const pendientes = new Map();
const consola = [];
ws.onmessage = (ev) => {
  const m = JSON.parse(ev.data);
  if (m.id && pendientes.has(m.id)) {
    const { ok, ko } = pendientes.get(m.id);
    pendientes.delete(m.id);
    m.error ? ko(new Error(m.error.message)) : ok(m.result);
  } else if (m.method === 'Runtime.consoleAPICalled') {
    consola.push(m.params.args.map((a) => a.value ?? a.description ?? '').join(' '));
  }
};
const cdp = (method, params = {}) => new Promise((ok, ko) => {
  const id = ++siguienteId;
  pendientes.set(id, { ok, ko });
  ws.send(JSON.stringify({ id, method, params }));
});
const js = async (expresion) => {
  const r = await cdp('Runtime.evaluate', { expression: expresion, awaitPromise: true, returnByValue: true });
  if (r.exceptionDetails) throw new Error(r.exceptionDetails.exception?.description ?? JSON.stringify(r.exceptionDetails));
  return r.result.value;
};
async function hasta(expresion, ms, descripcion) {
  const fin = Date.now() + ms;
  while (Date.now() < fin) {
    if (await js(expresion)) return;
    await espera(250);
  }
  // Para saber qué había en pantalla: captura y los nodos pulsables.
  const ruta = join(process.env.CLAUDE_SCRATCHPAD ?? tmpdir(), 'pizarra-fallo.png');
  writeFileSync(ruta, Buffer.from((await cdp('Page.captureScreenshot', { format: 'png' })).data, 'base64'));
  const nodos = await js(`[...document.querySelectorAll('flt-semantics')].filter((el) => el.hasAttribute('flt-tappable') || /Cant/.test(el.getAttribute('aria-label') + el.textContent)).map((el) => (el.getAttribute('role') || '') + ' ' + (el.hasAttribute('flt-tappable') ? 'T' : '-') + ' ' + ((el.getAttribute('aria-label') || '') + ' | ' + el.textContent).trim().slice(0, 60))`);
  console.log(`Pulsables: ${JSON.stringify(nodos)}\nCaptura en ${ruta}`);
  throw new Error(`Esperando ${descripcion}`);
}

await cdp('Page.enable');
await cdp('Runtime.enable');

// ------------------------------------------------------------ Abrir la app
const origen = `http://127.0.0.1:${puertoWeb}`;
// Antes de que arranque la app, en una página del mismo origen, se deja en
// Hive (IndexedDB «app», store «box») la oposición elegida y la bienvenida
// vista, para no pasar por esas pantallas.
await cdp('Page.navigate', { url: `${origen}${base}version.json` });
await espera(500);
await js(`new Promise((ok, ko) => {
  const r = indexedDB.open('app', 1);
  r.onupgradeneeded = () => r.result.createObjectStore('box');
  r.onsuccess = () => {
    const tx = r.result.transaction('box', 'readwrite');
    const s = tx.objectStore('box');
    s.put('tcee', 'oposicion');
    s.put(true, 'bienvenida_vista');
    tx.oncomplete = () => { r.result.close(); ok(true); };
    tx.onerror = () => ko(tx.error);
  };
  r.onerror = () => ko(r.error);
})`);
await cdp('Page.navigate', { url: `${origen}${base}?depurar=1#/cantes` });
await hasta(`!!document.querySelector('flutter-view') && !document.getElementById('carga')`, 120000, 'la app');
await espera(2000);

// Con la semántica activada, los botones se pueden pulsar por su texto.
await js(`(() => { const p = document.querySelector('flt-semantics-placeholder'); if (p) p.click(); return !!p; })()`);
const tocar = (texto) => `(() => {
  const todos = [...document.querySelectorAll('flt-semantics, [flt-tappable]')];
  const vale = (el) => ((el.getAttribute('aria-label') || '') + ' ' + el.textContent).includes(${JSON.stringify(texto)});
  const cand = todos.filter((el) => el.hasAttribute('flt-tappable') && vale(el));
  if (!cand.length) return false;
  cand.sort((a, b) => a.textContent.length - b.textContent.length);
  cand[0].click();
  return true;
})()`;
// Un clic de ratón en un punto de la ventana (1200×800).
async function clic(x, y) {
  await cdp('Input.dispatchMouseEvent', { type: 'mouseMoved', x, y });
  await cdp('Input.dispatchMouseEvent', { type: 'mousePressed', x, y, button: 'left', clickCount: 1 });
  await cdp('Input.dispatchMouseEvent', { type: 'mouseReleased', x, y, button: 'left', clickCount: 1 });
}
// El diálogo de los avisos y la guía salen al poco de arrancar: se cierran si están.
const sinEstorbos = (texto) => `(() => { ${tocar('Ahora no')}; ${tocar('Saltar la guía')}; return ${tocar(texto)}; })()`;
const existe = (texto) => `(() => { ${tocar('Ahora no')}; ${tocar('Saltar la guía')}; return [...document.querySelectorAll('[flt-tappable]')].some((el) => el.textContent.includes(${JSON.stringify(texto)})); })()`;
await hasta(existe('Test diario'), 20000, 'la pantalla Hoy');
await espera(1000);
// La barra de secciones no está en el árbol semántico: «Cantes» por su sitio.
await clic(41, 245);
await espera(1500);
await hasta(sinEstorbos('Cantar'), 20000, 'la pestaña Cantar');
await espera(1500);
await hasta(sinEstorbos('Pizarra'), 20000, 'el botón Pizarra');
await espera(2500);
const conRegistro = await js(`typeof window.__registroPizarra === 'function'`);

// ------------------------------------------------------------ El lápiz
await js(`window.__pen = (type, x, y, { id = 7, buttons = 1, pressure = 0.5 } = {}) => {
  const v = document.querySelector('flutter-view');
  const r = v.getBoundingClientRect();
  v.dispatchEvent(new PointerEvent(type, { pointerType: 'pen', pointerId: id, isPrimary: true, buttons, pressure,
    clientX: r.left + x, clientY: r.top + y, bubbles: type !== 'pointerleave', cancelable: true, composed: true }));
};
window.__espera = (ms) => new Promise((r) => setTimeout(r, ms));
// Una letra: apoyar, ocho puntos en zigzag cada 8 ms y el cierre que toque.
window.__letra = async (x, y, { id = 7, sinUp = false, leaveAntes = false, cancel = false } = {}) => {
  __pen('pointerdown', x, y, { id });
  for (let i = 1; i <= 8; i++) { await __espera(8); __pen('pointermove', x + 3 * i, y + (i % 2 ? 0 : 6), { id }); }
  if (cancel) { __pen('pointercancel', x + 24, y, { id, buttons: 0 }); return; }
  if (sinUp) return;
  if (leaveAntes) __pen('pointerleave', x + 24, y, { id, buttons: 0 });
  __pen('pointerup', x + 24, y, { id, buttons: 0 });
};
window.__trazos = () => typeof __registroPizarra === 'function' ? __registroPizarra().split('\\n').filter((l) => / LOG terminar: /.test(l)).length : -1;
true`);

const escenarios = [
  ['A: cinco letras completas', 5, `(async () => { for (let i = 0; i < 5; i++) { await __letra(200 + 40 * i, 420, { id: 10 + i }); await __espera(30); } })()`],
  ['B: pointerup perdido entre dos letras', 2, `(async () => { await __letra(200, 520, { id: 20, sinUp: true }); await __espera(30); await __letra(240, 520, { id: 21 }); })()`],
  ['C: pointerleave antes del pointerup', 2, `(async () => { await __letra(200, 620, { id: 30, leaveAntes: true }); await __espera(30); await __letra(240, 620, { id: 31 }); })()`],
  ['D: pointercancel', 1, `(async () => { await __letra(200, 700, { id: 40, cancel: true }); })()`],
];
let fallos = 0;
for (const [nombre, esperado, codigo] of escenarios) {
  const antes = await js('__trazos()');
  await js(codigo);
  await espera(150);
  const despues = await js('__trazos()');
  const obtenido = conRegistro ? despues - antes : '?';
  const ok = conRegistro ? obtenido === esperado : null;
  if (ok === false) fallos++;
  console.log(`${ok === null ? '  ' : ok ? 'OK' : 'KO'}  ${nombre}: esperado ${esperado}, obtenido ${obtenido}`);
}

if (captura) {
  const { data } = await cdp('Page.captureScreenshot', { format: 'png' });
  writeFileSync(captura, Buffer.from(data, 'base64'));
  console.log(`Captura en ${captura}`);
}
if (conRegistro) {
  const ruta = join(process.env.CLAUDE_SCRATCHPAD ?? tmpdir(), 'pizarra-registro.txt');
  writeFileSync(ruta, await js('__registroPizarra()'));
  console.log(`Registro en ${ruta}`);
} else {
  console.log('Esta versión no tiene registro (?depurar=1): solo la captura.');
}
if (consola.length) console.log('Consola:', consola.slice(-10).join('\n'));
cerrar();
process.exit(fallos ? 1 : 0);
