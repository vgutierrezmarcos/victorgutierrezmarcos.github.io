import { describe, expect, it } from 'vitest';
import { buscarEnTemario, formulasDe, normalizarPalabra, palabrasConsulta } from '../src/busqueda';
import { citasQueNoExisten } from '../src/herramientas';

describe('búsqueda en todo el temario', () => {
  it('normaliza igual que publicar-contenido.py', () => {
    expect(['Áreas', 'monetarias', 'óptimas', 'países', '4,2', 'Mundell', 'crisis', 'análisis'].map(normalizarPalabra)).toEqual(
      ['area', 'monetaria', 'optima', 'pais', '4,2', 'mundell', 'crisi', 'analisi'],
    );
    expect(palabrasConsulta('¿Cuánto creció el comercio mundial en 2025?')).toEqual(['cuanto', 'crecio', 'comercio', 'mundial', '2025']);
  });
  it('devuelve los pasajes que llevan más palabras de la consulta, con su tema y apartado', async () => {
    const kv: Record<string, string> = {
      'busqueda/meta.json': JSON.stringify({ pasajes: 3, media: 10, titulos: { '3B32': 'Perspectivas', '3B09': 'Comercio y crecimiento' }, trozos: { co: 0, mu: 0, '20': 0, vo: 0 } }),
      'busqueda/i/0.json': JSON.stringify({ comercio: '3B32:0:2:10,3B09:0:1:10,3B09:1:1:10', mundial: '3B32:0:1:10,3B09:1:1:10', '2025': '3B32:0:1:10', volumen: '3B32:0:1:10' }),
      'busqueda/t/3B32.json': JSON.stringify([['III. Situación', 'El volumen del comercio mundial creció un 4,2 % en 2025 (OMC, 2026).']]),
      'busqueda/t/3B09.json': JSON.stringify([['I. Idea', 'Comercio y crecimiento.'], ['II. Datos', 'El comercio mundial se duplicó.']]),
    };
    const r = await buscarEnTemario(async (k) => kv[k] ?? null, 'comercio mundial 2025 volumen');
    expect(r![0]).toMatchObject({ tema: '3B32', apartado: 'III. Situación', palabras: 4 });
    expect(r!.map((x) => x.tema)).toContain('3B09');
    expect(await buscarEnTemario(async () => null, 'x')).toBeNull();
  });
  it('saca las fórmulas literales', () => {
    expect(formulasDe('La utilidad $$U_t=u(c_t)+\\beta\\sum_s \\delta^s u(c_{t+s})$$ y $x$ corta.')).toEqual(['$$U_t=u(c_t)+\\beta\\sum_s \\delta^s u(c_{t+s})$$']);
  });
  it('detecta las citas a apartados que no existen', async () => {
    const md = '# Tema\n\n## I. Conceptos\n\n### I.2. Nash\n\ntexto\n\n## A. Anexo: test\n';
    const malas = await citasQueNoExisten('Bien [tema 3.A.14 · I.2] y [tema 3.A.14 · A] pero mal [tema 3.A.14 · III.4] y sin revisar [tema 4.A.1 · II]', async (c) => (c === '3A14' ? md : null));
    expect(malas).toEqual(['[tema 3.A.14 · III.4]']);
  });
});
