// Dictámenes de práctica y prensa por idiomas: elección del país, anonimización, lectura de RSS y filtros.
import { describe, expect, it } from 'vitest';
import { articulosDe, codigoIdioma, leerRss, mediosPara, prepararDictamen } from '../src/practica';
import { bancoPrueba, mediosPrueba as medios } from './datos-practica';

describe('prepararDictamen', () => {
  it('sin opciones elige un emergente o avanzado fuera de la UE, con años reales y el país oculto', () => {
    const r = prepararDictamen(bancoPrueba, {}, () => 0);
    expect(r.ok).toBe(true);
    if (!r.ok) return;
    const d = r.dictamen;
    expect(d.oculto.pais).toBe('Marruecos');
    expect(d.configuracion).toMatchObject({ duracionMin: 105, preguntas: 6, dificultad: 'examen' });
    expect(d.configuracion.porDefecto).toEqual(expect.arrayContaining(['momento', 'tipo', 'region', 'duracion']));
    expect(d.anios.etiquetas).toEqual(['2018', '2019', '2020', '2021', '2022', '2023', '2024', '2025', '2026', '2027']);
    expect(d.anios.proyeccionDesde).toBe('2026');
    // Lo que delata el país no va en el cuadro: el PIB en dólares y el nivel del tipo de cambio, al bloque oculto.
    expect(d.cuadro.map((f) => f.id)).not.toContain('pib_usd');
    expect(d.cuadro.map((f) => f.id)).not.toContain('tipo_cambio');
    expect(d.oculto.delatoras.map((f) => f.id)).toEqual(['pib_usd', 'tipo_cambio']);
    expect(d.cuadro.find((f) => f.id === 'tipo_cambio_var')?.grupo).toBe('Competitividad y tipo de cambio');
    const publico = JSON.stringify({ ...d, oculto: undefined });
    expect(publico).not.toMatch(/Marruecos|MAR|dírham/);
    // Señales con el último dato disponible (el crédito acaba en 2025).
    expect(d.senales.map((s) => s.indicador)).toEqual(expect.arrayContaining(['inflacion', 'saldo_corriente']));
  });

  it('filtra por tipo y región, y avisa si nada cumple', () => {
    const r = prepararDictamen(bancoPrueba, { tipo: 'en_desarrollo' });
    expect(r.ok && r.dictamen.oculto.iso).toBe('KEN');
    const nada = prepararDictamen(bancoPrueba, { tipo: 'avanzado', region: 'africa_subsahariana' });
    expect(nada).toMatchObject({ ok: false, fueraDelBanco: true });
    expect(!nada.ok && nada.fuentesOficiales.length).toBeGreaterThan(3);
  });

  it('un episodio va con años relativos, sin datos posteriores a T y con los años reales ocultos', () => {
    const r = prepararDictamen(bancoPrueba, { episodio: 'sequía' });
    expect(r.ok).toBe(true);
    if (!r.ok) return;
    expect(r.dictamen.anios.etiquetas).toEqual(['T−7', 'T−6', 'T−5', 'T−4', 'T−3', 'T−2', 'T−1', 'T']);
    expect(r.dictamen.oculto.aniosReales?.T).toBe(2022);
    expect(r.dictamen.oculto.episodio?.titulo).toBe('Sequía marroquí');
  });

  it('un país o un año fuera del banco devuelve fueraDelBanco', () => {
    expect(prepararDictamen(bancoPrueba, { pais: 'Vanuatu' })).toMatchObject({ ok: false, fueraDelBanco: true });
    expect(prepararDictamen(bancoPrueba, { pais: 'kenia', anio: 2027 })).toMatchObject({ ok: false });
    const esp = prepararDictamen(bancoPrueba, { pais: 'España', variables: ['pib_real', 'inexistente'] });
    expect(esp.ok && esp.dictamen.variablesFuera).toEqual(['inexistente']);
    expect(esp.ok && esp.dictamen.cuadro.map((f) => f.id)).toEqual(['pib_real']);
  });

  it('excluye los países ya hechos', () => {
    // España está en la UE y Kenia es en desarrollo: sin Marruecos no queda nadie con los valores por defecto.
    expect(prepararDictamen(bancoPrueba, { excluir: ['Marruecos'] }, () => 0).ok).toBe(false);
    // Pidiendo «avanzado», la UE sí entra.
    const r = prepararDictamen(bancoPrueba, { tipo: 'avanzado', excluir: ['MAR'] }, () => 0);
    expect(r.ok && r.dictamen.oculto.iso).toBe('ESP');
  });
});

describe('prensa', () => {
  it('lee RSS 2.0, RDF y Atom con CDATA y entidades', () => {
    const rss = `<rss><channel><title>X</title><item><title><![CDATA[Tariffs &amp; trade]]></title><link>https://e/a?utm=1</link><pubDate>Fri, 20 Nov 2026 10:00:00 +0000</pubDate><description>&lt;p&gt;Texto &#233;conomique&lt;/p&gt;</description></item></channel></rss>`;
    expect(leerRss(rss)).toEqual([{ titulo: 'Tariffs & trade', url: 'https://e/a?utm=1', fecha: '2026-11-20T10:00:00.000Z', extracto: 'Texto économique' }]);
    const atom = `<feed><entry><title>Hola</title><link rel="alternate" href="https://a/1"/><updated>2026-11-19T08:00:00Z</updated><summary>Res</summary></entry></feed>`;
    expect(leerRss(atom)[0]).toMatchObject({ titulo: 'Hola', url: 'https://a/1', fecha: '2026-11-19T08:00:00.000Z' });
    const rdf = `<rdf:RDF><item rdf:about="https://n/1"><title>景気</title><link>https://n/1</link><dc:date>2026-11-20T22:20:15+09:00</dc:date></item></rdf:RDF>`;
    expect(leerRss(rdf)[0]).toMatchObject({ titulo: '景気', fecha: '2026-11-20T13:20:15.000Z' });
  });

  it('reconoce el idioma en español, en código o en inglés', () => {
    expect(codigoIdioma(medios, 'Francés')).toBe('fr');
    expect(codigoIdioma(medios, 'en')).toBe('en');
    expect(codigoIdioma(medios, 'French')).toBe('fr');
    expect(codigoIdioma(medios, 'klingon')).toBeNull();
  });

  it('elige medios por acceso y suscripciones, sin los rotos', () => {
    expect(mediosPara(medios, { idioma: 'en', acceso: 'todos', suscripciones: [] }).map((m) => m.id)).toEqual(['eco', 'bbc']);
    expect(mediosPara(medios, { idioma: 'en', acceso: 'libre', suscripciones: ['eco'] }).map((m) => m.id)).toEqual(['bbc']);
    expect(mediosPara(medios, { idioma: 'en', acceso: 'mis_suscripciones', suscripciones: ['eco'] }).map((m) => m.id)).toEqual(['eco', 'bbc']);
  });

  it('se queda con lo económico, la temática y lo reciente, y marca las suscripciones', () => {
    const ahora = new Date('2026-11-20T12:00:00Z');
    const e = (titulo: string, dias: number, url = `https://x/${titulo}`) => ({ titulo, url, fecha: new Date(ahora.getTime() - dias * 86_400_000).toISOString(), extracto: '' });
    const leidas = [
      { medio: medios.medios[0], entradas: [e('Tariff war', 1), e('Central bank meets', 2), e('Old tariff story', 20)] },
      { medio: medios.medios[1], entradas: [e('Football final', 0), e('New tariff on steel', 3), e('Tariff war', 1, 'https://x/Tariff war')] },
    ];
    const todos = articulosDe(medios, leidas, { idioma: 'en', acceso: 'todos', dias: 7, n: 10, suscripciones: ['eco'], ahora });
    // La BBC es general: «Football final» no pasa el filtro de economía; el duplicado y el viejo, fuera.
    expect(todos.map((a) => a.titulo)).toEqual(['Tariff war', 'Central bank meets', 'New tariff on steel']);
    expect(todos[0]).toMatchObject({ medio: 'The Economist', acceso: 'pago', tuSuscripcion: true });
    const comercio = articulosDe(medios, leidas, { idioma: 'en', tematica: 'comercio', acceso: 'todos', dias: 7, n: 10, suscripciones: [], ahora });
    expect(comercio.map((a) => a.titulo)).toEqual(['Tariff war', 'New tariff on steel']);
  });
});
