import { describe, expect, it } from 'vitest';
import { aCampos, aValor, deCampos, deValor, idDe, type Json } from '../src/firestore';

describe('conversión de valores de Firestore', () => {
  it('JSON → valor tipado: enteros, decimales, textos, booleanos, nulos, listas y mapas', () => {
    expect(aValor(3)).toEqual({ integerValue: '3' });
    expect(aValor(6.4)).toEqual({ doubleValue: 6.4 });
    expect(aValor('3.A.8')).toEqual({ stringValue: '3.A.8' });
    expect(aValor(true)).toEqual({ booleanValue: true });
    expect(aValor(null)).toEqual({ nullValue: null });
    expect(aValor(['a', 1])).toEqual({ arrayValue: { values: [{ stringValue: 'a' }, { integerValue: '1' }] } });
    expect(aValor({ x: { y: [] } })).toEqual({ mapValue: { fields: { x: { mapValue: { fields: { y: { arrayValue: { values: [] } } } } } } } });
  });

  it('valor tipado → JSON, con integerValue como texto y marcas de tiempo como ISO', () => {
    expect(deValor({ integerValue: '42' })).toBe(42);
    expect(deValor({ doubleValue: 2.5 })).toBe(2.5);
    expect(deValor({ timestampValue: '2026-10-28T10:00:00Z' })).toBe('2026-10-28T10:00:00Z');
    expect(deValor({ arrayValue: {} })).toEqual([]);
    expect(deValor({ mapValue: {} })).toEqual({});
    expect(deValor({ nullValue: null })).toBeNull();
  });

  it('ida y vuelta de un documento como los de la app (cronograma)', () => {
    const doc: { [k: string]: Json } = {
      id: 'abc',
      ejercicio: 3,
      temas: ['3.A.8', '3.A.9'],
      inicio: '2026-10-05T00:00:00.000',
      fin: null,
      intercalar: true,
      cadaN: null,
      semanas: [{ lunes: '2026-10-05T00:00:00.000', temas: ['3.A.8'] }, { lunes: '2026-10-12T00:00:00.000', temas: [], descanso: true }],
      hechos: { '3.A.8': '2026-10-10T18:00:00.000' },
      temasPorSemana: 3,
      manual: true,
    };
    expect(deCampos(aCampos(doc))).toEqual(doc);
  });

  it('idDe saca el último tramo del nombre', () => {
    expect(idDe({ name: 'projects/web-vgm/databases/(default)/documents/users/u1/cantes/c9' })).toBe('c9');
  });
});
