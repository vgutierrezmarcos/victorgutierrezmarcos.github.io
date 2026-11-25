import { describe, expect, it } from 'vitest';
import { apartadosDe, codigoConPuntos, extraerApartado, normalizarCodigo , buscarEnMd } from '../src/contenido';

const md = `# Tema 3.A.8. Teoría de la demanda

## Introducción (2′30″)

Enganche.

## I. Fundamentos de la elección racional (11′)

Axiomas.

## II. Estática comparativa (8′)

Slutsky.

## Conclusión (1′)

Fin.

## B. Anexo: derivaciones

Cálculo.
`;

describe('códigos de tema', () => {
  it('normaliza las formas habituales', () => {
    for (const e of ['3.A.8', '3A08', '3a8', '3-A-8', ' 3.a.08 ']) expect(normalizarCodigo(e)).toBe('3A08');
    expect(normalizarCodigo('3.A.24')).toBe('3A24');
    expect(normalizarCodigo('1D01')).toBe('1D01');
    expect(normalizarCodigo('tema 8')).toBeNull();
    expect(codigoConPuntos('3A08')).toBe('3.A.8');
  });
});

describe('apartados', () => {
  it('lista los apartados de nivel 2', () => {
    expect(apartadosDe(md)).toEqual(['Introducción (2′30″)', 'I. Fundamentos de la elección racional (11′)', 'II. Estática comparativa (8′)', 'Conclusión (1′)', 'B. Anexo: derivaciones']);
  });

  it('extrae por etiqueta («II», «B»), por principio o por parte del título, sin acentos', () => {
    expect(extraerApartado(md, 'II')).toBe('## II. Estática comparativa (8′)\n\nSlutsky.');
    expect(extraerApartado(md, 'b')).toBe('## B. Anexo: derivaciones\n\nCálculo.');
    expect(extraerApartado(md, 'introduccion')).toBe('## Introducción (2′30″)\n\nEnganche.');
    expect(extraerApartado(md, 'estatica comparativa')).toContain('Slutsky');
    expect(extraerApartado(md, 'I')).toContain('Axiomas');
    expect(extraerApartado(md, 'no existe')).toBeNull();
  });
});

describe('buscarEnMd', () => {
  const md = '# Tema\n\n## I. Comercio\n\n### I.1. Datos\n\nEl volumen del comercio mundial de mercancías creció un 4,2 % en 2025 (OMC, 2026).\n\n- Primera viñeta sobre aranceles.\n- Segunda viñeta: el comercio de servicios creció un 8 %.\n\n## II. Otra cosa\n\nNada que ver.\n';
  it('devuelve el pasaje con su apartado y respeta las cifras', () => {
    const r = buscarEnMd(md, 'comercio mundial 2025');
    expect(r).toHaveLength(1);
    expect(r[0].apartado).toBe('Tema › I. Comercio › I.1. Datos');
    expect(r[0].texto).toContain('4,2 %');
    expect(buscarEnMd(md, '4,2')[0].texto).toContain('OMC');
  });
  it('separa las viñetas y no inventa coincidencias', () => {
    expect(buscarEnMd(md, 'servicios')[0].texto).toBe('- Segunda viñeta: el comercio de servicios creció un 8 %.');
    expect(buscarEnMd(md, 'teorema de Arrow')).toEqual([]);
    expect(buscarEnMd('## I\n\nEl desarrollo del tema.\n', 'Arrow')).toEqual([]);
    expect(buscarEnMd('## I\n\nEl teorema de Arrow (1951).\n', 'Arrow')[0].apartado).toBe('I');
  });
});
