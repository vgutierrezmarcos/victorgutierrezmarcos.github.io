// Contenido exclusivo (temas revisados, fichas, guía del dictamen y canon) guardado en
// el KV CONTENIDO por ../publicar-contenido.py, con las mismas rutas que la skill:
//   temas/3A08/tema.md, temas/3A08/ficha.md, temas/3A08/guion-cante.md,
//   dictamen/guia-1D01.md, canon/notacion.md … y un indice.json con lo que hay.
// Solo se sirve a quien tiene sesión: es la protección real del material.

export interface EntradaIndice {
  codigo: string; // 3A08
  tema: string; // 3.A.8
  titulo: string;
  ficha: boolean;
  guion: boolean;
  texto: boolean;
  aprobado: string;
  version: string;
}

export interface Indice {
  generado: string;
  commit?: string;
  temas: EntradaIndice[];
  dictamen: string[];
  canon: string[];
}

export interface AlmacenContenido {
  get(clave: string, tipo: 'text'): Promise<string | null>;
}

export const documentosDictamen = ['guia-1D01', 'resumen-1D01', 'guion-1D01', 'examen-espana', 'solucion-espana'] as const;
export const documentosCanon = ['notacion', 'modelos-indice'] as const;

/** «3.A.8», «3A08», «3a8», «3.a.08» → «3A08»; null si no es un código. */
export function normalizarCodigo(entrada: string): string | null {
  const m = /^\s*(\d)\s*[.\-_ ]?\s*([A-Za-z])\s*[.\-_ ]?\s*(\d{1,2})\s*$/.exec(entrada ?? '');
  if (!m) return null;
  return `${m[1]}${m[2].toUpperCase()}${m[3].padStart(2, '0')}`;
}

/** «3A08» → «3.A.8». */
export function codigoConPuntos(codigo: string): string {
  return `${codigo[0]}.${codigo[1]}.${Number(codigo.slice(2))}`;
}

const sinAcentos = (s: string) => s.normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase();

/** Títulos de los apartados de nivel 2 de un tema en Markdown. */
export function apartadosDe(md: string): string[] {
  return md
    .split('\n')
    .filter((l) => l.startsWith('## '))
    .map((l) => l.slice(3).trim());
}

/**
 * El apartado de nivel 2 cuyo título empieza por la etiqueta pedida («II», «B», «Introducción»)
 * o la contiene («estática comparativa»), con su contenido hasta el siguiente. Null si no está.
 */
export function extraerApartado(md: string, apartado: string): string | null {
  const buscado = sinAcentos(apartado.trim());
  if (!buscado) return null;
  const lineas = md.split('\n');
  const cabeceras = lineas.map((l, i) => (l.startsWith('## ') ? i : -1)).filter((i) => i >= 0);
  // Etiqueta del apartado: «I.», «II.», «B.», «1.», «3)»; nada si el título empieza por una palabra.
  const etiquetaDe = (titulo: string) => /^([A-Za-z]|[IVXivx]+|\d+)[.)]?\s/.exec(titulo)?.[1]?.toLowerCase();
  // Primero la etiqueta exacta (que «I» no se lleve «Introducción»), luego el principio del título y luego cualquier parte.
  const criterios: Array<(titulo: string) => boolean> = [
    (titulo) => etiquetaDe(titulo) === buscado,
    (titulo) => sinAcentos(titulo).startsWith(buscado),
    (titulo) => sinAcentos(titulo).includes(buscado),
  ];
  for (const coincide of criterios) {
    for (let k = 0; k < cabeceras.length; k++) {
      const i = cabeceras[k];
      if (!coincide(lineas[i].slice(3))) continue;
      const fin = k + 1 < cabeceras.length ? cabeceras[k + 1] : lineas.length;
      return lineas.slice(i, fin).join('\n').trim();
    }
  }
  return null;
}

export class Contenido {
  constructor(private readonly kv: AlmacenContenido) {}

  async indice(): Promise<Indice | null> {
    const t = await this.kv.get('indice.json', 'text');
    if (!t) return null;
    try {
      return JSON.parse(t) as Indice;
    } catch {
      return null;
    }
  }

  tema(codigo: string, fichero: 'tema' | 'ficha' | 'guion-cante'): Promise<string | null> {
    return this.kv.get(`temas/${codigo}/${fichero}.md`, 'text');
  }

  dictamen(documento: (typeof documentosDictamen)[number]): Promise<string | null> {
    return this.kv.get(`dictamen/${documento}.md`, 'text');
  }

  canon(documento: (typeof documentosCanon)[number]): Promise<string | null> {
    return this.kv.get(`canon/${documento}.md`, 'text');
  }
}
