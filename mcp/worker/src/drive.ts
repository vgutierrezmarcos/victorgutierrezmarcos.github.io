// Lectura de los apuntes de otros TCEE (repositorio de la ATCEE en Google Drive) para que
// Claude pueda valorarlos y explicarlos: descarga el fichero público, saca el texto de un
// .docx (ZIP con word/document.xml) o de un Documento de Google (exportado a texto) y
// devuelve el esquema (los títulos), la extensión y el texto por tramos. Sin dependencias:
// el ZIP se lee a mano y se descomprime con DecompressionStream('deflate-raw').

export interface Apuntes {
  formato: 'docx' | 'gdoc';
  esquema: string[];
  texto: string;
}

export class ErrorApuntes extends Error {}

/** Id de un fichero de Drive a partir de su enlace o del propio id. */
export function idDeDrive(entrada: string): string | null {
  const s = entrada.trim();
  const m = s.match(/\/d\/([A-Za-z0-9_-]{20,})/) || s.match(/[?&]id=([A-Za-z0-9_-]{20,})/) || s.match(/^([A-Za-z0-9_-]{20,})$/);
  return m ? m[1] : null;
}

const u16 = (b: Uint8Array, i: number) => b[i] | (b[i + 1] << 8);
const u32 = (b: Uint8Array, i: number) => (b[i] | (b[i + 1] << 8) | (b[i + 2] << 16) | (b[i + 3] << 24)) >>> 0;

async function inflar(datos: Uint8Array): Promise<Uint8Array> {
  const flujo = new Blob([datos]).stream().pipeThrough(new DecompressionStream('deflate-raw'));
  return new Uint8Array(await new Response(flujo).arrayBuffer());
}

/** Contenido de un fichero dentro de un ZIP (métodos 0 y 8), o null si no está. */
export async function ficheroDeZip(zip: Uint8Array, nombre: string): Promise<Uint8Array | null> {
  let fin = -1;
  for (let i = zip.length - 22; i >= Math.max(0, zip.length - 65_557); i--) {
    if (u32(zip, i) === 0x06054b50) {
      fin = i;
      break;
    }
  }
  if (fin < 0) throw new ErrorApuntes('el fichero no es un ZIP válido');
  const entradas = u16(zip, fin + 10);
  let p = u32(zip, fin + 16);
  const dec = new TextDecoder();
  for (let k = 0; k < entradas && u32(zip, p) === 0x02014b50; k++) {
    const metodo = u16(zip, p + 10);
    const tam = u32(zip, p + 20);
    const lNombre = u16(zip, p + 28);
    const lExtra = u16(zip, p + 30);
    const lComent = u16(zip, p + 32);
    const local = u32(zip, p + 42);
    const n = dec.decode(zip.subarray(p + 46, p + 46 + lNombre));
    if (n === nombre) {
      const ini = local + 30 + u16(zip, local + 26) + u16(zip, local + 28);
      const datos = zip.subarray(ini, ini + tam);
      if (metodo === 0) return datos;
      if (metodo === 8) return inflar(datos);
      throw new ErrorApuntes(`compresión ${metodo} no admitida`);
    }
    p += 46 + lNombre + lExtra + lComent;
  }
  return null;
}

const entidades = (t: string) =>
  t.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"').replace(/&apos;/g, "'").replace(/&amp;/g, '&');

/** Texto y títulos de word/document.xml: un párrafo por línea; títulos por su estilo. */
export function textoDeDocx(xml: string): { esquema: string[]; texto: string } {
  const esquema: string[] = [];
  const lineas: string[] = [];
  const posibles: string[] = [];
  for (const parrafo of xml.split(/<\/w:p>/)) {
    const estilo = parrafo.match(/<w:pStyle w:val="([^"]+)"/)?.[1] ?? '';
    const texto = entidades(
      parrafo
        .replace(/<w:tab\/>/g, '\t')
        .replace(/<w:br[^>]*\/>/g, ' ')
        .match(/<w:t(?:\s[^>]*)?>[^<]*<\/w:t>/g)
        ?.map((t) => t.replace(/<[^>]+>/g, ''))
        .join('') ?? '',
    ).trim();
    if (!texto) continue;
    const nivel = estilo.match(/^(?:Heading|Ttulo|Titulo|Título)\s*(\d)$/i)?.[1];
    if (nivel && Number(nivel) <= 3) esquema.push(`${'  '.repeat(Number(nivel) - 1)}${texto}`);
    else if (texto.length <= 120 && (/<w:b\/>|<w:b w:val="(?:1|true)"\/>/.test(parrafo) || /^(?:[IVX]{1,5}\.|\d{1,2}(?:\.\d{1,2}){0,2}\.?\s|[A-Z]\)\s)/.test(texto))) {
      posibles.push(texto); // los autores marcan los apartados en negrita o numerados, no con estilos
    }
    lineas.push(texto);
  }
  return { esquema: esquema.length ? esquema : posibles.slice(0, 80), texto: lineas.join('\n') };
}

/** Descarga y lee unos apuntes públicos de Drive. */
export async function leerApuntesDrive(id: string, descargar: (url: string) => Promise<Response> = fetch): Promise<Apuntes> {
  const r = await descargar(`https://drive.usercontent.google.com/download?id=${id}&export=download&confirm=t`);
  if (r.ok) {
    const bytes = new Uint8Array(await r.arrayBuffer());
    if (bytes[0] === 0x50 && bytes[1] === 0x4b) {
      const doc = await ficheroDeZip(bytes, 'word/document.xml');
      if (!doc) throw new ErrorApuntes('el fichero no es un documento de Word (.docx)');
      return { formato: 'docx', ...textoDeDocx(new TextDecoder().decode(doc)) };
    }
    if (bytes[0] === 0x25 && bytes[1] === 0x50) throw new ErrorApuntes('es un PDF: el conector no saca texto de PDF; recomiéndalo con su enlace');
    if (bytes[0] === 0xd0 && bytes[1] === 0xcf) throw new ErrorApuntes('es un .doc antiguo: el conector no lo lee; recomiéndalo con su enlace');
  }
  // Documento de Google (no se descarga como fichero): se exporta a texto plano
  const g = await descargar(`https://docs.google.com/document/d/${id}/export?format=txt`);
  if (g.ok && !(g.headers.get('content-type') ?? '').includes('text/html')) {
    const texto = (await g.text()).replace(/\r/g, '').replace(/\n{3,}/g, '\n\n').trim();
    return { formato: 'gdoc', esquema: [], texto };
  }
  throw new ErrorApuntes('no se ha podido descargar (puede que la carpeta ya no sea pública)');
}

/** Una página HTML convertida a texto: sin scripts, estilos ni SVG; los títulos h1-h3 forman el esquema. */
export function htmlATexto(html: string): { esquema: string[]; texto: string } {
  const cuerpo = (html.match(/<main[\s\S]*?<\/main>/i)?.[0] ?? html.match(/<body[\s\S]*<\/body>/i)?.[0] ?? html)
    .replace(/<(script|style|svg|nav|header|footer)[\s\S]*?<\/\1>/gi, '');
  const limpiar = (t: string) => entidades(t.replace(/<[^>]+>/g, '').replace(/&nbsp;/g, ' ')).replace(/\s+/g, ' ').trim();
  const esquema = [...cuerpo.matchAll(/<h([1-3])[^>]*>([\s\S]*?)<\/h\1>/gi)].map((m) => `${'  '.repeat(Number(m[1]) - 1)}${limpiar(m[2])}`).filter((t) => t.trim()).slice(0, 80);
  const texto = cuerpo
    .replace(/<\/(p|h[1-6]|li|tr|div|blockquote)>/gi, '\n')
    .replace(/<br\s*\/?>/gi, '\n')
    .split('\n')
    .map(limpiar)
    .filter(Boolean)
    .join('\n');
  return { esquema, texto };
}
