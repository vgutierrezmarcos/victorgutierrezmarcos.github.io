// Lectura de .docx sin dependencias: un ZIP «stored» hecho a mano con word/document.xml.
import { describe, expect, it } from 'vitest';
import { ficheroDeZip, htmlATexto, idDeDrive, leerApuntesDrive, textoDeDocx } from '../src/drive';

function zipStored(nombre: string, contenido: string): Uint8Array {
  const n = new TextEncoder().encode(nombre);
  const d = new TextEncoder().encode(contenido);
  const local = new Uint8Array(30 + n.length + d.length);
  const v = new DataView(local.buffer);
  v.setUint32(0, 0x04034b50, true); v.setUint32(18, d.length, true); v.setUint32(22, d.length, true); v.setUint16(26, n.length, true);
  local.set(n, 30); local.set(d, 30 + n.length);
  const central = new Uint8Array(46 + n.length);
  const c = new DataView(central.buffer);
  c.setUint32(0, 0x02014b50, true); c.setUint32(20, d.length, true); c.setUint32(24, d.length, true); c.setUint16(28, n.length, true); c.setUint32(42, 0, true);
  central.set(n, 46);
  const fin = new Uint8Array(22);
  const f = new DataView(fin.buffer);
  f.setUint32(0, 0x06054b50, true); f.setUint16(8, 1, true); f.setUint16(10, 1, true); f.setUint32(12, central.length, true); f.setUint32(16, local.length, true);
  const out = new Uint8Array(local.length + central.length + fin.length);
  out.set(local, 0); out.set(central, local.length); out.set(fin, local.length + central.length);
  return out;
}

const XML = '<w:document><w:body><w:p><w:pPr><w:pStyle w:val="Heading1"/></w:pPr><w:r><w:t>I. Introducción</w:t></w:r></w:p><w:p><w:r><w:t xml:space="preserve">Texto &amp; más </w:t></w:r><w:r><w:t>texto</w:t></w:r></w:p></w:body></w:document>';

describe('apuntes de Drive', () => {
  it('saca el id de un enlace', () => {
    expect(idDeDrive('https://drive.google.com/file/d/1L2l6_WN-xnvB6HlcLZWDT2GixLqnEJxH/view')).toBe('1L2l6_WN-xnvB6HlcLZWDT2GixLqnEJxH');
    expect(idDeDrive('hola')).toBeNull();
  });
  it('lee word/document.xml de un ZIP y separa títulos y texto', async () => {
    const zip = zipStored('word/document.xml', XML);
    const xml = new TextDecoder().decode((await ficheroDeZip(zip, 'word/document.xml'))!);
    expect(textoDeDocx(xml)).toEqual({ esquema: ['I. Introducción'], texto: 'I. Introducción\nTexto & más texto' });
  });
  it('descarga un .docx y rechaza los PDF', async () => {
    const zip = zipStored('word/document.xml', XML);
    const docx = await leerApuntesDrive('x', async () => new Response(zip));
    expect(docx.formato).toBe('docx');
    await expect(leerApuntesDrive('x', async () => new Response('%PDF-1.4'))).rejects.toThrow('PDF');
  });
  it('convierte una página a texto con su esquema', () => {
    const r = htmlATexto('<html><body><nav>menú</nav><main><h1>Tema A3</h1><p>Uno &amp; dos</p><script>x</script><h2>I. Preferencias</h2><p>Texto</p></main></body></html>');
    expect(r.esquema).toEqual(['Tema A3', '  I. Preferencias']);
    expect(r.texto).toBe('Tema A3\nUno & dos\nI. Preferencias\nTexto');
  });
});
