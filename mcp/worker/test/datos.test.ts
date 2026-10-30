import { describe, expect, it } from 'vitest';
import type { Json } from '../src/firestore';
import {
  aciertoPorTema,
  construirCronograma,
  construirInforme,
  cronogramaActivo,
  diaSemana,
  diaDe,
  horarioATexto,
  resumenCantes,
  resumenCronograma,
  resumenLeitner,
  resumenProgreso,
  resumenTest,
  temasDePreguntas,
} from '../src/datos';

const banco = temasDePreguntas({
  preguntas: [
    { id: 1, temas: ['3.A.8'], respuesta: ['a'] },
    { id: 2, temas: ['3.A.8'], respuesta: ['b'] },
    { id: 3, temas: ['3.B.4'], respuesta: ['c'] },
    { id: 4, temas: ['3.B.4', '3.A.1'], respuesta: ['d'] },
  ],
});

describe('acierto por tema', () => {
  it('cuenta correctas, incorrectas y sin responder por tema (una pregunta de dos temas cuenta en los dos)', () => {
    expect(aciertoPorTema({ '1': 'a', '2': 'c', '3': null, '4': 'D' }, banco)).toEqual({
      '3.A.8': { correctas: 1, incorrectas: 1, sinResponder: 0 },
      '3.B.4': { correctas: 1, incorrectas: 0, sinResponder: 1 },
      '3.A.1': { correctas: 1, incorrectas: 0, sinResponder: 0 },
    });
  });

  it('ignora preguntas que no están en el banco y los tests sin respuestas (web)', () => {
    expect(aciertoPorTema({ '999': 'a' }, banco)).toEqual({});
    const t = resumenTest('r1', { timestamp: '2026-10-28T09:30:00Z', notaSobre10: 6.444, correctas: 48, totalPreguntas: 75, temas: ['3.A.8'] }, banco);
    expect(t).toMatchObject({ id: 'r1', fecha: '2026-10-28', hora: '09:30', tipo: 'test', origen: 'web', notaSobre10: 6.44, correctas: 48, porTema: {} });
  });
});

describe('Leitner', () => {
  it('cuenta por caja, vence por sesiones o por días y saca los temas con más fallos', () => {
    const ahora = Date.UTC(2026, 9, 28);
    const estado = {
      sessionCount: 10,
      questions: {
        '1': { box: 1, lastSession: 10, timesFailed: 3, lastDate: ahora - 2 * 86_400_000 }, // vence por días
        '2': { box: 3, lastSession: 9, timesFailed: 1, lastDate: ahora }, // no vence
        '3': { box: 2, lastSession: 7, timesFailed: 2 }, // vence por sesiones
        '4': { box: 5, lastSession: 0, timesFailed: 0 }, // dominada: nunca vence
      },
    };
    const r = resumenLeitner(estado, banco.temas, ahora);
    expect(r.porCaja).toEqual({ '1': 1, '2': 1, '3': 1, '4': 0, '5': 1 });
    expect(r.vencidas).toBe(2);
    expect(r.temasConMasFallos).toEqual(['3.A.8', '3.B.4']);
  });
});

describe('progreso', () => {
  it('reúne ajustes, plan, Leitner y agenda en el formato de la skill', () => {
    const p = resumenProgreso(
      'tcee',
      { temasEstudiados: ['3.A.1', '3.A.2'], temasEnRepaso: ['3.A.8'], rubrica: ['Esquema', 'Rigor'], noCantar: ['3.A.2@2026-10-01T00:00:00.000'], fechaConvocatoria: '2027-03-06T00:00:00.000' },
      { fechas: { '1': '2027-03-06T00:00:00.000', '3': '2027-06-15T00:00:00.000' }, hitos: [{ id: 'h', titulo: 'Simulacro', fecha: '2027-02-20T00:00:00.000' }] },
      { sessionCount: 1, questions: {} },
      [
        { id: '3_A_8', datos: { tema: '3.A.8', texto: 'Repasar Slutsky', vueltas: ['2026-09-12T10:00:00.000'], pendientes: [{ id: 'a', texto: 'cruzado', creado: 'x', hecho: null, borrado: false }, { id: 'b', texto: 'ya', creado: 'x', hecho: 'y', borrado: false }] } },
        { id: '3_A_9', datos: { tema: '3.A.9', texto: '' } },
      ],
      banco.temas,
      new Date(Date.UTC(2026, 9, 28)),
    );
    expect(p.examen).toEqual({ fechas: { '1': '2027-03-06', '3': '2027-06-15' }, hitos: [{ titulo: 'Simulacro', fecha: '2027-02-20' }] });
    expect(p.temas).toEqual({ estudiados: ['3.A.1', '3.A.2'], enRepaso: ['3.A.8'], agenda: { '3.A.8': { vueltas: ['2026-09-12'], pendientes: ['cruzado'] } } });
    expect(p.notas).toEqual({ '3.A.8': 'Repasar Slutsky' });
    expect(p.ajustes).toEqual({ rubrica: ['Esquema', 'Rigor'], temasExtraidos: 3, fechaConvocatoria: '2027-03-06', noCantar: ['3.A.2'] });
    expect(p.leitner.porCaja['1']).toBe(0);
  });

  it('traduce el horario de franjas a texto', () => {
    const dia = '4'.repeat(10) + '7'.repeat(38); // estudio de 0:00 a 5:00
    const h = horarioATexto([dia, dia, dia, dia, dia, '7'.repeat(48), dia]);
    expect(h?.lunes).toBe('estudio 0-5');
    expect(h?.sábado).toBe('libre');
    expect(horarioATexto(null)).toBeNull();
  });
});

describe('cantes', () => {
  const docs: Array<{ id: string; datos: { [k: string]: Json } }> = [
    { id: 'a', datos: { fecha: '2026-10-10T18:00:00.000', estado: 'hecho', temas: ['3.A.8'], resultado: { temaCantado: '3.A.8', valoracion: 3 }, tareas: [{ id: 't', tipo: 'esquema', tema: '3.A.9', creada: 'x' }] } },
    { id: 'b', datos: { fecha: '2026-10-12T18:00:00.000', estado: 'hecho', esquema: true, temas: ['3.A.9'] } },
    { id: 'c', datos: { fecha: '2026-10-01T18:00:00.000', estado: 'hecho', borrado: true } },
    { id: 'd', datos: { fecha: '2099-01-01T18:00:00.000', estado: 'pendiente', temas: ['3.B.1'] } },
  ];
  it('devuelve los últimos hechos (sin borrados), los próximos pendientes y el total', () => {
    const r = resumenCantes(docs, 1, new Date('2026-10-28T00:00:00Z'));
    expect(r.totalHechos).toBe(2);
    expect(r.hechos.map((c) => c.id)).toEqual(['b']);
    expect(r.pendientes.map((c) => c.id)).toEqual(['d']);
    const todos = resumenCantes(docs, 10);
    expect(todos.hechos.map((c) => c.id)).toEqual(['b', 'a']);
    expect(todos.hechos[1]).toMatchObject({ fecha: '2026-10-10', hora: '18:00', esquema: false, resultado: { valoracion: 3 }, deberes: [{ texto: 'Esquema a ciegas de 3.A.9', hecha: false }] });
  });
});

describe('cronograma', () => {
  it('el activo es el no archivado más reciente', () => {
    const docs = [
      { id: 'viejo', datos: { archivado: true, creado: '2026-09-01T00:00:00.000' } },
      { id: 'nuevo', datos: { archivado: false, creado: '2026-10-01T00:00:00.000' } },
      { id: 'otro', datos: { archivado: false, creado: '2026-08-01T00:00:00.000' } },
    ];
    expect(cronogramaActivo(docs)?.id).toBe('nuevo');
    expect(cronogramaActivo([docs[0]])).toBeNull();
  });

  it('resume las semanas con la fecha del cante', () => {
    const r = resumenCronograma('x', { ejercicio: 3, inicio: '2026-10-05T00:00:00.000', diaCante: 7, semanas: [{ lunes: '2026-10-05T00:00:00.000', temas: ['3.A.8'] }, { lunes: '2026-10-12T00:00:00.000', temas: [], descanso: true }], hechos: { '3.A.8': '2026-10-10T18:00:00.000' }, propuestas: { p1: { de: 'p1' } } });
    expect(r.semanas).toEqual([{ lunes: '2026-10-05', cante: '2026-10-11', temas: ['3.A.8'] }, { lunes: '2026-10-12', cante: '2026-10-18', temas: [], descanso: true }]);
    expect(r.hechos).toEqual({ '3.A.8': '2026-10-10' });
    expect(r.propuestasPendientes).toBe(1);
  });

  it('construye el documento como Cronograma.toJson(): semanas del día siguiente al cante hasta el cante, descansos en medio', () => {
    expect(diaSemana(diaDe('2026-11-07')!)).toBe(6); // sábado
    const { documento, errores } = construirCronograma(
      { ejercicio: 3, diaCante: 6, semanas: [{ cante: '2026-11-07', temas: ['3.A.8', '3.A.9', '3.B.1'] }, { cante: '2026-11-14', temas: ['3.A.10', '3.B.2'] }, { cante: '2026-11-28', temas: ['3.A.11'] }] },
      new Date('2026-11-01T10:00:00Z'),
    );
    expect(errores).toEqual([]);
    expect(documento).toMatchObject({
      ejercicio: 3,
      temas: ['3.A.8', '3.A.9', '3.B.1', '3.A.10', '3.B.2', '3.A.11'],
      inicio: '2026-11-01T00:00:00.000',
      fin: '2026-11-28T00:00:00.000',
      temasPorSemana: 2,
      intercalar: true,
      cadaN: null,
      descansos: ['2026-11-15T00:00:00.000'],
      semanas: [
        { lunes: '2026-11-01T00:00:00.000', temas: ['3.A.8', '3.A.9', '3.B.1'] },
        { lunes: '2026-11-08T00:00:00.000', temas: ['3.A.10', '3.B.2'] },
        { lunes: '2026-11-15T00:00:00.000', temas: [], descanso: true },
        { lunes: '2026-11-22T00:00:00.000', temas: ['3.A.11'] },
      ],
      hechos: {},
      desmarcados: [],
      archivado: false,
      compartir: false,
      propuesta: null,
      propuestaResuelta: null,
      creado: '2026-11-01T10:00:00.000Z',
      updatedAt: '2026-11-01T10:00:00.000Z',
      diaCante: 6,
      manual: true,
    });
    expect(typeof documento.id).toBe('string');
    expect((documento.id as string).length).toBeGreaterThan(8);
    expect(documento).not.toHaveProperty('autor');
    expect(documento).not.toHaveProperty('fases');
  });

  it('rechaza fechas fuera del día de cante, temas repetidos o mal escritos y fechas inválidas', () => {
    const { errores } = construirCronograma({ ejercicio: 3, diaCante: 6, semanas: [{ cante: '2026-11-08', temas: ['3.A.8', '3A8', '3.A.8'] }, { cante: '2026-13-01', temas: [] }] });
    expect(errores).toEqual([
      'el cante del 2026-11-08 no cae en el día de cante (6)',
      'código de tema no válido: «3A8» (formato 3.A.8)',
      'el tema 3.A.8 está en dos semanas',
      'fecha de cante no válida: «2026-13-01» (AAAA-MM-DD)',
    ]);
  });
});

describe('informe del cante', () => {
  it('construye el documento del informe y los campos del resultado', () => {
    const r = construirInforme({ informe: '# Informe', valoracion: 3, valoraciones: { '3.A.8': 3, '3.B.1': 4 }, comentarios: ' Bien la intro ', criterios: { Esquema: 4 }, tareas: ['a', 'b'] }, new Date('2026-11-01T10:12:00.500Z'), 'ChatGPT');
    expect(r.errores).toEqual([]);
    expect(r.id).toBe('2026-11-01T10-12-00');
    expect(r.documento).toEqual({ fecha: '2026-11-01T10:12:00.500Z', origen: 'ia', cliente: 'ChatGPT', informe: '# Informe', valoracion: 3, valoraciones: { '3.A.8': 3, '3.B.1': 4 }, comentarios: 'Bien la intro', criterios: { Esquema: 4 }, tareas: ['a', 'b'] });
    expect(r.resultado).toEqual({ valoracion: 3, valoraciones: { '3.A.8': 3, '3.B.1': 4 }, comentarios: 'Bien la intro', criterios: { Esquema: 4 } });
  });

  it('sin valoración ni comentarios no toca el resultado', () => {
    const r = construirInforme({ informe: 'x' });
    expect(r.resultado).toEqual({});
    expect(r.errores).toEqual([]);
  });

  it('valida', () => {
    const r = construirInforme({ informe: '', valoracion: 7, valoraciones: { mal: 3 }, comentarios: 'x'.repeat(301) });
    expect(r.errores).toEqual(['el informe está vacío', 'valoracion tiene que ser un entero de 1 a 5', 'valoración no válida para «mal»', 'comentarios tiene que tener 300 caracteres como mucho']);
  });
});
