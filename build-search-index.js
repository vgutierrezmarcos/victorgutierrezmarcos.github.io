/**
 * Script para generar el índice de búsqueda
 * Incluye todos los ejercicios (1-5) con sus temas
 * Versión con títulos corregidos según la web
 */

const fs = require('fs');
const path = require('path');

// Estructura del índice de búsqueda
const searchIndex = {
  pages: [],
  temas: [],
  recursos: [],
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
    url: 'temario.html',
    description: 'Temario completo para la preparación a la Oposición',
    keywords: ['temario', 'temas', 'ejercicios', 'contenidos'],
    content: 'Materiales organizados por ejercicios con contenidos actualizados hasta finales de 2023'
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

/**
 * Genera variaciones de número de tema para búsqueda
 * Ej: "4.A.1" → ["4.A.1", "4A1", "4.a.1", "4a1", "4A01", "4.A.01"]
 */
function generarVariacionesNumero(numero) {
  if (!numero) return [];
  const variaciones = [numero];
  
  // Versión sin puntos
  variaciones.push(numero.replace(/\./g, ''));
  
  // Versión en minúsculas
  variaciones.push(numero.toLowerCase());
  variaciones.push(numero.toLowerCase().replace(/\./g, ''));
  
  // Versiones con ceros (4A1 → 4A01)
  const match = numero.match(/^(\d+)\.?([A-Za-z])\.?(\d+)$/);
  if (match) {
    const [, num1, letra, num2] = match;
    const num2Padded = num2.padStart(2, '0');
    variaciones.push(`${num1}.${letra}.${num2Padded}`);
    variaciones.push(`${num1}${letra}${num2Padded}`);
    variaciones.push(`${num1}.${letra.toLowerCase()}.${num2Padded}`);
    variaciones.push(`${num1}${letra.toLowerCase()}${num2Padded}`);
    // Sin padding también
    variaciones.push(`${num1}${letra}${num2}`);
    variaciones.push(`${num1}${letra.toLowerCase()}${num2}`);
  }
  
  return [...new Set(variaciones)]; // Eliminar duplicados
}

// Ejercicios con sus temas - TÍTULOS CORREGIDOS SEGÚN LA WEB
const ejercicios = [
  {
    id: 'ej1',
    numero: 'Primer ejercicio',
    title: 'Test y Dictamen de coyuntura',
    url: 'temario/primer-ejercicio.html',
    keywords: ['test', 'dictamen', 'coyuntura', 'ejercicio 1', 'primer ejercicio'],
    subtemas: [
      { title: 'Test', file: 'primer-ejercicio/examenes_oficiales_test.pdf' },
      { title: 'Dictamen de coyuntura económica', file: 'primer-ejercicio/esquema_dictamen_economico.pdf' }
    ]
  },
  {
    id: 'ej2',
    numero: 'Segundo ejercicio',
    title: 'Idiomas: Inglés (obligatorio) y otro a elegir',  // CORREGIDO
    url: 'temario/segundo-ejercicio.html',
    keywords: ['idiomas', 'inglés', 'francés', 'alemán', 'lenguas', 'ejercicio 2', 'segundo ejercicio'],
    subtemas: []
  },
  {
    id: 'ej3',
    numero: 'Tercer ejercicio',
    title: 'Economía General y Economía Internacional',
    url: 'temario/tercer-ejercicio.html',
    keywords: ['economía general', 'economía internacional', 'ejercicio 3', 'macro', 'micro', 'tercer ejercicio'],
    grupos: [
      {
        nombre: 'Parte A: Economía general',
        temas: [
          { num: '3.A.1', titulo: 'Objeto y métodos de la ciencia económica', file: '3A01.pdf' },
          { num: '3.A.2', titulo: 'La evolución del pensamiento económico (I)', file: '3A02.pdf' },
          { num: '3.A.3', titulo: 'La evolución del pensamiento económico (II)', file: '3A03.pdf' },
          { num: '3.A.4', titulo: 'Economía del bienestar (I)', file: '3A04.pdf' },
          { num: '3.A.5', titulo: 'Economía del bienestar (II)', file: '3A05.pdf' },
          { num: '3.A.6', titulo: 'Teoría de la demanda del consumidor (I)', file: '3A06.pdf' },
          { num: '3.A.7', titulo: 'Teoría de la demanda del consumidor (II)', file: '3A07.pdf' },
          { num: '3.A.10', titulo: 'Teoría de la demanda del consumidor (III)', file: '3A10.pdf' },
          { num: '3.A.11', titulo: 'Teoría de la producción', file: '3A11.pdf' },
          { num: '3.A.12', titulo: 'Teoría de los costes', file: '3A12.pdf' },
          { num: '3.A.13', titulo: 'Economía de la información y teoría de la agencia', file: '3A13.pdf' },
          { num: '3.A.16', titulo: 'Análisis de mercados (I). Competencia perfecta', file: '3A16.pdf' },
          { num: '3.A.17', titulo: 'Análisis de mercados (II). Monopolio', file: '3A17.pdf' },
          { num: '3.A.18', titulo: 'Análisis de mercados (III). Oligopolio', file: '3A18.pdf' },
          { num: '3.A.19', titulo: 'Análisis de mercados (IV). Competencia monopolística', file: '3A19.pdf' },
          { num: '3.A.20', titulo: 'Los mercados de factores (I)', file: '3A20.pdf' },
          { num: '3.A.21', titulo: 'Los mercados de factores (II)', file: '3A21.pdf' },
          { num: '3.A.22', titulo: 'La macroeconomía: introducción y contabilidad nacional', file: '3A22.pdf' },
          { num: '3.A.23', titulo: 'El modelo IS-LM', file: '3A23.pdf' },
          { num: '3.A.24', titulo: 'Expectativas, consumo e inversión', file: '3A24.pdf' },
          { num: '3.A.25', titulo: 'Mercados financieros', file: '3A25.pdf' },
          { num: '3.A.26', titulo: 'Demanda y oferta de dinero', file: '3A26.pdf' },
          { num: '3.A.27', titulo: 'Oferta agregada', file: '3A27.pdf' },
          { num: '3.A.28', titulo: 'Inflación y desempleo', file: '3A28.pdf' },
          { num: '3.A.29', titulo: 'Crecimiento económico (I)', file: '3A29.pdf' },
          { num: '3.A.30', titulo: 'Crecimiento económico (II)', file: '3A30.pdf' },
          { num: '3.A.31', titulo: 'Política monetaria', file: '3A31.pdf' },
          { num: '3.A.32', titulo: 'Política fiscal', file: '3A32.pdf' },
          { num: '3.A.33', titulo: 'Fluctuaciones y ciclos económicos', file: '3A33.pdf' }
        ]
      },
      {
        nombre: 'Parte B: Economía Financiera e Internacional',
        temas: [
          { num: '3.B.1', titulo: 'Ventaja comparativa y ganancias del comercio', file: '3B01.pdf' },
          { num: '3.B.2', titulo: 'Modelo clásico del comercio internacional', file: '3B02.pdf' },
          { num: '3.B.3', titulo: 'Modelo Heckscher-Ohlin', file: '3B03.pdf' },
          { num: '3.B.4', titulo: 'Economías de escala y comercio intraindustrial', file: '3B04.pdf' },
          { num: '3.B.5', titulo: 'Empresas heterogéneas y comercio internacional', file: '3B05.pdf' },
          { num: '3.B.6', titulo: 'Competencia imperfecta y comercio estratégico', file: '3B06.pdf' },
          { num: '3.B.7', titulo: 'La política comercial (I)', file: '3B07.pdf' },
          { num: '3.B.8', titulo: 'La política comercial (II)', file: '3B08.pdf' },
          { num: '3.B.9', titulo: 'Comercio internacional y crecimiento', file: '3B09.pdf' },
          { num: '3.B.10', titulo: 'Teoría de la integración económica', file: '3B10.pdf' },
          { num: '3.B.11', titulo: 'Balanza de pagos', file: '3B11.pdf' },
          { num: '3.B.12', titulo: 'Mercado de divisas', file: '3B12.pdf' },
          { num: '3.B.13', titulo: 'Tipo de cambio a corto plazo', file: '3B13.pdf' },
          { num: '3.B.14', titulo: 'Tipo de cambio a largo plazo', file: '3B14.pdf' },
          { num: '3.B.15', titulo: 'Producción y tipo de cambio a corto plazo', file: '3B15.pdf' },
          { num: '3.B.16', titulo: 'Tipos de cambio fijos y flotantes', file: '3B16.pdf' },
          { num: '3.B.17', titulo: 'Modelo Mundell-Fleming', file: '3B17.pdf' },
          { num: '3.B.18', titulo: 'Política macroeconómica en economía abierta', file: '3B18.pdf' },
          { num: '3.B.19', titulo: 'Áreas monetarias óptimas', file: '3B19.pdf' },
          { num: '3.B.20', titulo: 'Sistema monetario internacional', file: '3B20.pdf' },
          { num: '3.B.21', titulo: 'Mercados financieros internacionales', file: '3B21.pdf' },
          { num: '3.B.22', titulo: 'Crisis financieras internacionales', file: '3B22.pdf' },
          { num: '3.B.23', titulo: 'Globalización y desigualdad', file: '3B23.pdf' },
          { num: '3.B.24', titulo: 'Inversión extranjera directa', file: '3B24.pdf' },
          { num: '3.B.25', titulo: 'Empresa multinacional', file: '3B25.pdf' },
          { num: '3.B.26', titulo: 'Desarrollo económico', file: '3B26.pdf' },
          { num: '3.B.27', titulo: 'Cooperación al desarrollo', file: '3B27.pdf' },
          { num: '3.B.28', titulo: 'Instituciones económicas internacionales', file: '3B28.pdf' },
          { num: '3.B.33', titulo: 'El GATT', file: '3B33.pdf' },
          { num: '3.B.34', titulo: 'La OMC. Otros acuerdos', file: '3B34.pdf' },
          { num: '3.B.35', titulo: 'Procesos de integración no comunitarios', file: '3B35.pdf' },
          { num: '3.B.36', titulo: 'Instituciones de la UE', file: '3B36.pdf' },
          { num: '3.B.37', titulo: 'Finanzas y presupuesto de la UE', file: '3B37.pdf' },
          { num: '3.B.39', titulo: 'Mercado único de la UE', file: '3B39.pdf' },
          { num: '3.B.40', titulo: 'Cohesión económica y social en la UE', file: '3B40.pdf' },
          { num: '3.B.41', titulo: 'Política comercial de la UE', file: '3B41.pdf' },
          { num: '3.B.42', titulo: 'Relaciones exteriores de la UE', file: '3B42.pdf' }
        ]
      }
    ]
  },
  {
    id: 'ej4',
    numero: 'Cuarto ejercicio',
    title: 'Economía Española y Hacienda Pública',
    url: 'temario/cuarto-ejercicio.html',
    keywords: ['economía española', 'hacienda pública', 'ejercicio 4', 'sector público', 'España', 'cuarto ejercicio'],
    grupos: [
      {
        nombre: 'Parte A: Economía española',
        temas: [
          { num: '4.A.1', titulo: 'Fuentes estadísticas españolas. Metodologías y limitaciones', file: '4A01.pdf', disponible: true },
          { num: '4.A.2', titulo: 'Los recursos humanos en España: estructura demográfica y capital humano', file: null, disponible: false },
          { num: '4.A.3', titulo: 'La distribución personal y entre factores productivos de la renta en España', file: null, disponible: false },
          { num: '4.A.4', titulo: 'Los sectores agrario y pesquero en España', file: null, disponible: false },
          { num: '4.A.5', titulo: 'Estructura del sector energético y sus subsectores', file: null, disponible: false },
          { num: '4.A.6', titulo: 'La política española de energía y clima', file: null, disponible: false },
          { num: '4.A.7', titulo: 'El sistema y la política de ciencia y tecnología en España', file: null, disponible: false },
          { num: '4.A.8', titulo: 'La empresa en España. Características principales', file: null, disponible: false },
          { num: '4.A.9', titulo: 'Análisis de la industria en España', file: null, disponible: false },
          { num: '4.A.10', titulo: 'Estructura sectorial de la industria en España', file: null, disponible: false },
          { num: '4.A.11', titulo: 'El sector de la construcción en España. El mercado de la vivienda', file: '4A11.pdf', disponible: true },
          { num: '4.A.12', titulo: 'Estructura y política de los sectores de los transportes y las telecomunicaciones', file: '4A12.pdf', disponible: true },
          { num: '4.A.13', titulo: 'El turismo en España: evolución, retos y política turística', file: '4A13.pdf', disponible: true },
          { num: '4.A.14', titulo: 'Estructura, políticas y retos de la distribución comercial', file: '4A14.pdf', disponible: true },
          { num: '4.A.15', titulo: 'La defensa y la promoción de la competencia en España', file: '4A15.pdf', disponible: true },
          { num: '4.A.16', titulo: 'Mercado de trabajo en España', file: '4A16.pdf', disponible: true },
          { num: '4.A.17', titulo: 'Economía de las regiones españolas', file: '4A17.pdf', disponible: true },
          { num: '4.A.18', titulo: 'Sistema financiero español (I). Evolución reciente', file: '4A18.pdf', disponible: true },
          { num: '4.A.19', titulo: 'Sistema financiero español (II). Las entidades de crédito', file: '4A19.pdf', disponible: true },
          { num: '4.A.20', titulo: 'Sistema financiero español (III). Mercados de valores', file: '4A20.pdf', disponible: true },
          { num: '4.A.21', titulo: 'Análisis de la evolución de la balanza de pagos y de la PII de España', file: '4A21.pdf', disponible: true },
          { num: '4.A.22', titulo: 'La internacionalización de la economía española (I). Comercio', file: '4A22.pdf', disponible: true },
          { num: '4.A.23', titulo: 'La internacionalización de la economía española (II). Inversión', file: '4A23.pdf', disponible: true },
          { num: '4.A.24', titulo: 'La política española de internacionalización (I). Instrumentos financieros', file: '4A24.pdf', disponible: true },
          { num: '4.A.25', titulo: 'La política española de internacionalización (II). Instituciones y programas', file: '4A25.pdf', disponible: true },
          { num: '4.A.26', titulo: 'La política española de internacionalización (III). Acuerdos comerciales', file: '4A26.pdf', disponible: true },
          { num: '4.A.27', titulo: 'Evolución de la economía y política económica española. Crisis 2008', file: '4A27.pdf', disponible: true },
          { num: '4.A.28', titulo: 'Evolución de la economía y política económica española. Recuperación', file: '4A28.pdf', disponible: true },
          { num: '4.A.29', titulo: 'Evolución de la economía española desde la crisis de la Covid-19', file: null, disponible: false },
          { num: '4.A.30', titulo: 'Las relaciones financieras de España con la Unión Europea', file: null, disponible: false }
        ]
      },
      {
        nombre: 'Parte B: Economía del sector público',
        temas: [
          { num: '4.B.1', titulo: 'El sector público: delimitación, operaciones y cuentas principales', file: '4B01.pdf', disponible: true },
          { num: '4.B.2', titulo: 'Los mecanismos de decisión del sector público', file: '4B02.pdf', disponible: true },
          { num: '4.B.3', titulo: 'El presupuesto como elemento de redistribución. El Estado de Bienestar', file: '4B03.pdf', disponible: true },
          { num: '4.B.4', titulo: 'El presupuesto como elemento compensador de la actividad económica', file: '4B04.pdf', disponible: true },
          { num: '4.B.5', titulo: 'El gasto público. Razones de su crecimiento', file: '4B05.pdf', disponible: true },
          { num: '4.B.6', titulo: 'Evaluación de las políticas públicas', file: '4B06.pdf', disponible: true },
          { num: '4.B.7', titulo: 'Ingresos públicos. Elementos definidores y clases de impuestos', file: '4B07.pdf', disponible: true },
          { num: '4.B.8', titulo: 'Traslación e incidencia de los impuestos', file: '4B08.pdf', disponible: true },
          { num: '4.B.9', titulo: 'Efecto renta y efecto sustitución de los impuestos', file: '4B09.pdf', disponible: true },
          { num: '4.B.10', titulo: 'Imposición y oferta. Efectos incentivo de los impuestos', file: '4B10.pdf', disponible: true },
          { num: '4.B.11', titulo: 'La imposición óptima. Tipo impositivo óptimo. Regla de Ramsey', file: '4B11.pdf', disponible: true },
          { num: '4.B.12', titulo: 'La imposición directa: teoría y comparaciones internacionales', file: '4B12.pdf', disponible: true },
          { num: '4.B.13', titulo: 'La imposición indirecta: teoría y comparaciones internacionales', file: '4B13.pdf', disponible: true },
          { num: '4.B.14', titulo: 'La teoría del federalismo fiscal', file: null, disponible: false },
          { num: '4.B.15', titulo: 'La empresa pública. Razones de su existencia. La política de privatizaciones', file: '4B15.pdf', disponible: true },
          { num: '4.B.16', titulo: 'Principios presupuestarios', file: '4B16.pdf', disponible: true },
          { num: '4.B.17', titulo: 'El ciclo presupuestario en España', file: '4B17.pdf', disponible: true },
          { num: '4.B.18', titulo: 'El presupuesto de la UE. El procedimiento presupuestario', file: '4B18.pdf', disponible: true },
          { num: '4.B.19', titulo: 'La sostenibilidad de las finanzas públicas', file: '4B19.pdf', disponible: true },
          { num: '4.B.20', titulo: 'Déficit y deuda de las AAPP en la UE', file: '4B20.pdf', disponible: true },
          { num: '4.B.21', titulo: 'La estabilidad presupuestaria en España', file: '4B21.pdf', disponible: true },
          { num: '4.B.22', titulo: 'El sistema tributario español (I). Estructura general', file: '4B22.pdf', disponible: true },
          { num: '4.B.23', titulo: 'El sistema tributario español (II). Principales figuras impositivas', file: '4B23.pdf', disponible: true },
          { num: '4.B.24', titulo: 'El Sistema de la Seguridad Social en España', file: null, disponible: false },
          { num: '4.B.25', titulo: 'Las Administraciones Territoriales en España', file: null, disponible: false },
          { num: '4.B.26', titulo: 'El saldo presupuestario y la deuda de las AAPP en España', file: '4B26.pdf', disponible: true }
        ]
      }
    ]
  },
  {
    id: 'ej5',
    numero: 'Quinto ejercicio',
    title: 'Marketing, Econometría y Derecho',
    url: 'temario/quinto-ejercicio.html',
    keywords: ['marketing', 'econometría', 'derecho', 'ejercicio 5', 'quinto ejercicio'],
    subtemas: [
      { title: 'Parte A: Marketing internacional y técnicas comerciales', file: 'quinto-ejercicio/parte_A.pdf' },
      { title: 'Parte B: Econometría', file: 'quinto-ejercicio/parte_B.pdf' }
    ]
  }
];

// Procesar ejercicios y agregar temas al índice
ejercicios.forEach(ejercicio => {
  // Agregar el ejercicio principal
  searchIndex.temas.push({
    id: ejercicio.id,
    ejercicio: ejercicio.numero,
    title: ejercicio.title,
    url: ejercicio.url,
    keywords: ejercicio.keywords,
    type: 'ejercicio'
  });

  // Agregar subtemas si existen
  if (ejercicio.subtemas) {
    ejercicio.subtemas.forEach(subtema => {
      const subtemaId = `${ejercicio.id}-${subtema.title.toLowerCase().replace(/\s+/g, '-')}`;
      searchIndex.temas.push({
        id: subtemaId,
        ejercicio: ejercicio.numero,
        title: subtema.title,
        url: `temario/${subtema.file}`,
        keywords: [...ejercicio.keywords, ...subtema.title.toLowerCase().split(' ')],
        type: 'subtema',
        parent: ejercicio.numero
      });
    });
  }

  // Agregar grupos de temas si existen
  if (ejercicio.grupos) {
    ejercicio.grupos.forEach(grupo => {
      grupo.temas.forEach(tema => {
        const temaId = tema.num.toLowerCase().replace(/\./g, '');
        const variacionesNumero = generarVariacionesNumero(tema.num);
        
        // Determinar la URL según disponibilidad
        let url;
        if (tema.disponible === false || tema.file === null) {
          url = 'temario/tema-no-disponible.html';
        } else {
          // Para ejercicio 3
          if (ejercicio.id === 'ej3') {
            url = `temario/tercer-ejercicio/${tema.file}`;
          }
          // Para ejercicio 4
          else if (ejercicio.id === 'ej4') {
            url = `temario/cuarto-ejercicio/${tema.file}`;
          }
          else {
            url = `temario/${tema.file}`;
          }
        }
        
        searchIndex.temas.push({
          id: temaId,
          ejercicio: ejercicio.numero,
          grupo: grupo.nombre,
          numero: tema.num,
          title: tema.titulo,
          url: url,
          keywords: [
            ...ejercicio.keywords,
            ...tema.titulo.toLowerCase().split(' ').filter(w => w.length > 2),
            ...variacionesNumero
          ],
          type: 'tema',
          parent: ejercicio.numero,
          disponible: tema.disponible !== false
        });
      });
    });
  }
});

// Recursos de organización
searchIndex.recursos = [
  {
    id: 'estrategia',
    title: 'Estrategia y organización',
    description: 'Excel con probabilidades, simulador de sorteos y cronogramas',
    url: 'organizacion/Estrategia y organización.zip',
    category: 'organización',
    keywords: ['estrategia', 'organización', 'cronograma', 'probabilidades', 'excel', 'horarios', 'simulador', 'sorteo'],
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
    keywords: ['cantar', 'tema', 'formato', 'consejos', 'guía', 'oral'],
    type: 'pdf'
  },
  {
    id: 'plantillas',
    title: 'Plantillas para elaborar temas',
    description: 'Plantillas de Word para temas largos y cortos',
    url: 'organizacion/Plantillas.zip',
    category: 'organización',
    keywords: ['plantillas', 'word', 'elaborar', 'temas', 'esquemas', 'plantilla'],
    type: 'word'
  }
];

// Guardar el índice como JSON
const outputPath = path.join(__dirname, 'search-index.json');
fs.writeFileSync(outputPath, JSON.stringify(searchIndex, null, 2));

console.log('✅ Índice de búsqueda generado correctamente');
console.log(`📊 Estadísticas:`);
console.log(`   - Páginas: ${searchIndex.pages.length}`);
console.log(`   - Temas: ${searchIndex.temas.length}`);
console.log(`   - Recursos: ${searchIndex.recursos.length}`);
console.log(`📁 Guardado en: ${outputPath}`);
