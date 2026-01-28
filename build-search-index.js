/**
 * Script para generar el índice de búsqueda
 * Basado en el programa oficial del BOE - OEP 2025 TCEE
 * Resolución de 22 de diciembre de 2025
 */

const fs = require('fs');
const path = require('path');

// Estructura del índice de búsqueda
const searchIndex = {
  pages: [],
  temas: [],
  recursos: [],
  blog: [],
  lastUpdated: new Date().toISOString()
};

// Páginas principales
searchIndex.pages = [
  {
    id: 'intro',
    title: 'Introducción',
    url: 'index.html',
    description: 'Materiales para la preparación a la Oposición a Técnico Comercial y Economista del Estado',
    keywords: ['introducción', 'inicio', 'bienvenida', 'materiales', 'oposición', 'TCEE'],
    content: 'Temario, organización, enlaces y recursos para la preparación de la oposición a TCEE'
  },
  {
    id: 'temario',
    title: 'Temario',
    url: 'temario/index.html',
    description: 'Temario completo para la preparación a la Oposición',
    keywords: ['temario', 'temas', 'ejercicios', 'contenidos'],
    content: 'Materiales organizados por ejercicios según el programa oficial OEP 2025'
  },
  {
    id: 'organizacion',
    title: 'Organización',
    url: 'organizacion.html',
    description: 'Archivos útiles para la organización del estudio',
    keywords: ['organización', 'planificación', 'estrategia', 'horarios', 'cronogramas'],
    content: 'Estrategia, cronogramas, plantillas y recursos para organizar el estudio'
  },
  {
    id: 'enlaces',
    title: 'Enlaces',
    url: 'enlaces.html',
    description: 'Enlaces útiles para preparar la oposición',
    keywords: ['enlaces', 'recursos', 'webs', 'referencias'],
    content: 'Blogs, think tanks y recursos en español, inglés y francés'
  },
  {
    id: 'sobre-mi',
    title: 'Sobre mí',
    url: 'sobre-mi.html',
    description: 'Víctor Gutiérrez Marcos - TCEE Promoción LXXIII',
    keywords: ['contacto', 'autor', 'víctor', 'gutiérrez', 'marcos'],
    content: 'Técnico Comercial y Economista del Estado, Promoción LXXIII'
  }
];

// ============================================
// TERCER EJERCICIO - Parte A: Economía general
// ============================================
const tercerEjercicioParteA = [
  { num: 1, titulo: 'Objeto y métodos de la ciencia económica. Cuestiones y debates actuales, con especial referencia a la economía conductual.', disponible: true, file: '3A01.pdf' },
  { num: 2, titulo: 'Los economistas clásicos y Marx.', disponible: true, file: '3A02.pdf' },
  { num: 3, titulo: 'Los economistas neoclásicos.', disponible: true, file: '3A03.pdf' },
  { num: 4, titulo: 'El pensamiento económico de Keynes. Referencia a la economía postkeynesiana y el desequilibrio.', disponible: true, file: '3A04.pdf' },
  { num: 5, titulo: 'La síntesis neoclásica. El monetarismo.', disponible: false },
  { num: 6, titulo: 'La nueva macroeconomía clásica. La hipótesis de las expectativas racionales; la crítica de Lucas; el surgimiento de los modelos dinámicos estocásticos de equilibrio general.', disponible: true, file: '3A06.pdf' },
  { num: 7, titulo: 'La nueva economía keynesiana. Primera y segunda generación.', disponible: true, file: '3A07.pdf' },
  { num: 8, titulo: 'Teoría de la demanda del consumidor (I). Axiomas sobre las preferencias, función de utilidad y función de demanda marshalliana. La teoría de la preferencia revelada. Precios hedónicos.', disponible: true, file: '3A08.pdf' },
  { num: 9, titulo: 'Teoría de la demanda del consumidor (II). Dualidad e integrabilidad de las preferencias. Sistemas de demanda utilizados en estudios empíricos. Medidas de cambio en el bienestar.', disponible: true, file: '3A09.pdf' },
  { num: 10, titulo: 'Teoría de la demanda del consumidor (III). Elección del consumidor en situaciones de riesgo e incertidumbre.', disponible: true, file: '3A10.pdf' },
  { num: 11, titulo: 'Teoría de la producción. Caracterización de la tecnología de la empresa a corto y largo plazo. El conjunto de posibilidades de producción. La función de producción. Rendimientos locales y globales a escala. Elasticidad de sustitución. Producción conjunta.', disponible: true, file: '3A11.pdf' },
  { num: 12, titulo: 'Teoría de los costes. Análisis de dualidad en el ámbito de la empresa. Aplicaciones empíricas.', disponible: true, file: '3A12.pdf' },
  { num: 13, titulo: 'Economía de la información y teoría de la agencia: selección adversa y riesgo moral.', disponible: true, file: '3A13.pdf' },
  { num: 14, titulo: 'Teoría de juegos. Principales conceptos. Aplicaciones, con especial referencia a las subastas.', disponible: false },
  { num: 15, titulo: 'La empresa: el tamaño eficiente y sus límites. Mención especial de la economía de los costes de transacción. La Teoría de la Organización Industrial: barreras a la entrada y mercados impugnables.', disponible: false },
  { num: 16, titulo: 'Análisis de mercados (I). El modelo de competencia perfecta. Análisis de equilibrio parcial: corto y largo plazo; dinámicas de ajuste y estabilidad del equilibrio. Análisis de eficiencia y bienestar.', disponible: true, file: '3A16.pdf' },
  { num: 17, titulo: 'Análisis de mercados (II). Teoría del monopolio. Discriminación de precios. Monopolio natural. Producción conjunta. Análisis de eficiencia y bienestar. Monopsonio. Monopolio bilateral.', disponible: true, file: '3A17.pdf' },
  { num: 18, titulo: 'Análisis de mercados (III). Diferenciación de productos: la teoría de la competencia monopolística y otros desarrollos.', disponible: true, file: '3A18.pdf' },
  { num: 19, titulo: 'Análisis de mercados (IV). Teoría del oligopolio: soluciones no cooperativas y soluciones cooperativas.', disponible: true, file: '3A19.pdf' },
  { num: 20, titulo: 'Poder de mercado y regulación óptima. Definición del mercado relevante. Desarrollos en presencia de información asimétrica. Aplicaciones prácticas.', disponible: false },
  { num: 21, titulo: 'La teoría del equilibrio general.', disponible: true, file: '3A21.pdf' },
  { num: 22, titulo: 'Economía del bienestar (I). Los teoremas fundamentales del bienestar. Óptimo económico y «second-best».', disponible: true, file: '3A22.pdf' },
  { num: 23, titulo: 'Economía del bienestar (II). Fallos de mercado: externalidades y bienes públicos. Intervención y fallos del sector público.', disponible: true, file: '3A23.pdf' },
  { num: 24, titulo: 'Economía del bienestar (III). Las funciones de bienestar social. Teoría de la elección colectiva. El teorema de imposibilidad de Arrow y desarrollos posteriores.', disponible: true, file: '3A24.pdf' },
  { num: 25, titulo: 'La teoría neoclásica del mercado de trabajo. Análisis intertemporal de la oferta de trabajo. Teoría del capital humano. Función de ingresos de capital humano y evidencia empírica.', disponible: true, file: '3A25.pdf' },
  { num: 26, titulo: 'Desempleo friccional. La curva de Beveridge, el modelo de búsqueda y emparejamiento de Diamond, Mortensen y Pissarides. Costes de ajuste y dinámica de la demanda de trabajo.', disponible: true, file: '3A26.pdf' },
  { num: 27, titulo: 'Determinación de salarios: modelos de negociación, salarios de eficiencia y contratos implícitos.', disponible: true, file: '3A27.pdf' },
  { num: 28, titulo: 'La tasa natural de paro y la NAIRU. La persistencia del desempleo.', disponible: true, file: '3A28.pdf' },
  { num: 29, titulo: 'Modelización dinámica de las tomas de decisiones. Modelos de horizonte infinito y modelos de generaciones solapadas.', disponible: true, file: '3A29.pdf' },
  { num: 30, titulo: 'Magnitudes macroeconómicas y contabilidad nacional.', disponible: true, file: '3A30.pdf' },
  { num: 31, titulo: 'Análisis de las tablas «input-output».', disponible: false },
  { num: 32, titulo: 'El modelo de oferta y demanda agregada: determinación de renta e inflación en una economía abierta. Análisis de las políticas monetaria y fiscal, y de los shocks y políticas de oferta.', disponible: false },
  { num: 33, titulo: 'Teorías de la demanda de consumo corriente: ciclo vital y renta permanente. La demanda de bienes de consumo duradero. Evidencia empírica e implicaciones de política económica.', disponible: true, file: '3A33.pdf' },
  { num: 34, titulo: 'Teorías de la inversión en bienes de equipo. Incertidumbre e irreversibilidad de la inversión. Implicaciones de política económica.', disponible: true, file: '3A34.pdf' },
  { num: 35, titulo: 'Teorías de la demanda de dinero. Implicaciones de política económica.', disponible: true, file: '3A35.pdf' },
  { num: 36, titulo: 'Política monetaria (I). El diseño y la instrumentación de la política monetaria.', disponible: true, file: '3A36.pdf' },
  { num: 37, titulo: 'Política monetaria (II). Los mecanismos de transmisión de la política monetaria convencional. Rigideces de precios, rigideces de salarios y fricciones financieras. Los mecanismos de transmisión de la política monetaria no convencional.', disponible: true, file: '3A37.pdf' },
  { num: 38, titulo: 'La política fiscal: efectos sobre el crecimiento económico y el ahorro.', disponible: true, file: '3A38.pdf' },
  { num: 39, titulo: 'Déficit público. Conceptos. Financiación y sus consecuencias macroeconómicas. Dominación monetaria y dominación fiscal. La dinámica de la deuda pública y su sostenibilidad.', disponible: true, file: '3A39.pdf' },
  { num: 40, titulo: 'Efectividad e interrelación de las políticas monetaria y fiscal en las principales economías desarrolladas desde la Gran Recesión de 2008. El valor de los multiplicadores fiscales.', disponible: false },
  { num: 41, titulo: 'La inflación: causas y efectos sobre la eficiencia económica y el bienestar. Hiperinflación y deflación.', disponible: true, file: '3A41.pdf' },
  { num: 42, titulo: 'Teorías de los ciclos económicos: ciclos nominales y reales. Referencia al ciclo financiero y sus interrelaciones con el ciclo real.', disponible: true, file: '3A42.pdf' },
  { num: 43, titulo: 'Crecimiento económico (I). Acumulación de capital y progreso técnico exógeno. El modelo de Solow. El modelo de Solow aumentado con acumulación de capital humano. El modelo de Ramsey-Cass-Koopmans.', disponible: true, file: '3A43.pdf' },
  { num: 44, titulo: 'Crecimiento económico (II). Modelos de crecimiento endógeno: rendimientos crecientes, capital humano e innovación tecnológica.', disponible: true, file: '3A44.pdf' },
  { num: 45, titulo: 'Evidencia empírica sobre el crecimiento económico y la distribución de la renta entre los factores de producción. Contabilidad del crecimiento, con especial referencia a la productividad total de los factores. Convergencia económica internacional.', disponible: true, file: '3A45.pdf' }
];

// ============================================
// TERCER EJERCICIO - Parte B: Economía Financiera, Economía Internacional y Relaciones Económicas Internacionales
// ============================================
const tercerEjercicioParteB = [
  { num: 1, titulo: 'La información financiera de las empresas: estados de situación y de circulación. Métodos de análisis económico y financiero de la empresa.', disponible: true, file: '3B01.pdf' },
  { num: 2, titulo: 'La empresa y las decisiones de inversión. Diferentes criterios de valoración de proyectos. Rentabilidad, riesgo y coste del capital.', disponible: true, file: '3B02.pdf' },
  { num: 3, titulo: 'La empresa y las decisiones de financiación: financiación propia frente a financiación ajena. Política de dividendos y estructura del capital.', disponible: true, file: '3B03.pdf' },
  { num: 4, titulo: 'Análisis del crecimiento de la empresa. Métodos de valoración de empresas. Especial referencia a los procesos de fusión, adquisición y alianzas estratégicas.', disponible: true, file: '3B04.pdf' },
  { num: 5, titulo: 'Teoría del comercio internacional (I). La teoría ricardiana de la ventaja comparativa. Determinación de la relación real de intercambio. El modelo de factores específicos. El Modelo Hecksher-Ohlin-Samuelson (H-O-S); teoremas derivados del modelo y extensiones.', disponible: true, file: '3B05.pdf' },
  { num: 6, titulo: 'Teoría del comercio internacional (II). Nueva teoría del comercio internacional. Especial referencia a la competencia imperfecta, los rendimientos crecientes y la heterogeneidad empresarial.', disponible: true, file: '3B06.pdf' },
  { num: 7, titulo: 'La política comercial (I). Instrumentos y efectos. Barreras arancelarias y no arancelarias. Otros instrumentos tradicionales.', disponible: true, file: '3B07.pdf' },
  { num: 8, titulo: 'La política comercial (II). La política comercial estratégica.', disponible: true, file: '3B08.pdf' },
  { num: 9, titulo: 'Comercio internacional y crecimiento económico. Especial referencia a los efectos del comercio sobre el crecimiento.', disponible: true, file: '3B09.pdf' },
  { num: 10, titulo: 'Teoría de la integración económica.', disponible: true, file: '3B10.pdf' },
  { num: 11, titulo: 'Balanza de pagos: concepto, medición e interpretación.', disponible: true, file: '3B11.pdf' },
  { num: 12, titulo: 'Mecanismos de ajuste de la balanza de pagos. Especial referencia al enfoque intertemporal de balanza de pagos. Análisis de sostenibilidad del déficit y de la deuda exterior.', disponible: true, file: '3B12.pdf' },
  { num: 13, titulo: 'Mercados de divisas: operaciones e instrumentos.', disponible: true, file: '3B13.pdf' },
  { num: 14, titulo: 'Teorías de la determinación del tipo de cambio.', disponible: true, file: '3B14.pdf' },
  { num: 15, titulo: 'Análisis comparado de los distintos regímenes cambiarios. Intervención y regulación de los mercados de cambio.', disponible: true, file: '3B15.pdf' },
  { num: 16, titulo: 'Teoría de la integración monetaria.', disponible: true, file: '3B16.pdf' },
  { num: 17, titulo: 'Teorías explicativas de las crisis de balanza de pagos.', disponible: true, file: '3B17.pdf' },
  { num: 18, titulo: 'La nueva globalización económica y financiera. Determinantes y efectos de los movimientos internacionales de factores productivos: movilidad de trabajadores, inversión de cartera e inversión directa, con especial referencia a las cadenas globales de valor.', disponible: false },
  { num: 19, titulo: 'La coordinación internacional de políticas económicas. Aspectos teóricos y prácticos. El G-20, la OCDE y otros foros internacionales.', disponible: true, file: '3B19.pdf' },
  { num: 20, titulo: 'El sistema económico internacional desde el siglo XIX hasta la ruptura del sistema de Bretton-Woods.', disponible: true, file: '3B20.pdf' },
  { num: 21, titulo: 'El sistema económico internacional desde la desaparición del sistema de Bretton-Woods.', disponible: true, file: '3B21.pdf' },
  { num: 22, titulo: 'El Fondo Monetario Internacional. Estructura y políticas. La prevención y solución de crisis.', disponible: true, file: '3B22.pdf' },
  { num: 23, titulo: 'Análisis de los instrumentos financieros de renta variable. Análisis fundamental. Teoría de la elección de cartera. El modelo de valoración de los activos de capital (CAPM). La teoría de valoración de activos por arbitraje (APT). Análisis técnico.', disponible: true, file: '3B23.pdf' },
  { num: 24, titulo: 'Análisis de los instrumentos de renta fija. Determinación del precio y rendimiento de los bonos. La estructura temporal de los tipos de interés. Valoración del riesgo y del rendimiento de los bonos: duración y convexidad.', disponible: true, file: '3B24.pdf' },
  { num: 25, titulo: 'Análisis de los instrumentos y de los mercados de derivados.', disponible: true, file: '3B25.pdf' },
  { num: 26, titulo: 'Crisis financieras y pánicos bancarios; especial referencia a la crisis financiera internacional iniciada en 2007-2008. Gestión de riesgos de las instituciones financieras.', disponible: false },
  { num: 27, titulo: 'Regulación financiera bancaria y no-bancaria. Fundamentos teóricos y evidencia empírica.', disponible: true, file: '3B27.pdf' },
  { num: 28, titulo: 'Economía de los países en desarrollo. Teorías recientes del desarrollo económico. Evidencia empírica, con especial referencia a la aproximación experimental, e implicaciones para el diseño de políticas.', disponible: true, file: '3B28.pdf' },
  { num: 29, titulo: 'La financiación exterior del desarrollo económico. El problema de la deuda externa. La ayuda al desarrollo.', disponible: false },
  { num: 30, titulo: 'El Grupo del Banco Mundial, los Bancos Regionales de Desarrollo y otras instituciones financieras multilaterales de desarrollo.', disponible: false },
  { num: 31, titulo: 'El cambio climático y su impacto en la economía. Evidencia y modelos integrados de evaluación. Acuerdos internacionales y principales medidas adoptadas para hacer frente al cambio climático.', disponible: false },
  { num: 32, titulo: 'Perspectivas económicas mundiales. Estructura sectorial y geográfica de los flujos comerciales y financieros internacionales. Las nuevas áreas emergentes.', disponible: false },
  { num: 33, titulo: 'La OMC. Antecedentes y Organización actual. El GATT y los Acuerdos sobre el comercio de mercancías. Situación actual.', disponible: true, file: '3B33.pdf' },
  { num: 34, titulo: 'La OMC. Los acuerdos distintos de los de mercancías.', disponible: true, file: '3B34.pdf' },
  { num: 35, titulo: 'Procesos de integración no comunitarios.', disponible: true, file: '3B35.pdf' },
  { num: 36, titulo: 'Tratados, orden jurídico e instituciones de la Unión Europea.', disponible: true, file: '3B36.pdf' },
  { num: 37, titulo: 'Las finanzas de la Unión Europea y el presupuesto comunitario. El marco financiero plurianual actual.', disponible: true, file: '3B37.pdf' },
  { num: 38, titulo: 'La política agrícola de la Unión Europea. Problemas económicos y procesos de reforma. La política pesquera común.', disponible: false },
  { num: 39, titulo: 'El mercado único de la Unión Europea. El principio de libre circulación de mercancías, servicios, personas y capitales. La política de competencia.', disponible: true, file: '3B39.pdf' },
  { num: 40, titulo: 'La Cohesión Económica y Social en la Unión Europea: política regional e instrumentos presupuestarios y financieros. Política social y de empleo. El proceso de convergencia real en la Unión Europea.', disponible: true, file: '3B40.pdf' },
  { num: 41, titulo: 'La política comercial de la Unión Europea.', disponible: true, file: '3B41.pdf' },
  { num: 42, titulo: 'Las relaciones económicas exteriores de la Unión Europea. La política de cooperación al desarrollo de la Unión Europea.', disponible: true, file: '3B42.pdf' },
  { num: 43, titulo: 'El origen del euro: funcionamiento y evolución del Sistema Monetario Europeo. Los criterios de convergencia nominal. El Sistema Europeo de Bancos Centrales: objetivos e instrumentos. La política monetaria en la Eurozona desde 2009.', disponible: false },
  { num: 44, titulo: 'La Unión Bancaria: Pilares y Código normativo único. La Unión de Mercados de Capitales.', disponible: false },
  { num: 45, titulo: 'La gobernanza económica de la Unión Europea y de la zona euro. El Semestre Europeo. Las reglas fiscales y el Procedimiento de Desequilibrios Macroeconómicos. El Mecanismo Europeo de Estabilidad. La respuesta común de política fiscal a partir de la covid-19.', disponible: false }
];

// ============================================
// CUARTO EJERCICIO - Parte A: Economía española
// ============================================
const cuartoEjercicioParteA = [
  { num: 1, titulo: 'Fuentes estadísticas españolas. Metodologías y limitaciones.', disponible: true, file: '4A01.pdf' },
  { num: 2, titulo: 'Los recursos humanos en España: estructura demográfica y capital humano. Proyecciones de población a medio y largo plazo: implicaciones para el crecimiento económico.', disponible: false },
  { num: 3, titulo: 'La distribución personal y entre factores productivos de la renta en España. La desigualdad de la renta, la riqueza y el consumo. El efecto redistributivo del sector público español.', disponible: false },
  { num: 4, titulo: 'Los sectores agrario y pesquero en España.', disponible: false },
  { num: 5, titulo: 'Estructura del sector energético y sus subsectores: sistema eléctrico, sistema gasista y productos petrolíferos. Nuevas tecnologías y retos del sector.', disponible: false },
  { num: 6, titulo: 'La política española de energía y clima: mitigación y adaptación al cambio climático. Vinculación con la política de energía y clima de la UE. Políticas sectoriales de medioambiente.', disponible: false },
  { num: 7, titulo: 'El sistema y la política de ciencia y tecnología en España. Vinculación con la política de I+D de la Unión Europea. La actividad de investigación, desarrollo e innovación (I+D+i) en los sectores público y privado. Comparación con buenas prácticas internacionales.', disponible: false },
  { num: 8, titulo: 'La empresa en España. Características principales: productividad, internacionalización, tamaño y financiación. Comparación entre la empresa industrial y la empresa de servicios. El clima de negocio en España. El sector público empresarial.', disponible: false },
  { num: 9, titulo: 'Análisis de la industria en España. Características y situación actual. Los retos de la industria y la política industrial en España en el contexto de las economías desarrolladas. La estrategia de la UE.', disponible: false },
  { num: 10, titulo: 'Estructura sectorial de la industria en España. Clasificación de sectores según nivel de contenido tecnológico y de demanda. Análisis de los principales sectores: industria agroalimentaria, industria automovilística, industria química y farmacéutica, e industria de fabricación de bienes de equipo y de alta tecnología.', disponible: false },
  { num: 11, titulo: 'El sector de la construcción en España. El mercado de la vivienda. Problemas y política de vivienda y suelo.', disponible: true, file: '4A11.pdf' },
  { num: 12, titulo: 'Estructura y política de los sectores de los transportes y las telecomunicaciones en España.', disponible: true, file: '4A12.pdf' },
  { num: 13, titulo: 'El turismo en España: evolución, retos y política turística.', disponible: true, file: '4A13.pdf' },
  { num: 14, titulo: 'Estructura, políticas y retos de la distribución comercial, con especial referencia al comercio electrónico.', disponible: true, file: '4A14.pdf' },
  { num: 15, titulo: 'La defensa y la promoción de la competencia en España. Principios de regulación económica eficiente. Garantía de unidad de mercado.', disponible: true, file: '4A15.pdf' },
  { num: 16, titulo: 'Mercado de trabajo en España. Características, funcionamiento y problemas. Las políticas de empleo.', disponible: true, file: '4A16.pdf' },
  { num: 17, titulo: 'Economía de las regiones españolas: especialización regional, convergencia real y política de desarrollo regional.', disponible: true, file: '4A17.pdf' },
  { num: 18, titulo: 'Sistema financiero español (I). Evolución reciente del sistema financiero. Génesis y desarrollo de la crisis del sistema financiero español iniciada en 2008. La reestructuración de las entidades de crédito. El Programa de Asistencia Financiera.', disponible: true, file: '4A18.pdf' },
  { num: 19, titulo: 'Sistema financiero español (II). Las entidades de crédito en España: Configuración actual del sector bancario español y principales indicadores. El marco de regulación, supervisión y gestión de crisis.', disponible: true, file: '4A19.pdf' },
  { num: 20, titulo: 'Sistema financiero español (III). Mercados de valores y otras formas de financiación no bancaria, agentes e instrumentos. Innovación financiera.', disponible: true, file: '4A20.pdf' },
  { num: 21, titulo: 'Análisis de la evolución de la balanza de pagos y de la Posición de Inversión Internacional de España desde la adopción del euro. Posición neta del Banco de España frente al Eurosistema. La sostenibilidad externa.', disponible: true, file: '4A21.pdf' },
  { num: 22, titulo: 'La internacionalización de la economía española (I). Estructura sectorial y geográfica de la balanza de bienes y de servicios en España en la actualidad. Indicadores de competitividad. La integración de España en las cadenas globales de valor.', disponible: true, file: '4A22.pdf' },
  { num: 23, titulo: 'La internacionalización de la economía española (II). Estructura sectorial y geográfica de la inversión extranjera en España y de la inversión española en el exterior en la actualidad.', disponible: true, file: '4A23.pdf' },
  { num: 24, titulo: 'La política española de internacionalización (I). Instrumentos financieros de ayuda a la exportación y a la inversión exterior. Evaluación y comparación con buenas prácticas internacionales.', disponible: true, file: '4A24.pdf' },
  { num: 25, titulo: 'La política española de internacionalización (II). La promoción comercial. Organismos e instrumentos. Evaluación y comparación con buenas prácticas internacionales.', disponible: true, file: '4A25.pdf' },
  { num: 26, titulo: 'La política de cooperación al desarrollo en España. Instrumentos de cooperación técnica y financiera. Evaluación del diseño de la política y análisis de impacto económico.', disponible: true, file: '4A26.pdf' },
  { num: 27, titulo: 'La economía española en el período 1959-1999. El Plan de Estabilización de 1959. La economía española en la década de 1960. Las crisis energéticas de los años 70. La adhesión a las Comunidades Europeas. El proceso de ajuste macroeconómico para la entrada en la zona euro.', disponible: true, file: '4A27.pdf' },
  { num: 28, titulo: 'Evolución de la economía y de la política económica en España desde la constitución de la zona euro hasta 2019. Especial referencia a la crisis económica y financiera iniciada en 2008.', disponible: true, file: '4A28.pdf' },
  { num: 29, titulo: 'Evolución de la economía y de la política económica española desde la crisis de la Covid-19. Situación actual de la economía española y perspectivas. Los desequilibrios macroeconómicos de España, según el Procedimiento de Desequilibrios Macroeconómicos de la UE.', disponible: false },
  { num: 30, titulo: 'Las relaciones financieras de España con la Unión Europea: flujos presupuestarios y extra-presupuestarios, y saldo financiero España-Unión Europea. Evolución reciente y situación actual. España en el Marco Financiero Plurianual 2021-2027. La convergencia real de España con la Unión Europea.', disponible: false }
];

// ============================================
// CUARTO EJERCICIO - Parte B: Economía del sector público
// ============================================
const cuartoEjercicioParteB = [
  { num: 1, titulo: 'El sector público: delimitación, operaciones y cuentas principales según el Sistema Europeo de Cuentas.', disponible: true, file: '4B01.pdf' },
  { num: 2, titulo: 'Los mecanismos de decisión del sector público. Reglas de votación. La democracia representativa. La producción pública y la burocracia. Justificación de la existencia de límites normativos a la actividad del sector público.', disponible: true, file: '4B02.pdf' },
  { num: 3, titulo: 'El presupuesto como elemento de redistribución. El Estado de Bienestar: instrumentos, problemas y reformas. Medición e indicadores del impacto redistributivo.', disponible: true, file: '4B03.pdf' },
  { num: 4, titulo: 'El presupuesto como elemento compensador de la actividad económica. Componentes discrecionales y automáticos del presupuesto: saldo cíclico, saldo estructural y esfuerzo fiscal.', disponible: true, file: '4B04.pdf' },
  { num: 5, titulo: 'El gasto público. Razones de su crecimiento. El debate sobre el tamaño del sector público, en lo referente al gasto. Comparaciones internacionales.', disponible: true, file: '4B05.pdf' },
  { num: 6, titulo: 'Evaluación de las políticas públicas. Técnicas de evaluación de impacto. Análisis coste-beneficio, análisis coste-eficacia y otras técnicas de evaluación.', disponible: true, file: '4B06.pdf' },
  { num: 7, titulo: 'Ingresos públicos. Elementos definidores y clases de impuestos. Principios impositivos.', disponible: true, file: '4B07.pdf' },
  { num: 8, titulo: 'Traslación e incidencia de los impuestos en mercados competitivos y monopolistas. Enfoques de equilibrio parcial y general.', disponible: true, file: '4B08.pdf' },
  { num: 9, titulo: 'Efecto renta y efecto sustitución de los impuestos. Concepto y medición del exceso de gravamen. Medidas de progresividad impositiva.', disponible: true, file: '4B09.pdf' },
  { num: 10, titulo: 'Imposición y oferta. Efectos incentivo de los impuestos.', disponible: true, file: '4B10.pdf' },
  { num: 11, titulo: 'La imposición óptima. Tipo impositivo óptimo. Regla de Ramsey. El compromiso entre eficiencia y equidad de la política tributaria.', disponible: true, file: '4B11.pdf' },
  { num: 12, titulo: 'La imposición directa: teoría y comparaciones internacionales.', disponible: true, file: '4B12.pdf' },
  { num: 13, titulo: 'La imposición indirecta: teoría y comparaciones internacionales.', disponible: true, file: '4B13.pdf' },
  { num: 14, titulo: 'La teoría del federalismo fiscal: la asignación óptima de las funciones entre los distintos niveles de gobierno para alcanzar el bienestar máximo. La financiación de las haciendas territoriales: impuestos, transferencias y deuda.', disponible: true, file: '4B14.pdf' },
  { num: 15, titulo: 'La empresa pública. Razones de su existencia. La política de privatizaciones. Comparaciones internacionales.', disponible: true, file: '4B15.pdf' },
  { num: 16, titulo: 'El impuesto sobre la renta de las personas físicas en España.', disponible: true, file: '4B16.pdf' },
  { num: 17, titulo: 'El impuesto sobre sociedades en España.', disponible: true, file: '4B17.pdf' },
  { num: 18, titulo: 'Fiscalidad internacional. El Impuesto sobre la Renta de no Residentes en España. Convenios de doble imposición, con especial referencia al modelo de la OCDE. El problema de la erosión de bases imponibles y propuestas de solución.', disponible: true, file: '4B18.pdf' },
  { num: 19, titulo: 'La imposición patrimonial en España: el impuesto sobre el patrimonio, el impuesto sobre sucesiones y donaciones, el impuesto sobre transmisiones patrimoniales y actos jurídicos documentados, y el impuesto sobre bienes inmuebles.', disponible: true, file: '4B19.pdf' },
  { num: 20, titulo: 'La imposición indirecta en España: el IVA y los impuestos especiales.', disponible: true, file: '4B20.pdf' },
  { num: 21, titulo: 'Marco legal e institucional de los presupuestos en España. Principios presupuestarios, con especial referencia a la estabilidad y la sostenibilidad. Los Presupuestos Generales del Estado: elaboración, aprobación, ejecución y control. Clasificaciones de ingresos y gastos. Modificaciones presupuestarias.', disponible: true, file: '4B21.pdf' },
  { num: 22, titulo: 'Las grandes cifras de los Presupuestos Generales del Estado (PGE). Clasificación económica, orgánica y por políticas de gasto. Visión consolidada de los PGE.', disponible: true, file: '4B22.pdf' },
  { num: 23, titulo: 'Las finanzas de las Administraciones Públicas en España en términos de contabilidad nacional. Situación actual y perspectivas según el Programa de Estabilidad. Estructura de ingresos y presión fiscal. Gasto por funciones según la clasificación COFOG. Distribución de gastos e ingresos públicos por subsectores de las Administraciones Públicas.', disponible: true, file: '4B23.pdf' },
  { num: 24, titulo: 'El Sistema de la Seguridad Social en España. Prestaciones y su financiación. La sostenibilidad del sistema público de pensiones.', disponible: false },
  { num: 25, titulo: 'Las Administraciones Territoriales en España. Competencias y sistemas de financiación. El endeudamiento de las Administraciones Territoriales.', disponible: false },
  { num: 26, titulo: 'El saldo presupuestario y la deuda de las Administraciones Públicas en España: análisis de su evolución reciente y comparación internacional. Política de financiación del Tesoro en la actualidad.', disponible: true, file: '4B26.pdf' }
];

// ============================================
// QUINTO EJERCICIO - Parte A: Marketing internacional y técnicas comerciales
// ============================================
const quintoEjercicioParteA = [
  { num: 1, titulo: 'Los regímenes de comercio exterior.', disponible: true, file: 'parte_A.pdf' },
  { num: 2, titulo: 'Los instrumentos de defensa comercial.', disponible: true, file: 'parte_A.pdf' },
  { num: 3, titulo: 'Los instrumentos de atracción de inversiones exteriores.', disponible: true, file: 'parte_A.pdf' },
  { num: 4, titulo: 'Los instrumentos de promoción del turismo en España.', disponible: true, file: 'parte_A.pdf' },
  { num: 5, titulo: 'La regulación de las inversiones extranjeras en España y de las españolas en el exterior.', disponible: true, file: 'parte_A.pdf' },
  { num: 6, titulo: 'Formas de penetración e implantación en los mercados. El estudio de los mercados exteriores la prospección.', disponible: true, file: 'parte_A.pdf' },
  { num: 7, titulo: 'Los canales de distribución y las redes de venta.', disponible: true, file: 'parte_A.pdf' },
  { num: 8, titulo: 'La oferta internacional: el producto y el precio. La comunicación en el comercio internacional.', disponible: true, file: 'parte_A.pdf' },
  { num: 9, titulo: 'El cuadro jurídico de las operaciones de comercio exterior: el contrato de venta internacional y la resolución de litigios.', disponible: true, file: 'parte_A.pdf' },
  { num: 10, titulo: 'Las políticas logísticas y financieras de la empresa exportadora. Los medios de pago en el comercio internacional.', disponible: true, file: 'parte_A.pdf' }
];

// ============================================
// QUINTO EJERCICIO - Parte B: Econometría
// ============================================
const quintoEjercicioParteB = [
  { num: 1, titulo: 'Supuestos clásicos del modelo de regresión lineal. Aproximación lineal al modelo no lineal. Método de mínimos cuadrados ordinarios y método de máxima verosimilitud. Medidas de bondad de ajuste del modelo.', disponible: true, file: 'parte_B.pdf' },
  { num: 2, titulo: 'Propiedades de los estimadores de mínimos cuadrados ordinarios para muestras finitas y muestras grandes en el modelo de regresión lineal. Contraste de hipótesis e intervalos de confianza.', disponible: true, file: 'parte_B.pdf' },
  { num: 3, titulo: 'Heterocedasticidad y autocorrelación: origen, consecuencias, detección y soluciones. Estimación por mínimos cuadrados generalizados.', disponible: true, file: 'parte_B.pdf' },
  { num: 4, titulo: 'La causalidad en los modelos de regresión. Problema de la variable omitida y estimación por variables instrumentales. Otras soluciones: diseños experimentales, regresión en discontinuidad y diferencias en diferencias.', disponible: true, file: 'parte_B.pdf' },
  { num: 5, titulo: 'Procesos estocásticos. Ruido blanco, AR, MA, ARMA y ARIMA: identificación, estimación, verificación y predicción.', disponible: true, file: 'parte_B.pdf' },
  { num: 6, titulo: 'Datos de panel. Descripción del problema. El modelo de efectos fijos y de efectos aleatorios. Estimación.', disponible: true, file: 'parte_B.pdf' }
];

// ============================================
// QUINTO EJERCICIO - Parte C: Derecho Administrativo y Organización del Estado
// ============================================
const quintoEjercicioParteC = [
  { num: 1, titulo: 'Las fuentes del derecho administrativo. La Constitución. La ley. Los decretos-leyes. La delegación legislativa.', disponible: false },
  { num: 2, titulo: 'El reglamento. La potestad reglamentaria. Los reglamentos ilegales. Actos administrativos generales, circulares e instrucciones.', disponible: false },
  { num: 3, titulo: 'El acto administrativo: concepto, clases y elementos. Su motivación y notificación. Eficacia y validez de los actos administrativos. Revisión, anulación y revocación.', disponible: false },
  { num: 4, titulo: 'Los recursos administrativos.', disponible: false },
  { num: 5, titulo: 'La jurisdicción contencioso-administrativa. Extensión y límites. Las partes del procedimiento. La sentencia. Recursos.', disponible: false },
  { num: 6, titulo: 'Los contratos del sector público: concepto y clases. Estudio de sus elementos. Su cumplimiento. La revisión de precios y otras alteraciones contractuales. Incumplimiento de los contratos.', disponible: false },
  { num: 7, titulo: 'El servicio público: concepto y clases. Forma de gestión de los servicios públicos. Examen especial de la gestión directa. La gestión indirecta: modalidades. La concesión. Régimen jurídico.', disponible: false },
  { num: 8, titulo: 'Procedimiento administrativo común de las administraciones públicas: objeto y ámbito de aplicación. El procedimiento administrativo: concepto y naturaleza. Las garantías del procedimiento. Iniciación, ordenación, instrucción y terminación del procedimiento administrativo común. Los procedimientos especiales.', disponible: false },
  { num: 9, titulo: 'Régimen jurídico del personal al servicio de las administraciones públicas. Ley del Estatuto Básico del Empleado Público. La Ley de Medidas para la Reforma de la Función Pública. Órganos superiores de la Función Pública. Oferta de empleo público.', disponible: false },
  { num: 10, titulo: 'La Constitución española de 1978: estructura y contenido. Derechos y deberes fundamentales. Su garantía y suspensión. El Defensor del Pueblo. El Tribunal de Cuentas. El Tribunal Constitucional. Reforma de la Constitución.', disponible: false },
  { num: 11, titulo: 'El Gobierno, su Presidente y el Consejo de Ministros. La Ley de Régimen Jurídico del Sector Público. Objeto y ámbito de aplicación. Principios generales. Organización y funcionamiento de la Administración General del Estado. Organización Central. Órganos Superiores y Directivos. Los Ministerios y su estructura interna. La Organización territorial de la Administración General del Estado. Las Delegaciones y Subdelegaciones del Gobierno.', disponible: false },
  { num: 12, titulo: 'Organización y competencias del Ministerio de Economía, Comercio y Empresa. Especial mención a la Secretaría de Estado de Economía y Apoyo a la Empresa, y a la Secretaría de Estado de Comercio. Otros Ministerios económicos. La Administración Territorial del Ministerio de Economía, Comercio y Empresa. Su administración institucional. ICEX España Exportación e Inversiones.', disponible: false },
  { num: 13, titulo: 'Organización territorial del Estado. Las Comunidades Autónomas: constitución, competencias, Estatutos de autonomía. El sistema institucional de las Comunidades Autónomas. La Administración Local.', disponible: false },
  { num: 14, titulo: 'Políticas de igualdad de género. La Ley Orgánica 3/2007, de 22 de marzo, para la igualdad efectiva de mujeres y hombres. Políticas contra la violencia de género. La Ley Orgánica 1/2004, de 28 de diciembre, de Medidas de Protección Integral contra la Violencia de Género. Políticas dirigidas a la atención de personas discapacitadas y/o dependientes: la Ley 39/2006, de 14 de diciembre, de Promoción de la Autonomía Personal y atención a las personas en situación de dependencia. Igualdad de trato y no discriminación de las personas LGTBI.', disponible: false },
  { num: 15, titulo: 'La gobernanza pública y el gobierno abierto. Concepto y principios informadores del gobierno abierto: colaboración, participación, transparencia y rendición de cuentas. Datos abiertos y reutilización. El marco jurídico y los planes de gobierno abierto en España.', disponible: false }
];

// Función auxiliar para generar variaciones del número de tema
function generarVariacionesNumero(numero) {
  return [
    numero,
    numero.replace(/\./g, ''),
    numero.toLowerCase(),
    numero.toLowerCase().replace(/\./g, '')
  ];
}

// Función para procesar temas de un ejercicio
function procesarTemas(temas, ejercicio, grupo, prefijo, baseUrl) {
  const keywords = [];
  
  // Keywords base según el ejercicio
  if (ejercicio === 'Tercer ejercicio') {
    keywords.push('economía general', 'economía internacional', 'ejercicio 3', 'macro', 'micro', 'tercer ejercicio');
  } else if (ejercicio === 'Cuarto ejercicio') {
    keywords.push('economía española', 'hacienda pública', 'ejercicio 4', 'sector público', 'España', 'cuarto ejercicio');
  } else if (ejercicio === 'Quinto ejercicio') {
    keywords.push('marketing', 'econometría', 'derecho', 'ejercicio 5', 'quinto ejercicio');
  }

  return temas.map(tema => {
    const numero = `${prefijo}.${tema.num}`;
    const id = numero.toLowerCase().replace(/\./g, '');
    const url = tema.disponible ? `${baseUrl}/${tema.file}` : 'temario/tema-no-disponible.html';
    
    return {
      id,
      ejercicio,
      grupo,
      numero,
      title: tema.titulo,
      url,
      keywords: [
        ...keywords,
        ...tema.titulo.toLowerCase().split(' ').filter(w => w.length > 2),
        ...generarVariacionesNumero(numero)
      ],
      type: 'tema',
      parent: ejercicio,
      disponible: tema.disponible
    };
  });
}

// Agregar ejercicios principales
searchIndex.temas.push({
  id: 'ej1',
  ejercicio: 'Primer ejercicio',
  title: 'Test y Dictamen de coyuntura',
  url: 'temario/primer-ejercicio.html',
  keywords: ['test', 'dictamen', 'coyuntura', 'ejercicio 1', 'primer ejercicio'],
  type: 'ejercicio'
});

// Subtemas del primer ejercicio
searchIndex.temas.push({
  id: 'ej1-test',
  ejercicio: 'Primer ejercicio',
  title: 'Test',
  url: 'temario/primer-ejercicio/test/examenes_oficiales_test.pdf',
  keywords: ['test', 'exámenes', 'oficiales', 'ejercicio 1', 'primer ejercicio'],
  type: 'subtema',
  parent: 'Primer ejercicio',
  disponible: true
});

searchIndex.temas.push({
  id: 'ej1-test-simulacro',
  ejercicio: 'Primer ejercicio',
  title: 'Simulacro de Test',
  url: 'temario/primer-ejercicio/test/simulacro.html',
  keywords: ['test', 'simulacro', 'ejercicio 1', 'primer ejercicio'],
  type: 'subtema',
  parent: 'Primer ejercicio',
  disponible: true
});

searchIndex.temas.push({
  id: 'ej1-dictamen',
  ejercicio: 'Primer ejercicio',
  title: 'Dictamen de coyuntura económica',
  url: 'temario/primer-ejercicio/esquema_dictamen_economico.pdf',
  keywords: ['dictamen', 'coyuntura', 'económica', 'ejercicio 1', 'primer ejercicio'],
  type: 'subtema',
  parent: 'Primer ejercicio',
  disponible: true
});

searchIndex.temas.push({
  id: 'ej2',
  ejercicio: 'Segundo ejercicio',
  title: 'Idiomas',
  url: 'temario/segundo-ejercicio.html',
  keywords: ['idiomas', 'inglés', 'francés', 'alemán', 'lenguas', 'ejercicio 2', 'segundo ejercicio'],
  type: 'ejercicio'
});

searchIndex.temas.push({
  id: 'ej3',
  ejercicio: 'Tercer ejercicio',
  title: 'Economía General y Economía Internacional',
  url: 'temario/tercer-ejercicio.html',
  keywords: ['economía general', 'economía internacional', 'ejercicio 3', 'macro', 'micro', 'tercer ejercicio'],
  type: 'ejercicio'
});

// Agregar temas del tercer ejercicio - Parte A
searchIndex.temas.push(...procesarTemas(
  tercerEjercicioParteA,
  'Tercer ejercicio',
  'Parte A: Economía general',
  '3.A',
  'temario/tercer-ejercicio'
));

// Agregar temas del tercer ejercicio - Parte B
searchIndex.temas.push(...procesarTemas(
  tercerEjercicioParteB,
  'Tercer ejercicio',
  'Parte B: Economía Financiera, Economía Internacional y Relaciones Económicas Internacionales',
  '3.B',
  'temario/tercer-ejercicio'
));

searchIndex.temas.push({
  id: 'ej4',
  ejercicio: 'Cuarto ejercicio',
  title: 'Economía Española y Hacienda Pública',
  url: 'temario/cuarto-ejercicio.html',
  keywords: ['economía española', 'hacienda pública', 'ejercicio 4', 'sector público', 'cuarto ejercicio'],
  type: 'ejercicio'
});

// Agregar temas del cuarto ejercicio - Parte A
searchIndex.temas.push(...procesarTemas(
  cuartoEjercicioParteA,
  'Cuarto ejercicio',
  'Parte A: Economía española',
  '4.A',
  'temario/cuarto-ejercicio'
));

// Agregar temas del cuarto ejercicio - Parte B
searchIndex.temas.push(...procesarTemas(
  cuartoEjercicioParteB,
  'Cuarto ejercicio',
  'Parte B: Economía del sector público',
  '4.B',
  'temario/cuarto-ejercicio'
));

searchIndex.temas.push({
  id: 'ej5',
  ejercicio: 'Quinto ejercicio',
  title: 'Marketing, Econometría y Derecho',
  url: 'temario/quinto-ejercicio.html',
  keywords: ['marketing', 'econometría', 'derecho', 'ejercicio 5', 'quinto ejercicio'],
  type: 'ejercicio'
});

// Agregar temas del quinto ejercicio - Parte A
searchIndex.temas.push(...procesarTemas(
  quintoEjercicioParteA,
  'Quinto ejercicio',
  'Parte A: Marketing internacional y técnicas comerciales',
  '5.A',
  'temario/quinto-ejercicio'
));

// Agregar temas del quinto ejercicio - Parte B
searchIndex.temas.push(...procesarTemas(
  quintoEjercicioParteB,
  'Quinto ejercicio',
  'Parte B: Econometría',
  '5.B',
  'temario/quinto-ejercicio'
));

// Agregar temas del quinto ejercicio - Parte C
searchIndex.temas.push(...procesarTemas(
  quintoEjercicioParteC,
  'Quinto ejercicio',
  'Parte C: Derecho Administrativo y Organización del Estado',
  '5.C',
  'temario/quinto-ejercicio'
));

// También agregar las partes como PDFs completos si existen
searchIndex.temas.push({
  id: 'ej5-parte-a-pdf',
  ejercicio: 'Quinto ejercicio',
  title: 'Parte A: Marketing internacional y técnicas comerciales (PDF completo)',
  url: 'temario/quinto-ejercicio/parte_A.pdf',
  keywords: ['marketing', 'internacional', 'técnicas', 'comerciales', 'ejercicio 5', 'quinto ejercicio', 'parte a'],
  type: 'subtema',
  parent: 'Quinto ejercicio',
  disponible: true
});

searchIndex.temas.push({
  id: 'ej5-parte-b-pdf',
  ejercicio: 'Quinto ejercicio',
  title: 'Parte B: Econometría (PDF completo)',
  url: 'temario/quinto-ejercicio/parte_B.pdf',
  keywords: ['econometría', 'ejercicio 5', 'quinto ejercicio', 'parte b'],
  type: 'subtema',
  parent: 'Quinto ejercicio',
  disponible: true
});

// Recursos de organización
searchIndex.recursos = [
  {
    id: 'estrategia',
    title: 'Estrategia y organización',
    description: 'Excel con probabilidades, simulador de sorteos y cronogramas',
    url: 'organizacion/Estrategia y organización.zip',
    category: 'organización',
    keywords: ['estrategia', 'organización', 'cronograma', 'probabilidades', 'excel', 'horarios'],
    type: 'excel'
  },
  {
    id: 'estructura',
    title: 'Estructura del temario',
    description: 'Presentación PowerPoint sobre cómo estructurar el temario',
    url: 'organizacion/ver-presentacion.html',
    category: 'organización',
    keywords: ['estructura', 'temario', 'presentación', 'powerpoint', 'visión global'],
    type: 'presentacion'
  },
  {
    id: 'como-cantar',
    title: 'Cómo cantar un tema',
    description: 'Guía sobre formato y organización de los temas',
    url: 'organizacion/como_cantar_un_tema.pdf',
    category: 'organización',
    keywords: ['cantar', 'tema', 'formato', 'consejos', 'guía'],
    type: 'pdf'
  },
  {
    id: 'plantillas',
    title: 'Plantillas para elaborar temas',
    description: 'Plantillas de Word para temas largos y cortos',
    url: 'organizacion/Plantillas.zip',
    category: 'organización',
    keywords: ['plantillas', 'word', 'elaborar', 'temas', 'esquemas'],
    type: 'word'
  }
];

// ============================================
// BLOG POSTS
// ============================================

// Añadir página principal del blog
searchIndex.pages.push({
  id: 'blog',
  title: 'Blog',
  url: 'blog/index.html',
  description: 'Artículos y análisis sobre economía, política económica y comercio internacional',
  keywords: ['blog', 'artículos', 'análisis', 'economía', 'comercio'],
  content: 'Artículos sobre política económica y comercio internacional'
});

// Leer artículos del blog desde published-articles.json
const blogArticlesPath = path.join(__dirname, 'blog/newsletter/published-articles.json');
if (fs.existsSync(blogArticlesPath)) {
  try {
    const blogData = JSON.parse(fs.readFileSync(blogArticlesPath, 'utf8'));
    if (blogData.articles && Array.isArray(blogData.articles)) {
      blogData.articles.forEach(article => {
        searchIndex.blog.push({
          id: article.slug,
          title: article.title,
          url: `blog/${article.slug}.html`,
          description: article.description,
          date: article.date,
          keywords: [
            'blog',
            'artículo',
            ...article.title.toLowerCase().split(' ').filter(w => w.length > 2),
            ...article.description.toLowerCase().split(' ').filter(w => w.length > 3)
          ],
          type: 'articulo'
        });
      });
    }
    console.log(`   - Artículos del blog: ${searchIndex.blog.length}`);
  } catch (e) {
    console.log('⚠️  No se pudieron cargar los artículos del blog');
  }
} else {
  console.log('⚠️  No se encontró el archivo de artículos del blog');
}

// Guardar el índice como JSON
const outputPath = path.join(__dirname, 'search-index.json');
fs.writeFileSync(outputPath, JSON.stringify(searchIndex, null, 2));

// Estadísticas
const temasDisponibles = searchIndex.temas.filter(t => t.type === 'tema' && t.disponible).length;
const temasTotal = searchIndex.temas.filter(t => t.type === 'tema').length;

console.log('✅ Índice de búsqueda generado correctamente');
console.log(`📊 Estadísticas:`);
console.log(`   - Páginas: ${searchIndex.pages.length}`);
console.log(`   - Temas: ${temasTotal} (${temasDisponibles} disponibles, ${temasTotal - temasDisponibles} no disponibles)`);
console.log(`   - Recursos: ${searchIndex.recursos.length}`);
console.log(`📝 Guardado en: ${outputPath}`);
