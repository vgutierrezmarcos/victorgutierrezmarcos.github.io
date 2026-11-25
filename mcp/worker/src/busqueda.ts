// Búsqueda en todo el temario revisado (herramienta buscar_en_temario, 25/11/2026).
// El índice lo genera mcp/publicar-contenido.py (indice_busqueda) y vive en el KV CONTENIDO:
//   busqueda/meta.json         { pasajes, media, titulos: {3A14: …}, trozos: {«co»: 3, «con»: 4, …} }
//   busqueda/i/<n>.json        { palabra: "3A14:12:2:180,…" }  (tema:pasaje:frecuencia:longitud)
//   busqueda/t/<tema>.json     [[apartado, texto], …]
// Cada consulta lee solo meta.json, los trozos de sus palabras y los pasajes de los mejores temas:
// cabe en el límite de CPU del Worker. La normalización es la misma que la del script de Python.

const VACIAS = new Set(
  'los las del una uno unos unas que con por para sus como sobre entre esta este estos estas cada mas más son sin pero sino tras ante bajo desde hasta segun según donde cuando cual cuales quien tema temas apartado tambien también muy hay han ser fue sea'.split(' '),
);

/** Igual que normalizar_palabra de publicar-contenido.py. */
export function normalizarPalabra(w: string): string {
  let n = w.normalize('NFD').replace(/\p{Mn}/gu, '').toLowerCase();
  if (/\d/.test(n)) return n;
  if (n.length > 5 && n.endsWith('es')) n = n.slice(0, -2);
  else if (n.length > 4 && n.endsWith('s')) n = n.slice(0, -1);
  return n.slice(0, 9);
}

export function palabrasConsulta(texto: string): string[] {
  const salida: string[] = [];
  for (const w of texto.match(/\d+(?:[.,]\d+)?|[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+/g) ?? []) {
    if (w.length < 3 && !/^\d/.test(w)) continue;
    const n = normalizarPalabra(w);
    if (n && !VACIAS.has(n) && !salida.includes(n)) salida.push(n);
  }
  return salida;
}

/** Las fórmulas de un texto en Markdown ($$…$$ y las $…$ largas), para citarlas tal cual. */
export function formulasDe(texto: string): string[] {
  const salida: string[] = [];
  for (const m of texto.matchAll(/\$\$([\s\S]+?)\$\$/g)) salida.push(`$$${m[1].trim()}$$`);
  const sinBloques = texto.replace(/\$\$[\s\S]+?\$\$/g, ' ');
  for (const m of sinBloques.matchAll(/\$([^$\n]{12,})\$/g)) salida.push(`$${m[1].trim()}$`);
  return [...new Set(salida)].slice(0, 6);
}

export interface Resultado {
  tema: string; // 3A14 o 1D01
  titulo: string;
  apartado: string;
  texto: string;
  palabras: number; // cuántas palabras de la consulta lleva
}

interface Meta {
  pasajes: number;
  media: number;
  titulos: Record<string, string>;
  trozos: Record<string, number>;
}

type Lector = (clave: string) => Promise<string | null>;

/**
 * Los [maximo] pasajes que mejor responden a la consulta (BM25, primero los que llevan más
 * palabras de la consulta), como mucho 3 por tema. null si el índice no está publicado.
 */
export async function buscarEnTemario(leer: Lector, consulta: string, maximo = 8, soloTemas?: string[]): Promise<Resultado[] | null> {
  const metaTexto = await leer('busqueda/meta.json');
  if (!metaTexto) return null;
  const meta = JSON.parse(metaTexto) as Meta;
  const palabras = palabrasConsulta(consulta);
  if (!palabras.length) return [];
  const trozoDe = (w: string) => meta.trozos[w.slice(0, 3)] ?? meta.trozos[w.slice(0, 2)];
  const numeros = [...new Set(palabras.map(trozoDe).filter((n): n is number => n !== undefined))];
  const trozos = new Map<number, Record<string, string>>();
  await Promise.all(numeros.map(async (n) => trozos.set(n, JSON.parse((await leer(`busqueda/i/${n}.json`)) ?? '{}'))));
  const k1 = 1.2, b = 0.75, N = meta.pasajes, media = meta.media || 1;
  const puntos = new Map<string, { s: number; palabras: number }>();
  for (const w of palabras) {
    const n = trozoDe(w);
    const lista = n === undefined ? undefined : trozos.get(n)?.[w];
    if (!lista) continue;
    const entradas = lista.split(',');
    const idf = Math.log(1 + (N - entradas.length + 0.5) / (entradas.length + 0.5));
    for (const e of entradas) {
      const [tema, i, tf, largo] = e.split(':');
      if (soloTemas && !soloTemas.includes(tema)) continue;
      const clave = `${tema}:${i}`;
      const f = Number(tf);
      const s = (idf * f * (k1 + 1)) / (f + k1 * (1 - b + (b * Number(largo)) / media));
      const p = puntos.get(clave) ?? { s: 0, palabras: 0 };
      p.s += s;
      p.palabras += 1;
      puntos.set(clave, p);
    }
  }
  const orden = [...puntos.entries()].sort((a, c) => c[1].palabras - a[1].palabras || c[1].s - a[1].s);
  const elegidos: Array<[string, number, number]> = [];
  const porTema = new Map<string, number>();
  for (const [clave, p] of orden) {
    const [tema, i] = clave.split(':');
    if ((porTema.get(tema) ?? 0) >= 3) continue;
    porTema.set(tema, (porTema.get(tema) ?? 0) + 1);
    elegidos.push([tema, Number(i), p.palabras]);
    if (elegidos.length >= maximo) break;
  }
  const temas = [...new Set(elegidos.map((e) => e[0]))];
  const pasajes = new Map<string, Array<[string, string]>>();
  await Promise.all(temas.map(async (t) => pasajes.set(t, JSON.parse((await leer(`busqueda/t/${t}.json`)) ?? '[]'))));
  return elegidos.map(([tema, i, n]) => {
    const [apartado, texto] = pasajes.get(tema)?.[i] ?? ['', ''];
    return { tema, titulo: meta.titulos[tema] ?? '', apartado, texto, palabras: n };
  });
}
