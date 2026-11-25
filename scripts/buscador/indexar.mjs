// Genera el índice del buscador de la web (/pagefind/) con Pagefind a partir de
// scripts/buscador/registros.jsonl (lo escribe extraer.py).
//
//   python3 scripts/buscador/extraer.py && node scripts/buscador/indexar.mjs
//
// Cada registro es una «página» para Pagefind: el título y el apartado pesan más
// que el texto, y lo que el buscador necesita para pintar el resultado (código del
// tema, apartado, página, PDF) va en metadatos. Los filtros: tipo y ejercicio.
// Autor: Víctor Gutiérrez Marcos
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import * as pagefind from 'pagefind';

const AQUI = path.dirname(fileURLToPath(import.meta.url));
const RAIZ = path.resolve(AQUI, '..', '..');
const SALIDA = path.join(RAIZ, 'pagefind');
const TIPOS = { tema: 'Temas', pagina: 'Páginas', blog: 'Blog', test: 'Preguntas de test' };

// Título y apartado también sin tildes: quien busca «areas monetarias optimas» los encuentra.
const sinTildes = (t) => String(t ?? '').normalize('NFD').replace(/[\u0300-\u036f]/g, '');
/** Las palabras del texto que llevan tilde, sin ella y sin repetir: para encontrarlas escritas sin tilde sin duplicar el texto. */
const conTildeSinTilde = (t) => [...new Set((String(t ?? '').match(/[\p{L}]*[áéíóúüÁÉÍÓÚÜ][\p{L}]*/gu) || []).map((w) => sinTildes(w).toLowerCase()))].join(' ');
// Siglas del temario que también se buscan desarrolladas («áreas monetarias óptimas» encuentra «AMO»).
const SIGLAS = {
  AMO: 'áreas monetarias óptimas', PPA: 'paridad del poder adquisitivo', UEM: 'unión económica y monetaria', IED: 'inversión extranjera directa',
  NEK: 'nueva economía keynesiana', NMC: 'nueva macroeconomía clásica', DSGE: 'modelos dinámicos estocásticos de equilibrio general',
  NAIRU: 'tasa de paro que no acelera la inflación', BCE: 'Banco Central Europeo', FMI: 'Fondo Monetario Internacional',
  OMC: 'Organización Mundial del Comercio', PAC: 'política agrícola común', TCR: 'tipo de cambio real', CLU: 'costes laborales unitarios',
  VAN: 'valor actual neto', TIR: 'tasa interna de rentabilidad', CAPM: 'modelo de valoración de activos', PIB: 'producto interior bruto',
  MEDE: 'Mecanismo Europeo de Estabilidad', MUS: 'Mecanismo Único de Supervisión', MUR: 'Mecanismo Único de Resolución',
};
const siglas = (t) => Object.keys(SIGLAS).filter((k) => new RegExp(`(^|[^A-Za-z])${k}([^A-Za-z]|$)`).test(String(t ?? ''))).map((k) => SIGLAS[k]).join('. ');
const esc = (t) => String(t ?? '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
const meta = (clave, valor) => (valor === undefined || valor === null || valor === '' ? '' : `<span data-pagefind-meta="${clave}">${esc(valor)}</span>`);

function html(r) {
  const filtros = `<span data-pagefind-filter="tipo">${TIPOS[r.tipo]}</span>${r.ejercicio ? `<span data-pagefind-filter="ejercicio">${esc(r.ejercicio)}</span>` : ''}`;
  const metas = [meta('title', r.titulo), meta('tipo', r.tipo), meta('codigo', r.codigo), meta('apartado', r.apartado), meta('pagina', r.pagina), meta('pdf', r.pdf), meta('revisado', r.revisado ? 'si' : ''), meta('descripcion', r.descripcion)].join('');
  return `<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"><title>${esc(r.titulo)}</title></head><body>
<div hidden>${metas}${filtros}</div>
<main data-pagefind-body>
<h1 data-pagefind-weight="7">${esc(r.codigo && r.tipo === 'tema' ? `${r.codigo} ${r.titulo}` : r.titulo)}</h1>
${r.apartado ? `<h2 data-pagefind-weight="5">${esc(r.apartado)}</h2>` : ''}
${r.descripcion ? `<p data-pagefind-weight="3">${esc(r.descripcion)}</p>` : ''}
<p data-pagefind-weight="4">${esc(sinTildes([r.titulo, r.apartado, r.descripcion].filter(Boolean).join(' ')))}</p>
<p data-pagefind-weight="0.6">${esc(conTildeSinTilde(r.texto))}</p>
<p data-pagefind-weight="3">${esc(siglas([r.titulo, r.apartado].join(' ')))}</p>
<p data-pagefind-weight="1">${esc(siglas(r.texto))}</p>
<p${r.tipo === 'pagina' || r.tipo === 'blog' ? ' data-pagefind-weight="1.8"' : ''}>${esc(r.texto)}</p>
</main></body></html>`;
}

const { index, errors } = await pagefind.createIndex({ forceLanguage: 'es', keepIndexUrl: true });
if (errors.length) throw new Error(errors.join('\n'));
const lineas = fs.readFileSync(path.join(AQUI, 'registros.jsonl'), 'utf-8').split('\n').filter(Boolean);
let n = 0;
for (const linea of lineas) {
  const r = JSON.parse(linea);
  const { errors: e } = await index.addHTMLFile({ url: r.url.replace('https://www.victorgutierrezmarcos.es', ''), content: html(r) });
  if (e.length) console.error(r.url, e);
  else n++;
}
fs.rmSync(SALIDA, { recursive: true, force: true });
const { errors: ew } = await index.writeFiles({ outputPath: SALIDA });
if (ew.length) throw new Error(ew.join('\n'));
await pagefind.close();
let bytes = 0;
for (const f of fs.readdirSync(SALIDA, { recursive: true })) {
  const p = path.join(SALIDA, f);
  if (fs.statSync(p).isFile()) bytes += fs.statSync(p).size;
}
console.log(`${n} registros indexados → pagefind/ (${(bytes / 1048576).toFixed(1)} MB)`);
