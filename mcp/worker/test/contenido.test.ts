import { describe, expect, it } from 'vitest';
import { apartadosDe, codigoConPuntos, extraerApartado, normalizarCodigo } from '../src/contenido';

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
