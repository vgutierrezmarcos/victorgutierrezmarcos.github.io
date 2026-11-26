import { describe, expect, it } from 'vitest';
import { atenderTemario, HORAS_ACCESO, prefijoAcceso } from '../src/temarioPrivado';

/** R2 de mentira: get (con rango), put, list y delete en memoria. */
function r2(datos: Record<string, string>) {
  const mapa = new Map(Object.entries(datos).map(([k, v]) => [k, { v, sha: '' }]));
  return {
    async get(k: string, op?: { range?: Headers }) {
      const o = mapa.get(k);
      if (!o) return null;
      const bytes = new TextEncoder().encode(o.v);
      let cuerpo = bytes;
      let range: { offset: number; length: number } | undefined;
      const m = op?.range ? /bytes=(\d+)-(\d+)/.exec(op.range.get('Range') ?? '') : null;
      if (m) {
        range = { offset: Number(m[1]), length: Number(m[2]) - Number(m[1]) + 1 };
        cuerpo = bytes.slice(range.offset, range.offset + range.length);
      }
      return { body: new Blob([cuerpo]).stream(), size: bytes.length, httpEtag: '"e"', range };
    },
    async put(k: string, cuerpo: ReadableStream, op: { customMetadata: { sha: string } }) {
      mapa.set(k, { v: await new Response(cuerpo).text(), sha: op.customMetadata.sha });
    },
    async list() {
      return { objects: [...mapa].map(([key, o]) => ({ key, size: o.v.length, customMetadata: { sha: o.sha } })), truncated: false };
    },
    async delete(k: string) {
      mapa.delete(k);
    },
  } as unknown as R2Bucket;
}

const AHORA = 1_800_000_000;
const env = (datos: Record<string, string>) => ({ TEMARIO: r2(datos), FIREBASE_API_KEY: 'k', CLAVE_CIFRADO: 'secreto', URL_WORKER: 'https://mcp.example', ADMIN_TEMARIO: 'admin' });
const firebase = (ok: boolean) => (async () => new Response(JSON.stringify(ok ? { users: [{ localId: 'u1', email: 'a@b.c', providerUserInfo: [{ providerId: 'google.com' }] }] } : { error: {} }), { status: ok ? 200 : 400 })) as unknown as typeof fetch;
const ahora = () => AHORA;
const pide = (e: ReturnType<typeof env>, url: string, init?: RequestInit, fb = firebase(true)) => atenderTemario(new Request(url, init), e, fb, ahora);

describe('temario privado', () => {
  it('no es suya otra ruta', async () => {
    expect(await pide(env({}), 'https://mcp.example/app/banco')).toBeNull();
  });

  it('el manifiesto es público; el acceso, solo con sesión', async () => {
    const e = env({ 'manifiesto.json': '{"temas":[]}' });
    expect(await (await pide(e, 'https://mcp.example/temario/manifiesto'))!.text()).toBe('{"temas":[]}');
    expect((await pide(e, 'https://mcp.example/temario/acceso', {}, firebase(false)))!.status).toBe(401);
    // Una cuenta anónima (sin proveedor de Google) no vale
    const anonima = (async () => new Response(JSON.stringify({ users: [{ localId: 'u2', providerUserInfo: [] }] }))) as unknown as typeof fetch;
    expect((await pide(e, 'https://mcp.example/temario/acceso', { headers: { Authorization: 'Bearer t' } }, anonima))!.status).toBe(401);
    const r = await pide(e, 'https://mcp.example/temario/acceso', { headers: { Authorization: 'Bearer t', Origin: 'https://www.victorgutierrezmarcos.es' } });
    expect(r!.status).toBe(200);
    expect(r!.headers.get('Access-Control-Allow-Origin')).toBe('https://www.victorgutierrezmarcos.es');
    const { base, expira } = (await r!.json()) as { base: string; expira: number };
    expect(expira).toBe(AHORA + HORAS_ACCESO * 3600);
    expect(base).toBe(`https://mcp.example/t/${await prefijoAcceso(expira, 'secreto')}/`);
  });

  it('el fichero, solo con un prefijo firmado y sin caducar', async () => {
    const e = env({ 'oposicion/temario/tercer-ejercicio/3A08.pdf': 'PDF-NUEVO', 'manifiesto.json': '{}' });
    const p = await prefijoAcceso(AHORA + 3600, 'secreto');
    const r = await pide(e, `https://mcp.example/t/${p}/oposicion/temario/tercer-ejercicio/3A08.pdf`);
    expect(r!.status).toBe(200);
    expect(r!.headers.get('Content-Type')).toBe('application/pdf');
    expect(await r!.text()).toBe('PDF-NUEVO');
    // Rango (el visor de PDF lo pide)
    const rr = await pide(e, `https://mcp.example/t/${p}/oposicion/temario/tercer-ejercicio/3A08.pdf`, { headers: { Range: 'bytes=0-2' } });
    expect(rr!.status).toBe(206);
    expect(rr!.headers.get('Content-Range')).toBe('bytes 0-2/9');
    expect(await rr!.text()).toBe('PDF');
    // Firma mala, caducado, demasiado largo, «..» y el manifiesto por esta vía
    expect((await pide(e, `https://mcp.example/t/${AHORA + 3600}.${'0'.repeat(32)}/oposicion/temario/tercer-ejercicio/3A08.pdf`))!.status).toBe(403);
    const viejo = await prefijoAcceso(AHORA - 1, 'secreto');
    expect((await pide(e, `https://mcp.example/t/${viejo}/oposicion/temario/tercer-ejercicio/3A08.pdf`))!.status).toBe(403);
    const eterno = await prefijoAcceso(AHORA + 365 * 86400, 'secreto');
    expect((await pide(e, `https://mcp.example/t/${eterno}/oposicion/temario/tercer-ejercicio/3A08.pdf`))!.status).toBe(403);
    expect((await pide(e, `https://mcp.example/t/${p}/oposicion/../manifiesto.json`))!.status).toBe(404);
    expect((await pide(e, `https://mcp.example/t/${p}/manifiesto.json`))!.status).toBe(404);
    expect((await pide(e, `https://mcp.example/t/${p}/oposicion/temario/tercer-ejercicio/3A09.pdf`))!.status).toBe(404);
  });

  it('subida y lista solo con el secreto de administración', async () => {
    const e = env({});
    expect((await pide(e, 'https://mcp.example/temario/admin/lista'))!.status).toBe(401);
    const auth = { Authorization: 'Bearer admin' };
    expect((await pide(e, 'https://mcp.example/temario/admin/f/oposicion/temario/x.pdf?sha=abc', { method: 'PUT', body: 'X', headers: auth }))!.status).toBe(200);
    const l = (await (await pide(e, 'https://mcp.example/temario/admin/lista', { headers: auth }))!.json()) as { claves: Array<{ clave: string; sha: string }> };
    expect(l.claves).toEqual([{ clave: 'oposicion/temario/x.pdf', sha: 'abc', tamano: 1 }]);
    expect((await pide(e, 'https://mcp.example/temario/admin/f/oposicion/temario/x.pdf', { method: 'DELETE', headers: auth }))!.status).toBe(200);
  });
});
