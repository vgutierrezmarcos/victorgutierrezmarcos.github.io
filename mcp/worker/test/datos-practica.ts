// Datos de prueba de los dictámenes de práctica y de la prensa (los usan practica.test.ts y herramientas.test.ts).
import type { BancoPaises, MediosPrensa } from '../src/practica';

const serie = (base: number, paso = 0) => Array.from({ length: 13 }, (_, i) => base + paso * i); // 2015-2027

export const bancoPrueba: BancoPaises = {
  actualizado: '2026-11-20T10:00Z',
  desde: 2015,
  fuentes: { weo: { nombre: 'FMI, World Economic Outlook', edicion: '2026-10', primerAnioProyeccion: 2026, url: 'u' }, wdi: { nombre: 'Banco Mundial, World Development Indicators', url: 'u' } },
  variables: [
    { id: 'pib_real', codigo: 'NGDP_RPCH', fuente: 'weo', grupo: 'Producción', nombre: 'PIB real', unidad: 'variación % anual' },
    { id: 'pib_usd', codigo: 'NGDPD', fuente: 'weo', grupo: 'Producción', nombre: 'PIB nominal', unidad: 'miles de millones de USD' },
    { id: 'inflacion', codigo: 'PCPIPCH', fuente: 'weo', grupo: 'Precios y costes', nombre: 'Inflación', unidad: '%' },
    { id: 'saldo_corriente', codigo: 'BCA_NGDPD', fuente: 'weo', grupo: 'Balanza de pagos', nombre: 'Saldo corriente', unidad: '% del PIB' },
    { id: 'saldo_pub', codigo: 'GGXCNL_NGDP', fuente: 'weo', grupo: 'Sector público: saldos', nombre: 'Saldo público', unidad: '% del PIB' },
    { id: 'deuda_pub', codigo: 'GGXWDG_NGDP', fuente: 'weo', grupo: 'Sector público: deuda', nombre: 'Deuda pública', unidad: '% del PIB' },
    { id: 'tipo_cambio', codigo: 'PA.NUS.FCRF', fuente: 'wdi', grupo: 'Competitividad y tipo de cambio', nombre: 'Tipo de cambio', unidad: 'UML/USD' },
    { id: 'credito_priv', codigo: 'FS.AST.PRVT.GD.ZS', fuente: 'wdi', grupo: 'Sistema financiero', nombre: 'Crédito', unidad: '% del PIB' },
  ],
  paises: [
    {
      iso: 'MAR', nombre: 'Marruecos', tipo: 'emergente', region: 'oriente_medio_norte_africa', materiasPrimas: 'fosfatos', regimenCambiario: 'intermedio', moneda: 'dírham marroquí', urlFmi: 'https://www.imf.org/en/Countries/MAR',
      series: { pib_real: serie(3), pib_usd: serie(110, 10), inflacion: serie(12), saldo_corriente: serie(-6), saldo_pub: serie(-4), deuda_pub: serie(65), tipo_cambio: serie(9, 1), credito_priv: [...serie(60).slice(0, 11), null, null] },
    },
    {
      iso: 'ESP', nombre: 'España', tipo: 'avanzado', region: 'europa', materiasPrimas: null, regimenCambiario: 'union_monetaria', moneda: 'euro', urlFmi: 'https://www.imf.org/en/Countries/ESP',
      series: { pib_real: serie(2), inflacion: serie(2), saldo_corriente: serie(1), saldo_pub: serie(-3), deuda_pub: serie(100), credito_priv: serie(90) },
    },
    {
      iso: 'KEN', nombre: 'Kenia', tipo: 'en_desarrollo', region: 'africa_subsahariana', materiasPrimas: 'agroalimentarias', regimenCambiario: 'flotante', moneda: 'chelín keniano', urlFmi: 'https://www.imf.org/en/Countries/KEN',
      series: { pib_real: serie(5), inflacion: serie(6), saldo_corriente: serie(-5), saldo_pub: serie(-6), deuda_pub: serie(70), credito_priv: serie(30) },
    },
  ],
  episodios: [{ id: 'marruecos-2020', iso: 'MAR', anioT: 2022, titulo: 'Sequía marroquí', foco: 'agricultura' }],
};

export const mediosPrueba: MediosPrensa = {
  idiomas: { en: 'inglés', fr: 'francés' },
  accesos: { libre: 'gratis', limitado: 'algunos', pago: 'suscripción' },
  medios: [
    { id: 'eco', idioma: 'en', nombre: 'The Economist', pais: 'Reino Unido', acceso: 'pago', tipo: 'prensa', general: false, rss: 'https://e/rss', ok: true },
    { id: 'bbc', idioma: 'en', nombre: 'BBC', pais: 'Reino Unido', acceso: 'libre', tipo: 'prensa', general: true, rss: 'https://b/rss', ok: true },
    { id: 'roto', idioma: 'en', nombre: 'Roto', pais: 'X', acceso: 'libre', tipo: 'prensa', general: false, rss: 'https://r/rss', ok: false },
    { id: 'lemonde', idioma: 'fr', nombre: 'Le Monde', pais: 'Francia', acceso: 'limitado', tipo: 'prensa', general: false, rss: 'https://l/rss', ok: true },
  ],
  economia: { en: ['inflation', 'tariff', 'bank'], fr: ['inflation'] },
  tematicas: { comercio: { nombre: 'Comercio', en: ['tariff', 'trade'], fr: ['commerce'] } },
};
