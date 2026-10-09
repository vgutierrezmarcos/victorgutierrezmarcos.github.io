// Calculadora de probabilidad del test del primer ejercicio de TCEE
// (oposicion/probabilidad-test.html). Lee la frecuencia de cada tema en los
// exámenes oficiales de temario/primer-ejercicio/test/frecuencia_temas.json,
// que genera scripts/frecuencia-test.py.
// Autor: Víctor Gutiérrez Marcos
let DATOS = null;
const ANIO_ACTUAL = new Date().getFullYear();
const $ = id => document.getElementById(id);
const pct = (x, d = 0) => (100 * x).toLocaleString('es-ES', { minimumFractionDigits: d, maximumFractionDigits: d }) + ' %';
const num = (x, d = 1) => x.toLocaleString('es-ES', { minimumFractionDigits: d, maximumFractionDigits: d });

let estado = { h: 10, d: 0, sel: new Set() };
const leer = () => ({ N: Math.max(1, Math.round(+$('n').value || 50)), k: Math.max(2, Math.round(+$('k').value || 4)), a: +$('a').value || 0, f: +$('f').value || 0, b: +$('b').value || 0, min: +$('min').value, s: +$('s').value / 100 });

// Pesos por antigüedad: vida media de H años (0 = todos igual).
function pesos() { return DATOS.examenes.map(e => estado.h ? Math.pow(0.5, (ANIO_ACTUAL - e.anio) / estado.h) : 1) }
function frecuencias() {
  const w = pesos(), tot = w.reduce((x, y) => x + y, 0), f = {};
  DATOS.temas.forEach(t => f[t.c] = 0);
  DATOS.examenes.forEach((e, i) => { for (const [c, n] of Object.entries(e.temas)) if (c in f) f[c] += w[i] * n / e.n });
  for (const c in f) f[c] /= tot;
  return f;
}

// Distribución de la puntuación: cada pregunta es acierto, fallo o blanco (trinomial).
const lf = [0]; for (let i = 1; i <= 200; i++) lf[i] = lf[i - 1] + Math.log(i);
function trinomial(N, p1, p2) {
  const p3 = Math.max(0, 1 - p1 - p2), out = [];
  const L = x => x > 0 ? Math.log(x) : -Infinity;
  for (let i = 0; i <= N; i++) for (let j = 0; i + j <= N; j++) {
    const r = N - i - j;
    const lp = lf[N] - lf[i] - lf[j] - lf[r] + (i ? i * L(p1) : 0) + (j ? j * L(p2) : 0) + (r ? r * L(p3) : 0);
    if (lp > -40) out.push([i, j, r, Math.exp(lp)]);
  }
  return out;
}
// c = parte del test de tus temas; g = parte de las que no sabes que respondes al azar.
function resultado(p, c, g, d) {
  const pg = 1 / Math.max(1, p.k - d);
  const p1 = c * p.s + (1 - c) * g * pg, p2 = c * (1 - p.s) + (1 - c) * g * (1 - pg);
  const max = p.N * p.a, umbral = p.min / 10 * max - 1e-9;
  let apr = 0, media = 0; const notas = [];
  for (const [i, j, r, q] of trinomial(p.N, p1, p2)) {
    const pts = i * p.a - j * p.f + r * p.b, nota = 10 * pts / max;
    if (pts >= umbral) apr += q; media += q * nota; notas.push([nota, q]);
  }
  return { apr, media, notas };
}
// Mezcla ponderada sobre los exámenes reales (cobertura de cada uno con tus temas).
function coberturas(sel) { return DATOS.examenes.map(e => { let n = 0; for (const [c, m] of Object.entries(e.temas)) if (sel.has(c)) n += m; return n / e.n }) }
function mezcla(p, sel, g, d) {
  const w = pesos(), cs = coberturas(sel), tot = w.reduce((x, y) => x + y, 0);
  let apr = 0, media = 0; const notas = [];
  cs.forEach((c, i) => { const r = resultado(p, c, g, d); apr += w[i] * r.apr / tot; media += w[i] * r.media / tot; r.notas.forEach(([n, q]) => notas.push([n, q * w[i] / tot])) });
  return { apr, media, notas, cs };
}
function mejorG(p, sel, d) {
  let mejor = null;
  for (const g of [0, 0.25, 0.5, 0.75, 1]) { const r = mezcla(p, sel, g, d); if (!mejor || r.apr > mejor.r.apr + 1e-9) mejor = { g, r } }
  return mejor;
}

// Respondiendo exactamente r preguntas al azar (y el resto en blanco): aciertos ~ Binomial(r, 1/k).
function azar(p, r) {
  const pg = 1 / p.k, max = p.N * p.a, umbral = p.min / 10 * max - 1e-9;
  let apr = 0;
  for (let i = 0; i <= r; i++) {
    const pts = i * p.a - (r - i) * p.f + (p.N - r) * p.b;
    if (pts >= umbral) apr += Math.exp(lf[r] - lf[i] - lf[r - i] + i * Math.log(pg) + (r - i) * Math.log(1 - pg));
  }
  return apr;
}
function binom(n, p) { const o = []; for (let i = 0; i <= n; i++) o.push(n ? Math.exp(lf[n] - lf[i] - lf[n - i] + (i ? i * Math.log(Math.max(p, 1e-300)) : 0) + (n - i ? (n - i) * Math.log(Math.max(1 - p, 1e-300)) : 0)) : 1); return o }
function sabiendo(p, K, m) {
  const alAzar = m > 0, max = p.N * p.a, umbral = p.min / 10 * max - 1e-9, pg = alAzar ? 1 / m : 0;
  const b1 = binom(K, p.s), b2 = alAzar ? binom(p.N - K, pg) : [1];
  let apr = 0;
  for (let i = 0; i <= K; i++) for (let j = 0; j < b2.length; j++) {
    const ok = i + j, mal = (K - i) + (alAzar ? (p.N - K - j) : 0), blanco = alAzar ? 0 : p.N - K;
    if (ok * p.a - mal * p.f + blanco * p.b >= umbral) apr += b1[i] * b2[j];
  }
  return apr;
}
function dosLineas(cont, series, opts) {
  const W = 640, H = 230, m = { l: 44, r: 14, t: 12, b: 34 };
  const x0 = 0, x1 = series[0].pts[series[0].pts.length - 1][0];
  const X = x => m.l + (x - x0) / (x1 - x0 || 1) * (W - m.l - m.r), Y = y => H - m.b - y * (H - m.t - m.b);
  let s = `<svg viewBox="0 0 ${W} ${H}" role="img" aria-label="${opts.aria}">`;
  for (const v of [0, .25, .5, .75, 1]) s += `<line x1="${m.l}" x2="${W - m.r}" y1="${Y(v)}" y2="${Y(v)}" stroke="var(--line)"/><text x="${m.l - 6}" y="${Y(v) + 4}" text-anchor="end">${v * 100} %</text>`;
  for (let t = 0; t <= x1; t += 10) s += `<text x="${X(t)}" y="${H - m.b + 16}" text-anchor="middle">${t}</text>`;
  s += `<text x="${(m.l + W - m.r) / 2}" y="${H - 4}" text-anchor="middle">${opts.ejeX}</text>`;
  for (const se of series) {
    const d = se.pts.map((q, i) => (i ? 'L' : 'M') + X(q[0]).toFixed(1) + ' ' + Y(q[1]).toFixed(1)).join(' ');
    s += `<path d="${d}" fill="none" stroke="${se.color}" stroke-width="2" stroke-linejoin="round" ${se.dash ? 'stroke-dasharray="5 4"' : ''}/>`;
  }
  s += `<line class="cruz" x1="0" x2="0" y1="${m.t}" y2="${H - m.b}" stroke="var(--muted)" stroke-dasharray="3 3" opacity="0"/><rect x="${m.l}" y="${m.t}" width="${W - m.l - m.r}" height="${H - m.t - m.b}" fill="transparent"/></svg>`;
  cont.innerHTML = s;
  const svg = cont.querySelector('svg'), cruz = svg.querySelector('.cruz'), rect = svg.querySelector('rect:last-of-type');
  rect.addEventListener('mousemove', ev => {
    const bb = svg.getBoundingClientRect(), xv = Math.round(x0 + ((ev.clientX - bb.left) / bb.width * W - m.l) / (W - m.l - m.r) * (x1 - x0));
    const k = Math.max(0, Math.min(x1, xv));
    cruz.setAttribute('x1', X(k)); cruz.setAttribute('x2', X(k)); cruz.setAttribute('opacity', 1);
    mostrarTip(ev, `<b>Sabiendo ${k}</b><br>` + series.map(se => `${se.nombre}: ${pct(se.pts[k][1], 0)}`).join('<br>'));
  });
  rect.addEventListener('mouseleave', () => { cruz.setAttribute('opacity', 0); ocultarTip() });
}

// ---------- Pregunta a pregunta ----------
// Grupos: [{n, p (probabilidad de acertar si respondes), modo: 'si' | 'no' | 'auto'}]
let grupos = null;
function gruposPorDefecto(p) {
  const g = [{ clave: 'se', nombre: 'Me las sé', n: Math.round(p.N * 0.5), modo: 'auto' }];
  for (let m = 2; m <= p.k; m++) g.push({ clave: 'm' + m, nombre: m === p.k ? `Ni idea (entre ${m})` : `Dudo entre ${m}`, m, n: 0, modo: 'auto' });
  g[1].n = Math.round(p.N * 0.2); if (g.length > 2) g[2].n = Math.round(p.N * 0.1);
  return g;
}
function convolucion(x, y) { const o = new Array(x.length + y.length - 1).fill(0); for (let i = 0; i < x.length; i++) if (x[i]) for (let j = 0; j < y.length; j++) o[i + j] += x[i] * y[j]; return o }
function evaluarGrupos(p, gs, decision) {
  const max = p.N * p.a, umbral = p.min / 10 * max - 1e-9;
  let pmf = [1], respondidas = 0, blancos = 0;
  gs.forEach((g, i) => { if (!g.n) return; if (decision[i]) { pmf = convolucion(pmf, binom(g.n, g.p)); respondidas += g.n } else blancos += g.n });
  let apr = 0, media = 0; const notas = [];
  pmf.forEach((q, c) => { if (q < 1e-12) return; const pts = c * p.a - (respondidas - c) * p.f + blancos * p.b, nota = 10 * pts / max; if (pts >= umbral) apr += q; media += q * nota; notas.push([nota, q]) });
  return { apr, media, notas };
}
function calcularGrupos(p) {
  if (!grupos || grupos.length !== p.k) grupos = gruposPorDefecto(p);
  const ultimo = grupos[grupos.length - 1];
  const resto = p.N - grupos.slice(0, -1).reduce((x, g) => x + (+g.n || 0), 0);
  ultimo.n = Math.max(0, resto);
  $('aviso-suma').hidden = resto >= 0;
  $('aviso-suma').textContent = `Has repartido ${p.N - resto} preguntas y el examen tiene ${p.N}: baja alguna fila.`;
  const gs = grupos.map(g => ({ ...g, p: g.pc != null ? g.pc : (g.clave === 'se' ? p.s : 1 / g.m) }));
  // Decisiones: las fijadas por el usuario y, en «lo que convenga», la mejor combinación.
  const libres = gs.map((g, i) => g.modo === 'auto' && g.n > 0 ? i : -1).filter(i => i >= 0);
  let mejor = null;
  for (let mask = 0; mask < (1 << libres.length); mask++) {
    const dec = gs.map(g => g.modo === 'si');
    libres.forEach((i, b) => dec[i] = !!(mask & (1 << b)));
    const r = evaluarGrupos(p, gs, dec);
    if (!mejor || r.apr > mejor.r.apr + 1e-12 || (Math.abs(r.apr - mejor.r.apr) <= 1e-12 && r.media > mejor.r.media)) mejor = { dec, r };
  }
  return { gs, ...mejor, resto };
}
function pintarGrupos(p) {
  const { gs, dec, r, resto } = calcularGrupos(p);
  let html = '<thead><tr><th>Preguntas que…</th><th>Cuántas</th><th>Aciertas (%)</th><th>Valor medio de responder</th><th>Qué haces</th><th>Decisión</th></tr></thead><tbody>';
  gs.forEach((g, i) => {
    const ev = g.p * p.a - (1 - g.p) * p.f - p.b, ultima = i === gs.length - 1;
    html += `<tr><td>${g.nombre}</td><td>${ultima ? `<b>${g.n}</b>` : `<input type="number" min="0" max="${p.N}" id="g-${g.clave}" data-i="${i}" value="${g.n}">`}</td><td><input type="number" min="0" max="100" step="1" id="ga-${g.clave}" data-a="${i}" value="${Math.round(g.p * 100)}" aria-label="Porcentaje de acierto: ${g.nombre}"> %</td><td>${ev >= 0 ? '+' : ''}${num(ev, 2)} pt</td>
      <td><select id="gm-${g.clave}" data-i="${i}"><option value="auto"${g.modo === 'auto' ? ' selected' : ''}>Lo que convenga</option><option value="si"${g.modo === 'si' ? ' selected' : ''}>Responder</option><option value="no"${g.modo === 'no' ? ' selected' : ''}>En blanco</option></select></td>
      <td><span class="decision ${dec[i] ? 'si' : 'no'}">${g.n ? (dec[i] ? 'Responder' : 'En blanco') : '—'}</span></td></tr>`;
  });
  $('tabla-grupos').innerHTML = html + '</tbody>';
  $('tabla-grupos').querySelectorAll('input[data-i]').forEach(el => el.addEventListener('change', () => { grupos[+el.dataset.i].n = Math.max(0, Math.round(+el.value || 0)); calcular() }));
  $('tabla-grupos').querySelectorAll('input[data-a]').forEach(el => el.addEventListener('change', () => { const v = el.value === '' ? null : Math.min(100, Math.max(0, +el.value)) / 100; grupos[+el.dataset.a].pc = v; calcular() }));
  $('tabla-grupos').querySelectorAll('select').forEach(el => el.addEventListener('change', () => { grupos[+el.dataset.i].modo = el.value; calcular() }));
  const ordenadas = r.notas.slice().sort((x, y) => x[0] - y[0]); let acum = 0, p10 = null, p90 = null;
  for (const [n, q] of ordenadas) { acum += q; if (p10 == null && acum >= .1) p10 = n; if (p90 == null && acum >= .9) p90 = n }
  const respondidas = gs.reduce((x, g, i) => x + (dec[i] ? g.n : 0), 0);
  $('pregunta-cifras').innerHTML = cifra(pct(r.apr, r.apr < 0.01 ? 2 : 1), 'de aprobar', true) + cifra(num(r.media, 2), 'nota esperada') + cifra(`${num(p10 ?? 0, 1)}–${num(p90 ?? 0, 1)}`, 'nota en 8 de cada 10 intentos') + cifra(String(respondidas), `preguntas respondidas de ${p.N}`);
  histograma($('pregunta-histo'), r.notas, p.min);
  // Consejo: qué cambia si en vez de lo elegido respondes también el grupo dudoso siguiente o lo dejas.
  const cambios = [];
  gs.forEach((g, i) => {
    if (!g.n) return;
    const alt = dec.slice(); alt[i] = !alt[i];
    const r2 = evaluarGrupos(p, gs, alt);
    cambios.push(`${dec[i] ? 'dejar en blanco' : 'responder'} «${g.nombre.toLowerCase()}» ${r2.apr >= r.apr ? 'subiría' : 'bajaría'} la probabilidad a ${pct(r2.apr, 1)}`);
  });
  $('pregunta-consejo').textContent = cambios.length ? `Con este reparto: ${cambios.join('; ')}.` : '';
}

// ---------- Gráficos (SVG a mano: una escala por eje) ----------
const tip = $('tooltip');
function mostrarTip(ev, html) { tip.innerHTML = html; tip.hidden = false; const x = Math.min(ev.clientX + 12, innerWidth - tip.offsetWidth - 8); tip.style.left = x + 'px'; tip.style.top = Math.max(4, ev.clientY - tip.offsetHeight - 10) + 'px' }
function ocultarTip() { tip.hidden = true }
function lineas(cont, pts, opts) {
  const W = 640, H = 220, m = { l: 44, r: 14, t: 12, b: 34 };
  const xs = pts.map(p => p[0]), x0 = Math.min(...xs), x1 = Math.max(...xs);
  const X = x => m.l + (x - x0) / (x1 - x0 || 1) * (W - m.l - m.r), Y = y => H - m.b - y * (H - m.t - m.b);
  let s = `<svg viewBox="0 0 ${W} ${H}" role="img" aria-label="${opts.aria}">`;
  for (const v of [0, .25, .5, .75, 1]) s += `<line x1="${m.l}" x2="${W - m.r}" y1="${Y(v)}" y2="${Y(v)}" stroke="var(--line)" stroke-width="1"/><text x="${m.l - 6}" y="${Y(v) + 4}" text-anchor="end">${v * 100} %</text>`;
  const ticks = opts.ticks || [x0, Math.round((x0 + x1) / 2), x1];
  for (const t of ticks) s += `<text x="${X(t)}" y="${H - m.b + 16}" text-anchor="middle">${t}</text>`;
  s += `<text x="${(m.l + W - m.r) / 2}" y="${H - 4}" text-anchor="middle">${opts.ejeX}</text>`;
  const d = pts.map((p, i) => (i ? 'L' : 'M') + X(p[0]).toFixed(1) + ' ' + Y(p[1]).toFixed(1)).join(' ');
  s += `<path d="${d} L${X(x1)} ${Y(0)} L${X(x0)} ${Y(0)} Z" fill="var(--accent)" opacity=".12"/>`;
  s += `<path d="${d}" fill="none" stroke="var(--accent)" stroke-width="2" stroke-linejoin="round"/>`;
  if (opts.marca != null) { const p = pts.find(p => p[0] === opts.marca) || pts[pts.length - 1]; s += `<circle cx="${X(p[0])}" cy="${Y(p[1])}" r="5" fill="var(--accent)" stroke="var(--surface)" stroke-width="2"/>` }
  s += `<line class="cruz" x1="0" x2="0" y1="${m.t}" y2="${H - m.b}" stroke="var(--muted)" stroke-dasharray="3 3" opacity="0"/>`;
  s += `<rect x="${m.l}" y="${m.t}" width="${W - m.l - m.r}" height="${H - m.t - m.b}" fill="transparent"/></svg>`;
  cont.innerHTML = s;
  const svg = cont.querySelector('svg'), cruz = svg.querySelector('.cruz'), rect = svg.querySelector('rect:last-of-type');
  rect.addEventListener('mousemove', ev => {
    const bb = svg.getBoundingClientRect(), xv = x0 + ((ev.clientX - bb.left) / bb.width * W - m.l) / (W - m.l - m.r) * (x1 - x0);
    const p = pts.reduce((a, b) => Math.abs(b[0] - xv) < Math.abs(a[0] - xv) ? b : a);
    cruz.setAttribute('x1', X(p[0])); cruz.setAttribute('x2', X(p[0])); cruz.setAttribute('opacity', 1);
    mostrarTip(ev, opts.tip(p));
  });
  rect.addEventListener('mouseleave', () => { cruz.setAttribute('opacity', 0); ocultarTip() });
}
function histograma(cont, notas, minimo) {
  const bins = new Map(); let lo = 0, hi = 10;
  for (const [n, q] of notas) { const b = Math.max(-2, Math.floor(n * 2) / 2); bins.set(b, (bins.get(b) || 0) + q) }
  const ks = [...bins.keys()]; lo = Math.min(0, ...ks); hi = 10;
  const W = 640, H = 214, m = { l: 36, r: 10, t: 24, b: 30 }, nb = (hi - lo) * 2 + 1, bw = (W - m.l - m.r) / nb;
  const maxq = Math.max(...bins.values(), 1e-9), X = v => m.l + (v - lo) * 2 * bw, Y = q => H - m.b - q / maxq * (H - m.t - m.b);
  let s = `<svg viewBox="0 0 ${W} ${H}" role="img" aria-label="Distribución de la nota">`;
  s += `<line x1="${m.l}" x2="${W - m.r}" y1="${H - m.b}" y2="${H - m.b}" stroke="var(--line)"/>`;
  for (let v = Math.ceil(lo); v <= hi; v++) s += `<text x="${X(v) + bw / 2}" y="${H - m.b + 15}" text-anchor="middle">${v}</text>`;
  s += `<text x="${(W) / 2}" y="${H - 2}" text-anchor="middle">Nota sobre 10</text>`;
  for (const [b, q] of [...bins.entries()].sort((a, c) => a[0] - c[0])) {
    const y = Y(q), aprob = b >= minimo - 1e-9;
    s += `<path data-b="${b}" data-q="${q}" d="M${X(b) + 1} ${H - m.b} V${y + 3} q0 -3 3 -3 H${X(b) + bw - 4} q3 0 3 3 V${H - m.b} Z" fill="${aprob ? 'var(--accent)' : 'var(--muted)'}" opacity="${aprob ? .9 : .45}"/>`;
  }
  const xm = X(minimo);
  s += `<line x1="${xm}" x2="${xm}" y1="${m.t - 6}" y2="${H - m.b}" stroke="var(--gold)" stroke-width="2"/><text x="${xm}" y="${m.t - 10}" text-anchor="middle" style="fill:var(--gold)">nota para aprobar</text></svg>`;
  cont.innerHTML = s;
  cont.querySelectorAll('path[data-b]').forEach(el => {
    el.addEventListener('mousemove', ev => mostrarTip(ev, `Nota ${num(+el.dataset.b)} a ${num(+el.dataset.b + 0.5)}: ${pct(+el.dataset.q, 1)}`));
    el.addEventListener('mouseleave', ocultarTip);
  });
}
const cifra = (v, d, principal) => `<div class="cifra"><div class="v${principal ? ' principal' : ''}">${v}</div><div class="d">${d}</div></div>`;

// ---------- Pintado ----------
function pintarTemas(fr) {
  const orden = c => c;
  let html = '';
  for (const parte of ['3.A', '3.B']) {
    html += `<h3>Parte ${parte.slice(2)} · tercer ejercicio</h3>`;
    const maxf = Math.max(...Object.values(fr));
    for (const t of DATOS.temas.filter(t => t.c.startsWith(parte))) {
      html += `<label class="tema" for="t-${t.c}"><input type="checkbox" id="t-${t.c}" data-c="${t.c}" ${estado.sel.has(t.c) ? 'checked' : ''}><span class="cod">${t.c}</span><span class="tit" title="${t.t.replace(/"/g, '&quot;')}">${t.t}</span><span class="pct">${pct(fr[t.c], 1)}<i style="width:${(fr[t.c] / maxf * 100).toFixed(0)}%"></i></span></label>`;
    }
  }
  $('lista-temas').innerHTML = html;
  $('lista-temas').querySelectorAll('input').forEach(i => i.addEventListener('change', () => { i.checked ? estado.sel.add(i.dataset.c) : estado.sel.delete(i.dataset.c); guardar(); calcular() }));
}
function topN(n, fr) { return DATOS.temas.map(t => t.c).sort((x, y) => fr[y] - fr[x]).slice(0, n) }

function calcular() {
  const p = leer(), fr = frecuencias();
  $('s-v').textContent = Math.round(p.s * 100) + ' %';
  $('peso-texto').textContent = estado.h ? `Un examen de hace ${estado.h} años cuenta la mitad que uno de este año.` : 'Todos los exámenes cuentan lo mismo.';

  // 1. Al azar.
  const vacio = new Set(), pg = 1 / p.k, ev = p.a * pg - p.f * (1 - pg) - p.b;
  const curvaAzar = [];
  for (let r = 0; r <= p.N; r++) curvaAzar.push([r, azar(p, r)]);
  // Una línea por cómo estás en las preguntas que no sabes: en blanco, ni idea (entre k), entre k-1… hasta entre 2.
  const casos = [{ nombre: 'Resto en blanco', m: 0 }];
  for (let m = p.k; m >= 2; m--) casos.push({ nombre: m === p.k ? `Resto: ni idea (entre ${m})` : `Resto: dudas entre ${m}`, m });
  // Tonos de un mismo color, más intenso cuanto más sabes del resto; el blanco, en gris discontinuo.
  casos.forEach((c, i) => { c.color = c.m ? `color-mix(in srgb, var(--accent) ${Math.round(35 + 65 * (i - 1) / Math.max(1, casos.length - 2))}%, var(--surface))` : 'var(--muted)'; c.dash = !c.m });
  casos.forEach(c => { c.pts = []; for (let K = 0; K <= p.N; K++) c.pts.push([K, sabiendo(p, K, c.m)]) });
  const minimo = serie => (serie.find(q => q[1] >= 0.5) || [null])[0];
  const todas = resultado(p, 0, 1, 0), mejor = curvaAzar.reduce((x, y) => y[1] > x[1] ? y : x);
  $('azar-cifras').innerHTML = cifra(pct(todas.apr, todas.apr < 0.01 ? 3 : 1), 'de aprobar respondiendo todas al azar', true) + cifra(num(todas.media, 2), 'nota esperada (sobre 10)')
    + casos.map(c => { const k50 = minimo(c.pts); return cifra(k50 == null ? '—' : String(k50), `preguntas que saberse para un 50 % de aprobar · ${c.nombre.toLowerCase()}`) }).join('');
  $('azar-leyenda').innerHTML = casos.map(c => `<span><i style="border-color:${c.color};${c.dash ? 'border-top-style:dashed' : ''}"></i>${c.nombre}</span>`).join('');
  dosLineas($('azar-grafico'), casos, { aria: 'Probabilidad de aprobar según las preguntas que sabes y cómo estás en el resto', ejeX: `Preguntas que te sabes (aciertas el ${Math.round(p.s * 100)} %)` });
  const ev1 = p.a / (p.k - 1) - p.f * (1 - 1 / (p.k - 1)) - p.b, ev2 = p.a / (p.k - 2) - p.f * (1 - 1 / (p.k - 2)) - p.b;
  $('azar-consejo').innerHTML = `Al azar puro cada respuesta vale ${num(ev, 3)} puntos: con esta resta ${Math.abs(ev) < 0.005 ? 'da igual responder o no de cara a la nota media' : ev > 0 ? 'conviene responder' : 'no conviene responder'}. Si descartas una opción, vale ${num(ev1, 2)}; si descartas dos, ${num(ev2, 2)}. Para aprobar sin saber nada hace falta suerte: la probabilidad es máxima respondiendo ${mejor[0]} (${pct(mejor[1], mejor[1] < 0.01 ? 3 : 1)}).`;

  // 1 bis. Pregunta a pregunta.
  pintarGrupos(p);

  // 2. Con tus temas.
  const sel = estado.sel, cob = DATOS.temas.reduce((x, t) => x + (sel.has(t.c) ? fr[t.c] : 0), 0);
  const best = mejorG(p, sel, estado.d), r = best.r;
  const ordenadas = r.notas.slice().sort((x, y) => x[0] - y[0]); let acum = 0, p10 = null, p90 = null;
  for (const [n, q] of ordenadas) { acum += q; if (p10 == null && acum >= .1) p10 = n; if (p90 == null && acum >= .9) p90 = n }
  $('sabes-cifras').innerHTML = cifra(pct(r.apr, 1), 'de aprobar', true) + cifra(num(r.media, 2), 'nota esperada') + cifra(`${num(p10 ?? 0, 1)}–${num(p90 ?? 0, 1)}`, 'nota en 8 de cada 10 exámenes') + cifra(pct(cob, 0), `del test es de tus ${sel.size} temas (≈ ${num(cob * p.N, 1)} preguntas)`);
  histograma($('histograma'), r.notas, p.min);
  const gtxt = best.g === 1 ? 'responder al azar todas las que no sepas' : best.g === 0 ? 'dejar en blanco las que no sepas' : `responder al azar más o menos ${Math.round(best.g * 100)} % de las que no sepas`;
  $('sabes-consejo').textContent = `Con ${estado.d ? `${estado.d === 1 ? 'una opción descartada' : 'dos opciones descartadas'}` : 'ninguna opción descartada'}, lo que más sube la probabilidad de aprobar es ${gtxt}.`;

  // 3. Qué estudiar después.
  // Lo que sube la probabilidad de aprobar y, si apenas se mueve (pocos temas), la nota esperada.
  let cands = DATOS.temas.filter(t => !sel.has(t.c)).sort((x, y) => fr[y.c] - fr[x.c]).slice(0, 30).map(t => {
    const s2 = new Set(sel); s2.add(t.c); const r2 = mejorG(p, s2, estado.d).r; return { t, d: r2.apr - r.apr, dn: r2.media - r.media };
  });
  const porNota = cands.every(x => x.d < 0.0005);
  cands = cands.sort((x, y) => porNota ? y.dn - x.dn : y.d - x.d).slice(0, 8);
  $('siguiente-intro').textContent = porNota ? 'Con tan pocos temas la probabilidad de aprobar apenas se mueve: estos son los que más suben tu nota esperada.' : 'Los temas que no llevas que más suben tu probabilidad de aprobar, uno a uno.';
  $('lista-sig').innerHTML = cands.map(x => `<li><span class="cod">${x.t.c}</span><span>${x.t.t}</span><span class="mas">+${porNota ? num(x.dn, 2) + ' de nota' : num(100 * x.d, 1) + ' pt'}</span></li>`).join('') || '<li>Llevas todos los temas.</li>';

  // 4. Curva de temas.
  const orden = topN(90, fr), pts = [];
  for (let n = 0; n <= 90; n += 5) pts.push([n, mejorG(p, new Set(orden.slice(0, n)), estado.d).r.apr]);
  const n0 = sel.size, marca = Math.round(n0 / 5) * 5;
  lineas($('curva-grafico'), pts, { aria: 'Probabilidad de aprobar según los temas estudiados', ejeX: 'Temas estudiados (de más a menos preguntados)', marca, ticks: [0, 15, 30, 45, 60, 75, 90], tip: q => `${q[0]} temas: ${pct(q[1], 1)} de aprobar` });

  // 5. Exámenes reales.
  const w = pesos(), wmax = Math.max(...w);
  let filas = '<thead><tr><th>Examen</th><th>Preguntas</th><th>De tus temas</th><th>Nota media</th><th>Aprobar</th><th>Peso</th></tr></thead><tbody>';
  DATOS.examenes.forEach((e, i) => {
    const c = r.cs[i], rr = resultado(p, c, best.g, estado.d);
    filas += `<tr><td>${e.nombre}</td><td>${e.n}</td><td>${Math.round(c * e.n)} (${pct(c)})</td><td>${num(rr.media, 2)}</td><td><span class="chip ${rr.apr >= .5 ? 'si' : 'no'}">${pct(rr.apr)}</span></td><td>${pct(w[i] / wmax)}</td></tr>`;
  });
  $('tabla-reales').innerHTML = filas + '</tbody>';
}

function guardar() { try { localStorage.setItem('temas-test', JSON.stringify([...estado.sel])) } catch (e) {} }
function iniciar() {
  let previos = null;
  try { previos = JSON.parse(localStorage.getItem('temas-test') || 'null') } catch (e) {}
  const fr = frecuencias();
  estado.sel = new Set(previos || topN(45, fr));
  pintarTemas(fr); calcular();
  document.querySelectorAll('[data-h]').forEach(b => b.addEventListener('click', () => {
    estado.h = +b.dataset.h; document.querySelectorAll('[data-h]').forEach(x => x.setAttribute('aria-pressed', x === b)); pintarTemas(frecuencias()); calcular();
  }));
  document.querySelectorAll('[data-d]').forEach(b => b.addEventListener('click', () => {
    estado.d = +b.dataset.d; document.querySelectorAll('[data-d]').forEach(x => x.setAttribute('aria-pressed', x === b)); calcular();
  }));
  let pendiente = 0;
  const pronto = () => { cancelAnimationFrame(pendiente); pendiente = requestAnimationFrame(calcular) };
  ['n', 'k', 'a', 'f', 'b', 'min', 's'].forEach(id => $(id).addEventListener('input', pronto));
  $('aplicar-top').addEventListener('click', () => { estado.sel = new Set(topN(+$('top').value || 0, frecuencias())); guardar(); pintarTemas(frecuencias()); calcular() });
  $('ninguno').addEventListener('click', () => { estado.sel = new Set(); guardar(); pintarTemas(frecuencias()); calcular() });
}
fetch('temario/primer-ejercicio/test/frecuencia_temas.json')
  .then(r => { if (!r.ok) throw new Error(r.status); return r.json() })
  .then(j => {
    DATOS = {
      temas: Object.entries(j.temas).map(([c, t]) => ({ c, t })),
      examenes: j.examenes.map(e => ({ id: e.id, nombre: e.nombre.replace(/^Examen oficial de /, ''), anio: e.anio, n: e.preguntas, temas: e.temas })),
    };
    document.getElementById('calc-cargando').hidden = true;
    document.getElementById('calc').hidden = false;
    iniciar();
  })
  .catch(() => { document.getElementById('calc-cargando').textContent = 'No se han podido cargar los datos de los exámenes. Recarga la página.' });
