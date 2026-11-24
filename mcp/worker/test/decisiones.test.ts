// Los botones del correo de sugerencias: enlaces firmados, un GET nunca decide y el POST apunta la decisión.
import { describe, expect, it } from 'vitest';
import { atenderDecisiones, firma } from '../src/decisiones';

const SECRETO = 'secreto-de-prueba';
const kv = () => {
  const m = new Map<string, string>();
  return { m, get: async (k: string) => m.get(k) ?? null, put: async (k: string, v: string) => void m.set(k, v) };
};
const pedir = (ruta: string, cuerpo?: Record<string, string>) =>
  new Request(`https://mcp.example${ruta}`, cuerpo ? { method: 'POST', body: new URLSearchParams(cuerpo), headers: { 'Content-Type': 'application/x-www-form-urlencoded' } } : undefined);

describe('decisiones del autor', () => {
  it('las rutas que no son suyas se dejan pasar', async () => {
    expect(await atenderDecisiones(pedir('/authorize'), kv(), SECRETO)).toBeNull();
  });

  it('el informe solo se sirve con su firma', async () => {
    const a = kv();
    a.m.set('informe:2026-11-12', '<p>Informe del día</p>');
    const f = await firma(SECRETO, 'informe', '2026-11-12');
    expect((await atenderDecisiones(pedir('/informe?c=2026-11-12&f=mala'), a, SECRETO))!.status).toBe(403);
    const r = (await atenderDecisiones(pedir(`/informe?c=2026-11-12&f=${f}`), a, SECRETO))!;
    expect(r.status).toBe(200);
    expect(await r.text()).toContain('Informe del día');
    // La firma de un informe no vale para decidir.
    expect((await atenderDecisiones(pedir(`/decidir?i=2026-11-12&e=aceptada&f=${f}`), a, SECRETO))!.status).toBe(403);
  });

  it('abrir el enlace enseña la sugerencia sin decidir nada; confirmar apunta la decisión', async () => {
    const a = kv();
    a.m.set('sug:s_abc', JSON.stringify({ recurso: 'tema', tema: '3.A.8', titulo: '3.A.8 · Demanda', tipo: 'no_explica', propuesta: 'Falta <Slutsky>.', motivo: 'Cierto.', cambio: { actual: 'A', propuesto: 'B', fuente: 'Varian' } }));
    const f = await firma(SECRETO, 'decidir', 's_abc');
    const ver = (await atenderDecisiones(pedir(`/decidir?i=s_abc&e=aceptada&f=${f}`), a, SECRETO))!;
    const pagina = await ver.text();
    expect(ver.status).toBe(200);
    expect(pagina).toContain('Falta &#60;Slutsky&#62;.');
    expect(pagina).toContain('method="post"');
    expect(a.m.has('decision:s_abc')).toBe(false);
    const hecho = (await atenderDecisiones(pedir('/decidir', { i: 's_abc', e: 'aceptada', f, nota: 'Pero más corto.' }), a, SECRETO))!;
    expect(hecho.status).toBe(200);
    expect(JSON.parse(a.m.get('decision:s_abc')!)).toMatchObject({ estado: 'aceptada', nota: 'Pero más corto.' });
    // Se puede cambiar de idea antes de la siguiente pasada del agente.
    await atenderDecisiones(pedir('/decidir', { i: 's_abc', e: 'descartada', f }), a, SECRETO);
    expect(JSON.parse(a.m.get('decision:s_abc')!).estado).toBe('descartada');
  });

  it('rechaza firmas malas, estados raros y sugerencias que no están', async () => {
    const a = kv();
    a.m.set('sug:s_abc', '{}');
    const f = await firma(SECRETO, 'decidir', 's_abc');
    expect((await atenderDecisiones(pedir('/decidir', { i: 's_abc', e: 'aceptada', f: 'x'.repeat(32) }), a, SECRETO))!.status).toBe(403);
    expect((await atenderDecisiones(pedir('/decidir', { i: 's_abc', e: 'publicada', f }), a, SECRETO))!.status).toBe(400);
    expect((await atenderDecisiones(pedir(`/decidir?i=s_otra&e=aceptada&f=${await firma(SECRETO, 'decidir', 's_otra')}`), a, SECRETO))!.status).toBe(404);
    expect(a.m.has('decision:s_abc')).toBe(false);
  });
});
