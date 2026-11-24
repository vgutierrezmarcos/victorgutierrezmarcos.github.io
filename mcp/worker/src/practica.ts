// Dictámenes de práctica y prensa por idiomas: la lógica sin red ni Firestore, para probarla aparte.
//
// - El banco de países (oposicion/datos/paises-dictamen.json, de scripts/paises-dictamen.py, FMI WEO + Banco Mundial)
//   da los datos del cuadernillo: aquí se elige el país según lo que pida el opositor, se pasan los años a T−n y se separa
//   lo que lo delataría (nombre, moneda, tamaño) en un bloque que la IA no enseña hasta la guía de resolución.
// - La lista de medios (oposicion/datos/prensa-medios.json, de scripts/prensa.py) dice qué fuentes RSS leer en cada idioma;
//   aquí se leen esas fuentes y se filtran a lo económico y a la temática pedida.

// ------------------------------------------------------------------ Dictamen

export interface VariablePais {
  id: string;
  codigo: string;
  fuente: 'weo' | 'wdi';
  grupo: string;
  nombre: string;
  unidad: string;
}
export interface PaisBanco {
  iso: string;
  nombre: string;
  tipo: 'avanzado' | 'emergente' | 'en_desarrollo';
  region: string;
  materiasPrimas: string | null;
  regimenCambiario: string;
  moneda: string;
  urlFmi: string;
  /** Una lista de valores por variable, desde el año «desde» del banco (null donde no hay dato). */
  series: Record<string, Array<number | null>>;
}
export interface EpisodioBanco {
  id: string;
  iso: string;
  anioT: number;
  titulo: string;
  foco: string;
}
export interface BancoPaises {
  actualizado: string;
  desde: number;
  fuentes: { weo: { nombre: string; edicion: string | null; primerAnioProyeccion: number | null; url: string }; wdi: { nombre: string; url: string } };
  variables: VariablePais[];
  paises: PaisBanco[];
  episodios: EpisodioBanco[];
}

export const TIPOS_PAIS = ['avanzado', 'emergente', 'en_desarrollo', 'materias_primas'] as const;
export const REGIONES = ['europa', 'america_norte', 'america_latina', 'asia_oriental', 'asia_sur', 'asia_central', 'oriente_medio_norte_africa', 'africa_subsahariana', 'oceania'] as const;
export const DIFICULTADES = ['basica', 'examen', 'exigente'] as const;

/** Los de la UE: el valor por defecto los deja fuera (para España ya está el examen de la guía 1D01). */
const UE = new Set(['DEU', 'FRA', 'ITA', 'ESP', 'PRT', 'GRC', 'IRL', 'NLD', 'BEL', 'AUT', 'FIN', 'CZE', 'DNK', 'SWE', 'POL', 'HUN', 'ROU', 'BGR']);

/** Nombres ficticios para el país del cuadernillo (Narnia y Meridia ya están en los simulacros de la web). */
const NOMBRES_FICTICIOS = ['Velmora', 'Castrania', 'Orvenia', 'Sardelia', 'Talvera', 'Brisenia', 'Calduria', 'Montaria', 'Esterlia', 'Norvania', 'Quiralia', 'Lusandria', 'Aldavia', 'Fenoria', 'Tirania'];

/** Variables que delatan el país si se dan tal cual: van en el bloque oculto (la IA las usa en ratios o redondeadas). */
const DELATORAS = new Set(['poblacion', 'pib_usd', 'pib_pc_usd', 'empleo', 'tipo_cambio', 'factor_ppa']);

/** Fuentes oficiales válidas para lo que no está en el banco (la IA no puede usar otras). */
export const FUENTES_OFICIALES = [
  'FMI: World Economic Outlook (base de datos), artículo IV del país y sus «Selected Issues», International Financial Statistics, External Sector Report (imf.org, data.imf.org)',
  'Banco Mundial: World Development Indicators, International Debt Statistics, informes de país (data.worldbank.org)',
  'OCDE: Economic Outlook, Economic Surveys del país, estadísticas (data-explorer.oecd.org)',
  'Eurostat y Banco Central Europeo (países de la UE)',
  'Banco de Pagos Internacionales: crédito, tipos de cambio efectivos, precios de la vivienda (data.bis.org)',
  'Banco central e instituto oficial de estadística del propio país',
  'UNCTAD y OMC para comercio por productos y socios',
];

export interface OpcionesDictamen {
  pais?: string;
  tipo?: (typeof TIPOS_PAIS)[number];
  region?: (typeof REGIONES)[number];
  episodio?: string;
  anio?: number;
  duracion?: number;
  preguntas?: number;
  dificultad?: (typeof DIFICULTADES)[number];
  variables?: string[];
  excluir?: string[];
  /** Años como T−7 … T en vez de los reales (por defecto solo en los episodios, donde el año delataría la crisis). */
  aniosRelativos?: boolean;
}

const plano = (t: string): string => t.normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase().trim();

/** Busca un país por ISO3 o por nombre (en español, sin tildes). */
export function buscarPais(banco: BancoPaises, texto: string): PaisBanco | null {
  const t = plano(texto);
  return banco.paises.find((p) => p.iso.toLowerCase() === t || plano(p.nombre) === t) ?? banco.paises.find((p) => plano(p.nombre).startsWith(t) && t.length >= 4) ?? null;
}

function buscarEpisodio(banco: BancoPaises, texto: string): EpisodioBanco | null {
  const t = plano(texto);
  return (
    banco.episodios.find((e) => e.id === t) ??
    banco.episodios.find((e) => plano(e.titulo).includes(t) || t.includes(plano(e.titulo))) ??
    banco.episodios.find((e) => t.split(/\s+/).filter((p) => p.length > 3).some((p) => plano(`${e.titulo} ${e.foco} ${e.id}`).includes(p))) ??
    null
  );
}

const valor = (banco: BancoPaises, p: PaisBanco, variable: string, anio: number): number | null => p.series[variable]?.[anio - banco.desde] ?? null;

/** Años de datos de un país en una variable clave: para no elegir uno sin cifras en la ventana. */
function cobertura(banco: BancoPaises, p: PaisBanco, desde: number, hasta: number): number {
  const claves = ['pib_real', 'inflacion', 'saldo_corriente', 'saldo_pub', 'deuda_pub', 'exportaciones', 'credito_priv', 'paro'];
  let n = 0;
  for (const v of claves) for (let a = desde; a <= hasta; a++) if (valor(banco, p, v, a) !== null) n++;
  return n / (claves.length * (hasta - desde + 1));
}

export interface Desequilibrio {
  indicador: string;
  valor: number;
  anio: string;
  lectura: string;
}

/** Señales que saltan en el último año observado: ayudan a la IA a centrar las preguntas en lo que importa de ese país. */
export function desequilibrios(banco: BancoPaises, p: PaisBanco, t: number, etiquetaAnio: (a: number, t: number) => string = etiquetaRelativa): Desequilibrio[] {
  const s: Desequilibrio[] = [];
  // El último dato hasta T (el Banco Mundial va uno o dos años por detrás del FMI).
  const ultimo = (id: string, a = t): { x: number | null; a: number } => {
    for (let k = a; k >= a - 2; k--) {
      const x = valor(banco, p, id, k);
      if (x !== null) return { x, a: k };
    }
    return { x: null, a };
  };
  const v = (id: string, a = t) => ultimo(id, a).x;
  const anota = (indicador: string, _x: number | null, cond: (x: number) => boolean, lectura: string) => {
    const { x, a } = ultimo(indicador);
    if (x !== null && cond(x)) s.push({ indicador, valor: Math.round(x * 10) / 10, anio: etiquetaAnio(a, t), lectura });
  };
  anota('inflacion', v('inflacion'), (x) => x > 8, 'inflación alta: política monetaria, anclaje de expectativas, tipo de cambio');
  anota('inflacion', v('inflacion'), (x) => x < 0, 'deflación: demanda débil, deuda real');
  anota('saldo_corriente', v('saldo_corriente'), (x) => x < -4, 'déficit exterior elevado: financiación, sostenibilidad, competitividad');
  anota('saldo_corriente', v('saldo_corriente'), (x) => x > 6, 'superávit exterior elevado: ahorro excesivo o renta de materias primas');
  anota('saldo_pub', v('saldo_pub'), (x) => x < -5, 'déficit público elevado: consolidación, dinámica de la deuda');
  anota('deuda_pub', v('deuda_pub'), (x) => x > (p.tipo === 'avanzado' ? 90 : 60), 'deuda pública alta para su grupo: sostenibilidad, r − g, saldo primario');
  anota('paro', v('paro'), (x) => x > 10, 'paro alto: mercado de trabajo, estructural frente a cíclico');
  anota('reservas_meses', null, (x) => x < 3, 'reservas por debajo de 3 meses de importaciones: vulnerabilidad exterior');
  anota('credito_priv', v('credito_priv'), (x) => x > 150, 'endeudamiento privado muy alto');
  const c0 = v('credito_priv', t - 3);
  const c1 = v('credito_priv');
  if (c0 !== null && c1 !== null && c1 - c0 > 15) s.push({ indicador: 'credito_priv', valor: Math.round((c1 - c0) * 10) / 10, anio: `${etiquetaAnio(t - 3, t)} a ${etiquetaAnio(t, t)}`, lectura: 'auge del crédito (puntos de PIB en tres años): riesgo financiero' });
  anota('pib_real', v('pib_real'), (x) => x < 0, 'recesión');
  anota('brecha_producto', v('brecha_producto'), (x) => Math.abs(x) > 2, 'brecha de producción amplia: posición cíclica');
  const tc0 = v('tipo_cambio', t - 1);
  const tc1 = v('tipo_cambio');
  if (tc0 && tc1 && p.regimenCambiario !== 'union_monetaria' && p.regimenCambiario !== 'sin_moneda_propia') {
    const dep = (tc1 / tc0 - 1) * 100;
    if (Math.abs(dep) > 15) s.push({ indicador: 'tipo_cambio', valor: Math.round(dep), anio: etiquetaAnio(t, t), lectura: dep > 0 ? 'depreciación fuerte frente al dólar: traslación a precios, deuda en moneda extranjera' : 'apreciación fuerte frente al dólar: competitividad' });
  }
  if (p.materiasPrimas) {
    const rr = v('rentas_recursos') ?? v('rentas_recursos', t - 1);
    if (rr !== null && rr > 8) s.push({ indicador: 'rentas_recursos', valor: Math.round(rr), anio: etiquetaAnio(t, t), lectura: `dependencia de las materias primas (${p.materiasPrimas}): relación real de intercambio, enfermedad holandesa, regla fiscal` });
  }
  return s;
}

export function etiquetaRelativa(anio: number, t: number): string {
  const d = anio - t;
  return d === 0 ? 'T' : d > 0 ? `T+${d}` : `T−${-d}`;
}

const redondea = (x: number): number => (Math.abs(x) >= 100 ? Math.round(x) : Math.round(x * 10) / 10);

export interface FilaCuadernillo {
  id: string;
  grupo: string;
  nombre: string;
  unidad: string;
  fuente: string;
  valores: Record<string, number | null>;
}

export interface Dictamen {
  configuracion: {
    tipo: string;
    region: string;
    episodio: string | null;
    momento: string;
    duracionMin: number;
    preguntas: number;
    graficos: string;
    dificultad: string;
    porDefecto: string[];
  };
  nombreFicticio: string;
  anios: { etiquetas: string[]; proyeccionDesde: string | null; nota: string };
  rasgos: { tipo: string; materiasPrimas: string | null; regimenCambiario: string; pibPorHabitantePPA: number | null };
  cuadro: FilaCuadernillo[];
  senales: Desequilibrio[];
  variablesFuera?: string[];
  oculto: {
    aviso: string;
    pais: string;
    iso: string;
    region: string;
    moneda: string;
    anioT: number;
    aniosReales?: Record<string, number>;
    episodio?: { titulo: string; foco: string };
    articuloIV: string;
    delatoras: FilaCuadernillo[];
  };
  fuentes: { weo: string; wdi: string; actualizado: string };
}

export type ResultadoDictamen =
  | { ok: true; dictamen: Dictamen }
  | { ok: false; fueraDelBanco: true; motivo: string; fuentesOficiales: string[]; disponibles: { paises: string[]; episodios: string[]; variables: string[] } };

/**
 * Elige el país y monta los datos del cuadernillo. Sin opciones: situación actual (último año observado y dos de
 * proyección del WEO), un país avanzado o emergente fuera de la UE al azar, 1 h 45 min, 6 preguntas y nivel de examen.
 */
export function prepararDictamen(banco: BancoPaises, o: OpcionesDictamen, azar: () => number = Math.random): ResultadoDictamen {
  const porDefecto: string[] = [];
  const primerProy = banco.fuentes.weo.primerAnioProyeccion ?? new Date().getUTCFullYear();
  const disponibles = () => ({
    paises: banco.paises.map((p) => p.nombre),
    episodios: banco.episodios.map((e) => `${e.id} (${e.titulo})`),
    variables: banco.variables.map((v) => v.id),
  });
  const fuera = (motivo: string): ResultadoDictamen => ({ ok: false, fueraDelBanco: true, motivo, fuentesOficiales: FUENTES_OFICIALES, disponibles: disponibles() });

  let episodio: EpisodioBanco | null = null;
  let pais: PaisBanco | null = null;
  if (o.episodio) {
    episodio = buscarEpisodio(banco, o.episodio);
    if (!episodio) return fuera(`El episodio «${o.episodio}» no está en el banco.`);
    pais = banco.paises.find((p) => p.iso === episodio!.iso) ?? null;
  }
  if (o.pais && !pais) {
    pais = buscarPais(banco, o.pais);
    if (!pais) return fuera(`El país «${o.pais}» no está en el banco.`);
  }
  const ultimoObservado = primerProy - 1;
  const t = episodio?.anioT ?? o.anio ?? ultimoObservado;
  if (!episodio && !o.anio) porDefecto.push('momento');
  if (t < banco.desde + 7) return fuera(`El banco empieza en ${banco.desde}: para ${t} faltan los años anteriores del cuadernillo.`);
  if (t > ultimoObservado) return fuera(`${t} aún no tiene datos observados (el último es ${ultimoObservado}; ${primerProy} y siguientes son proyecciones del WEO).`);
  const desde = t - 7;
  const hasta = t === ultimoObservado ? Math.min(t + 2, banco.desde + Math.max(...banco.paises.flatMap((p) => Object.values(p.series).map((s) => s.length))) - 1) : t;

  if (!pais) {
    const excluir = new Set((o.excluir ?? []).map((x) => buscarPais(banco, x)?.iso ?? x.toUpperCase()));
    const candidatos = banco.paises.filter((p) => {
      if (excluir.has(p.iso)) return false;
      if (o.tipo === 'materias_primas') {
        if (!p.materiasPrimas) return false;
      } else if (o.tipo) {
        if (p.tipo !== o.tipo) return false;
      } else if (p.tipo === 'en_desarrollo') return false;
      if (o.region) {
        if (p.region !== o.region) return false;
      } else if (!o.tipo && UE.has(p.iso)) return false;
      return cobertura(banco, p, desde, t) >= 0.6;
    });
    if (!o.tipo) porDefecto.push('tipo');
    if (!o.region) porDefecto.push('region');
    if (!candidatos.length) return fuera(`Ningún país del banco cumple a la vez ${[o.tipo && `tipo «${o.tipo}»`, o.region && `región «${o.region}»`].filter(Boolean).join(' y ')} con datos suficientes para ${t}.`);
    pais = candidatos[Math.floor(azar() * candidatos.length)];
  }

  const duracion = o.duracion ?? 105;
  const preguntas = o.preguntas ?? 6;
  if (!o.duracion) porDefecto.push('duracion');
  if (!o.preguntas) porDefecto.push('preguntas');
  if (!o.dificultad) porDefecto.push('dificultad');

  const relativos = o.aniosRelativos ?? !!episodio;
  const etiquetaAnio = (a: number, tt: number) => (relativos ? etiquetaRelativa(a, tt) : String(a));
  const etiquetas: string[] = [];
  const aniosReales: Record<string, number> = {};
  for (let a = desde; a <= hasta; a++) {
    etiquetas.push(etiquetaAnio(a, t));
    aniosReales[etiquetaAnio(a, t)] = a;
  }
  const fila = (v: VariablePais): FilaCuadernillo | null => {
    const valores: Record<string, number | null> = {};
    let alguno = false;
    for (let a = desde; a <= hasta; a++) {
      // Los datos del Banco Mundial y las proyecciones de otros años no llegan al futuro de un episodio.
      const x = valor(banco, pais!, v.id, a);
      valores[etiquetaAnio(a, t)] = x === null ? null : redondea(x);
      if (x !== null) alguno = true;
    }
    if (!alguno) return null;
    const fuente = v.fuente === 'weo' ? `FMI, WEO${banco.fuentes.weo.edicion ? ` (${banco.fuentes.weo.edicion})` : ''}` : 'Banco Mundial, WDI';
    return { id: v.id, grupo: v.grupo, nombre: v.nombre, unidad: v.unidad, fuente, valores };
  };
  const pedidas = o.variables?.length ? new Set(o.variables) : null;
  const variablesFuera = o.variables?.filter((x) => !banco.variables.some((v) => v.id === x));
  const cuadro: FilaCuadernillo[] = [];
  const delatoras: FilaCuadernillo[] = [];
  for (const v of banco.variables) {
    if (pedidas && !pedidas.has(v.id) && !DELATORAS.has(v.id)) continue;
    const f = fila(v);
    if (!f) continue;
    (DELATORAS.has(v.id) ? delatoras : cuadro).push(f);
  }
  // El tipo de cambio, como variación (sin el nivel, que delata la moneda).
  const tc = delatoras.find((f) => f.id === 'tipo_cambio');
  if (tc && pais.regimenCambiario !== 'union_monetaria' && pais.regimenCambiario !== 'sin_moneda_propia') {
    const valores: Record<string, number | null> = {};
    for (let a = desde; a <= hasta; a++) {
      const x0 = valor(banco, pais, 'tipo_cambio', a - 1);
      const x1 = valor(banco, pais, 'tipo_cambio', a);
      valores[etiquetaAnio(a, t)] = x0 && x1 ? Math.round((x1 / x0 - 1) * 1000) / 10 : null;
    }
    if (Object.values(valores).some((x) => x !== null))
      cuadro.splice(Math.max(0, cuadro.findIndex((f) => f.grupo === 'Balanza de pagos')) || cuadro.length, 0, { id: 'tipo_cambio_var', grupo: 'Competitividad y tipo de cambio', nombre: 'Tipo de cambio frente al dólar, variación (+ = depreciación de la moneda nacional)', unidad: '%', fuente: 'Banco Mundial, WDI', valores });
  }
  const ppa = valor(banco, pais, 'pib_pc_ppa', t);
  const proyDesde = hasta >= primerProy ? etiquetaAnio(primerProy, t) : null;
  const tipoDe = (p: PaisBanco) => ({ avanzado: 'economía avanzada', emergente: 'economía emergente', en_desarrollo: 'economía en desarrollo (renta baja)' })[p.tipo];
  return {
    ok: true,
    dictamen: {
      configuracion: {
        tipo: o.tipo === 'materias_primas' ? `exportador de materias primas (${tipoDe(pais)})` : tipoDe(pais),
        region: o.region ?? (porDefecto.includes('region') ? 'cualquiera fuera de la UE' : pais.region),
        episodio: episodio ? episodio.titulo : null,
        momento: episodio ? 'episodio histórico (años como T−n, el real va oculto)' : t === ultimoObservado ? `situación actual (datos hasta ${t}; ${proyDesde ?? 'sin'} en adelante, previsiones del FMI)` : `año elegido (datos hasta ${relativos ? 'T' : t})`,
        duracionMin: duracion,
        preguntas,
        graficos: preguntas <= 4 ? '4-5 gráficos o tablas' : '6-8 gráficos o tablas',
        dificultad: o.dificultad ?? 'examen',
        porDefecto,
      },
      nombreFicticio: NOMBRES_FICTICIOS[Math.floor(azar() * NOMBRES_FICTICIOS.length)],
      anios: {
        etiquetas,
        proyeccionDesde: proyDesde,
        nota: relativos
          ? 'Los años van como T−7 … T (T es el último año del cuadernillo con datos observados) para no delatar el país ni la época. Los años reales están en el bloque oculto.'
          : 'Años reales, como en el examen («información referida al periodo …, los datos de … son previsiones»): solo se anonimiza el país.',
      },
      rasgos: { tipo: tipoDe(pais), materiasPrimas: pais.materiasPrimas, regimenCambiario: pais.regimenCambiario, pibPorHabitantePPA: ppa === null ? null : Math.round(ppa / 1000) * 1000 },
      cuadro,
      senales: desequilibrios(banco, pais, t, etiquetaAnio),
      ...(variablesFuera?.length ? { variablesFuera } : {}),
      oculto: {
        aviso: 'NO REVELAR HASTA LA GUÍA DE RESOLUCIÓN: ni el país, ni los años reales, ni la moneda, ni nada de este bloque en el cuadernillo o en la conversación antes de que el opositor pida la guía o la corrección.',
        pais: pais.nombre,
        iso: pais.iso,
        region: pais.region,
        moneda: pais.moneda,
        anioT: t,
        ...(relativos ? { aniosReales } : {}),
        ...(episodio ? { episodio: { titulo: episodio.titulo, foco: episodio.foco } } : {}),
        articuloIV: pais.urlFmi,
        delatoras,
      },
      fuentes: { weo: `${banco.fuentes.weo.nombre}${banco.fuentes.weo.edicion ? `, edición ${banco.fuentes.weo.edicion}` : ''}`, wdi: banco.fuentes.wdi.nombre, actualizado: banco.actualizado },
    },
  };
}

// ------------------------------------------------------------------ Prensa

export interface MedioPrensa {
  id: string;
  idioma: string;
  nombre: string;
  pais: string;
  acceso: 'libre' | 'limitado' | 'pago';
  tipo: 'prensa' | 'institucional' | 'analisis';
  general: boolean;
  rss: string;
  ok: boolean;
}
export interface MediosPrensa {
  idiomas: Record<string, string>;
  accesos: Record<string, string>;
  medios: MedioPrensa[];
  economia: Record<string, string[]>;
  tematicas: Record<string, { nombre: string } & Record<string, string[] | string>>;
}
export interface EntradaRss {
  titulo: string;
  url: string;
  fecha: string | null;
  extracto: string;
}

const ENTIDADES: Record<string, string> = { amp: '&', lt: '<', gt: '>', quot: '"', apos: "'", nbsp: ' ' };
function textoPlano(t: string): string {
  return t
    .replace(/<!\[CDATA\[([\s\S]*?)\]\]>/g, '$1')
    .replace(/<[^>]+>/g, ' ')
    .replace(/&(#x?[0-9a-f]+|[a-z]+);/gi, (m, e: string) => {
      if (e[0] === '#') {
        const n = e[1] === 'x' || e[1] === 'X' ? parseInt(e.slice(2), 16) : parseInt(e.slice(1), 10);
        return Number.isFinite(n) ? String.fromCodePoint(n) : m;
      }
      return ENTIDADES[e.toLowerCase()] ?? m;
    })
    .replace(/<[^>]+>/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
}

const campo = (bloque: string, nombres: string[]): string | null => {
  for (const n of nombres) {
    const m = bloque.match(new RegExp(`<${n}(?:\\s[^>]*)?>([\\s\\S]*?)</${n}>`, 'i'));
    if (m && m[1].trim()) return m[1];
  }
  return null;
};

/** Entradas de una fuente RSS 2.0, RDF (RSS 1.0) o Atom. */
export function leerRss(xml: string): EntradaRss[] {
  const bloques = xml.match(/<item[\s>][\s\S]*?<\/item>/gi) ?? xml.match(/<entry[\s>][\s\S]*?<\/entry>/gi) ?? [];
  const salida: EntradaRss[] = [];
  for (const b of bloques) {
    const titulo = textoPlano(campo(b, ['title']) ?? '');
    let url = textoPlano(campo(b, ['link']) ?? '');
    if (!/^https?:\/\//.test(url)) {
      const href = b.match(/<link\b[^>]*?(?:rel=["']alternate["'][^>]*?)?href=["']([^"']+)["']/i)?.[1];
      url = href ? textoPlano(href) : '';
    }
    if (!/^https?:\/\//.test(url)) {
      const guid = textoPlano(campo(b, ['guid']) ?? '');
      if (/^https?:\/\//.test(guid)) url = guid;
    }
    if (!titulo || !url) continue;
    const bruta = campo(b, ['pubDate', 'dc:date', 'published', 'updated', 'date']);
    const ms = bruta ? Date.parse(textoPlano(bruta).replace(/ ([+-]\d{2})(\d{2})$/, ' $1$2')) : NaN;
    const extracto = textoPlano(campo(b, ['description', 'summary', 'content:encoded', 'content']) ?? '');
    salida.push({ titulo, url, fecha: Number.isFinite(ms) ? new Date(ms).toISOString() : null, extracto: extracto.length > 200 ? `${extracto.slice(0, 197).trimEnd()}…` : extracto });
  }
  return salida;
}

/** «francés», «fr», «French», «Français» → «fr». */
export function codigoIdioma(medios: MediosPrensa, texto: string): string | null {
  const t = plano(texto);
  if (medios.idiomas[t]) return t;
  for (const [c, n] of Object.entries(medios.idiomas)) if (plano(n) === t) return c;
  const otros: Record<string, string> = {
    english: 'en', ingles: 'en', french: 'fr', francais: 'fr', german: 'de', deutsch: 'de', italian: 'it', italiano: 'it', portuguese: 'pt', portugues: 'pt',
    russian: 'ru', 'русский': 'ru', chinese: 'zh', mandarin: 'zh', '中文': 'zh', arabic: 'ar', 'العربية': 'ar', japanese: 'ja', '日本語': 'ja',
  };
  return otros[t] ?? null;
}

export interface OpcionesPrensa {
  idioma: string;
  tematica?: string;
  acceso: 'libre' | 'mis_suscripciones' | 'todos';
  dias: number;
  n: number;
  suscripciones: string[];
  ahora: Date;
}

export interface ArticuloPrensa {
  titulo: string;
  url: string;
  fecha: string | null;
  extracto: string;
  medio: string;
  medioId: string;
  pais: string;
  acceso: 'libre' | 'limitado' | 'pago';
  tuSuscripcion?: true;
  tipo: string;
}

const contiene = (texto: string, palabras: string[]): boolean => palabras.some((p) => texto.includes(p.toLowerCase()));

/** Medios del idioma que se leen con esas opciones (los rotos, fuera). */
export function mediosPara(medios: MediosPrensa, o: Pick<OpcionesPrensa, 'idioma' | 'acceso' | 'suscripciones'>): MedioPrensa[] {
  const sus = new Set(o.suscripciones);
  return medios.medios.filter((m) => m.idioma === o.idioma && m.ok && (o.acceso === 'todos' || m.acceso === 'libre' || (o.acceso === 'mis_suscripciones' && sus.has(m.id))));
}

/** Junta las entradas de las fuentes leídas, se queda con lo económico, de la temática y reciente, y reparte entre medios. */
export function articulosDe(medios: MediosPrensa, leidas: Array<{ medio: MedioPrensa; entradas: EntradaRss[] }>, o: OpcionesPrensa): ArticuloPrensa[] {
  const eco = medios.economia[o.idioma] ?? [];
  const tem = o.tematica ? medios.tematicas[o.tematica] : null;
  const claves = tem && Array.isArray(tem[o.idioma]) ? (tem[o.idioma] as string[]) : null;
  const limite = o.ahora.getTime() - o.dias * 86_400_000;
  const sus = new Set(o.suscripciones);
  const vistos = new Set<string>();
  const todos: ArticuloPrensa[] = [];
  for (const { medio, entradas } of leidas) {
    for (const e of entradas) {
      const texto = ` ${e.titulo} ${e.extracto} `.toLowerCase();
      if (medio.general && !contiene(texto, eco)) continue;
      if (claves && !contiene(texto, claves)) continue;
      if (e.fecha && Date.parse(e.fecha) < limite) continue;
      const clave = e.url.split('?')[0];
      if (vistos.has(clave) || vistos.has(e.titulo)) continue;
      vistos.add(clave);
      vistos.add(e.titulo);
      todos.push({
        titulo: e.titulo, url: e.url, fecha: e.fecha, extracto: e.extracto, medio: medio.nombre, medioId: medio.id, pais: medio.pais, acceso: medio.acceso, tipo: medio.tipo,
        ...(sus.has(medio.id) ? { tuSuscripcion: true as const } : {}),
      });
    }
  }
  todos.sort((a, b) => (b.fecha ? Date.parse(b.fecha) : 0) - (a.fecha ? Date.parse(a.fecha) : 0));
  // Variedad: como mucho un tercio (y al menos 2) del mismo medio, salvo que no haya más.
  const tope = Math.max(2, Math.ceil(o.n / 3));
  const porMedio = new Map<string, number>();
  const elegidos: ArticuloPrensa[] = [];
  const resto: ArticuloPrensa[] = [];
  for (const a of todos) {
    const k = porMedio.get(a.medioId) ?? 0;
    if (k < tope) {
      elegidos.push(a);
      porMedio.set(a.medioId, k + 1);
    } else resto.push(a);
    if (elegidos.length >= o.n) break;
  }
  for (const a of resto) if (elegidos.length < o.n) elegidos.push(a);
  return elegidos;
}
