/**
 * Script para generar el índice de búsqueda
 * Extrae texto de PDFs y cataloga todos los recursos de la web
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
    url: 'temario/index.html',
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

// Ejercicios
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
    title: 'Idiomas',
    url: 'temario/segundo-ejercicio.html',
    keywords: ['idiomas', 'inglés', 'francés', 'alemán', 'lenguas', 'ejercicio 2'],
    subtemas: []
  },
  {
    id: 'ej3',
    numero: 'Tercer ejercicio',
    title: 'Economía General y Economía Internacional',
    url: 'temario/tercer-ejercicio.html',
    keywords: ['economía general', 'economía internacional', 'ejercicio 3', 'macro', 'micro'],
    grupos: [
      {
        nombre: 'Parte A: Economía general',
        temas: [
          { num: '3.A.1', titulo: 'Objeto y métodos de la ciencia económica', file: '3A01.pdf' },
          { num: '3.A.2', titulo: 'Los economistas clásicos y Marx', file: '3A02.pdf' },
          { num: '3.A.3', titulo: 'Los economistas neoclásicos', file: '3A03.pdf' },
          { num: '3.A.4', titulo: 'El pensamiento económico de Keynes', file: '3A04.pdf' },
          { num: '3.A.6', titulo: 'La nueva macroeconomía clásica', file: '3A06.pdf' },
          { num: '3.A.7', titulo: 'La nueva economía keynesiana', file: '3A07.pdf' },
          { num: '3.A.8', titulo: 'Teoría de la demanda del consumidor (I)', file: '3A08.pdf' },
          { num: '3.A.9', titulo: 'Teoría de la demanda del consumidor (II)', file: '3A09.pdf' },
          { num: '3.A.10', titulo: 'Teoría de la demanda del consumidor (III)', file: '3A10.pdf' },
          { num: '3.A.11', titulo: 'Teoría de la producción', file: '3A11.pdf' },
          { num: '3.A.12', titulo: 'Teoría de los costes', file: '3A12.pdf' },
          { num: '3.A.13', titulo: 'Economía de la información y teoría de la agencia', file: '3A13.pdf' },
          { num: '3.A.16', titulo: 'Análisis de mercados (I). Competencia perfecta', file: '3A16.pdf' },
          { num: '3.A.17', titulo: 'Análisis de mercados (II). Monopolio', file: '3A17.pdf' },
          { num: '3.A.18', titulo: 'Análisis de mercados (III). Competencia monopolística', file: '3A18.pdf' },
          { num: '3.A.19', titulo: 'Análisis de mercados (IV). Oligopolio', file: '3A19.pdf' },
          { num: '3.A.21', titulo: 'La teoría del equilibrio general', file: '3A21.pdf' },
          { num: '3.A.22', titulo: 'Economía del bienestar (I)', file: '3A22.pdf' },
          { num: '3.A.23', titulo: 'Economía del bienestar (II). Fallos de mercado', file: '3A23.pdf' },
          { num: '3.A.24', titulo: 'Economía del bienestar (III). Elección colectiva', file: '3A24.pdf' },
          { num: '3.A.25', titulo: 'Teoría neoclásica del mercado de trabajo', file: '3A25.pdf' },
          { num: '3.A.26', titulo: 'Desempleo friccional. Modelo de búsqueda', file: '3A26.pdf' },
          { num: '3.A.27', titulo: 'Determinación de salarios', file: '3A27.pdf' },
          { num: '3.A.28', titulo: 'La tasa natural de paro y la NAIRU', file: '3A28.pdf' },
          { num: '3.A.29', titulo: 'Modelización dinámica de decisiones', file: '3A29.pdf' },
          { num: '3.A.30', titulo: 'Magnitudes macroeconómicas', file: '3A30.pdf' },
          { num: '3.A.33', titulo: 'Teorías de la demanda de consumo', file: '3A33.pdf' },
          { num: '3.A.34', titulo: 'Teorías de la inversión', file: '3A34.pdf' },
          { num: '3.A.35', titulo: 'Teorías de la demanda de dinero', file: '3A35.pdf' },
          { num: '3.A.36', titulo: 'La política monetaria (I)', file: '3A36.pdf' },
          { num: '3.A.37', titulo: 'La política monetaria (II)', file: '3A37.pdf' },
          { num: '3.A.38', titulo: 'La política fiscal', file: '3A38.pdf' },
          { num: '3.A.39', titulo: 'Déficit público y deuda pública', file: '3A39.pdf' },
          { num: '3.A.41', titulo: 'La inflación', file: '3A41.pdf' },
          { num: '3.A.42', titulo: 'Teorías de los ciclos económicos', file: '3A42.pdf' },
          { num: '3.A.43', titulo: 'Crecimiento económico (I). Solow', file: '3A43.pdf' },
          { num: '3.A.44', titulo: 'Crecimiento económico (II). Endógeno', file: '3A44.pdf' },
          { num: '3.A.45', titulo: 'Evidencia empírica sobre crecimiento', file: '3A45.pdf' }
        ]
      },
      {
        nombre: 'Parte B: Economía Financiera e Internacional',
        temas: [
          { num: '3.B.1', titulo: 'Información financiera de las empresas', file: '3B01.pdf' },
          { num: '3.B.2', titulo: 'Decisiones de inversión', file: '3B02.pdf' },
          { num: '3.B.3', titulo: 'Decisiones de financiación', file: '3B03.pdf' },
          { num: '3.B.4', titulo: 'Crecimiento y valoración de empresas', file: '3B04.pdf' },
          { num: '3.B.5', titulo: 'Teoría del comercio internacional (I)', file: '3B05.pdf' },
          { num: '3.B.6', titulo: 'Teoría del comercio internacional (II)', file: '3B06.pdf' },
          { num: '3.B.7', titulo: 'La política comercial (I)', file: '3B07.pdf' },
          { num: '3.B.8', titulo: 'La política comercial (II)', file: '3B08.pdf' },
          { num: '3.B.9', titulo: 'Comercio internacional y crecimiento', file: '3B09.pdf' },
          { num: '3.B.10', titulo: 'Teoría de la integración económica', file: '3B10.pdf' },
          { num: '3.B.11', titulo: 'Balanza de pagos', file: '3B11.pdf' },
          { num: '3.B.12', titulo: 'Mecanismos de ajuste de balanza de pagos', file: '3B12.pdf' },
          { num: '3.B.13', titulo: 'Mercado de divisas', file: '3B13.pdf' },
          { num: '3.B.14', titulo: 'Determinación del tipo de cambio', file: '3B14.pdf' },
          { num: '3.B.15', titulo: 'Regímenes cambiarios', file: '3B15.pdf' },
          { num: '3.B.16', titulo: 'Integración monetaria', file: '3B16.pdf' },
          { num: '3.B.17', titulo: 'Crisis de balanza de pagos', file: '3B17.pdf' },
          { num: '3.B.19', titulo: 'Coordinación internacional de políticas', file: '3B19.pdf' },
          { num: '3.B.20', titulo: 'Sistema económico internacional hasta Bretton Woods', file: '3B20.pdf' },
          { num: '3.B.21', titulo: 'Sistema económico internacional post-Bretton Woods', file: '3B21.pdf' },
          { num: '3.B.22', titulo: 'El FMI', file: '3B22.pdf' },
          { num: '3.B.23', titulo: 'Instrumentos de renta variable', file: '3B23.pdf' },
          { num: '3.B.24', titulo: 'Instrumentos de renta fija', file: '3B24.pdf' },
          { num: '3.B.25', titulo: 'Mercados de derivados', file: '3B25.pdf' },
          { num: '3.B.27', titulo: 'Regulación financiera', file: '3B27.pdf' },
          { num: '3.B.28', titulo: 'Economía del desarrollo', file: '3B28.pdf' },
          { num: '3.B.33', titulo: 'La OMC. El GATT', file: '3B33.pdf' },
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
    keywords: ['economía española', 'hacienda pública', 'ejercicio 4', 'sector público'],
    grupos: [
      {
        nombre: 'Parte A: Economía española',
        temas: [] // Todos marcados como no disponibles
      },
      {
        nombre: 'Parte B: Economía del sector público',
        temas: [] // Todos marcados como no disponibles
      }
    ]
  },
  {
    id: 'ej5',
    numero: 'Quinto ejercicio',
    title: 'Marketing, Econometría y Derecho',
    url: 'temario/quinto-ejercicio.html',
    keywords: ['marketing', 'econometría', 'derecho', 'ejercicio 5'],
    subtemas: [
      { title: 'Parte A: Marketing internacional y técnicas comerciales', file: 'quinto-ejercicio/parte_A.pdf' },
      { title: 'Parte B: Econometría', file: 'quinto-ejercicio/parte_B.pdf' }
    ]
  }
];

// Procesar ejercicios y agregar temas al índice
ejercicios.forEach(ejercicio => {
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
      searchIndex.temas.push({
        id: `${ejercicio.id}-${subtema.title.toLowerCase().replace(/\s+/g, '-')}`,
        ejercicio: ejercicio.numero,
        title: subtema.title,
        url: `temario/${subtema.file}`,
        keywords: ejercicio.keywords.concat(subtema.title.toLowerCase().split(' ')),
        type: 'subtema',
        parent: ejercicio.numero
      });
    });
  }

  // Agregar grupos y sus temas
  if (ejercicio.grupos) {
    ejercicio.grupos.forEach(grupo => {
      grupo.temas.forEach(tema => {
        // Generar variaciones del número de tema para búsqueda
        const numeroVariations = [
          tema.num,                          // "3.A.8"
          tema.num.replace(/\./g, ''),      // "3A8"
          tema.num.toLowerCase(),            // "3.a.8"
          tema.num.toLowerCase().replace(/\./g, ''), // "3a8"
        ];
        
        searchIndex.temas.push({
          id: tema.num.toLowerCase().replace(/\./g, ''),
          ejercicio: ejercicio.numero,
          grupo: grupo.nombre,
          numero: tema.num,
          title: tema.titulo,
          url: `temario/tercer-ejercicio/${tema.file}`,
          keywords: ejercicio.keywords.concat(
            tema.titulo.toLowerCase().split(' '),
            numeroVariations
          ),
          type: 'tema',
          parent: ejercicio.numero
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

// Guardar el índice como JSON
const outputPath = path.join(__dirname, 'search-index.json');
fs.writeFileSync(outputPath, JSON.stringify(searchIndex, null, 2));

console.log('✅ Índice de búsqueda generado correctamente');
console.log(`📊 Estadísticas:`);
console.log(`   - Páginas: ${searchIndex.pages.length}`);
console.log(`   - Temas: ${searchIndex.temas.length}`);
console.log(`   - Recursos: ${searchIndex.recursos.length}`);
console.log(`📁 Guardado en: ${outputPath}`);
