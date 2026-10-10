#!/usr/bin/env node
/**
 * Genera los ficheros JSON que consume la app móvil TCEE a partir del HTML de la web:
 *   - oposicion/temario/temario.json  (índice de ejercicios, partes y temas con URL de PDF)
 *   - oposicion/enlaces.json          (enlaces útiles agrupados por categoría)
 *
 * Se ejecuta en el workflow update-sitemap.yml y puede lanzarse a mano:
 *   node build-app-data.js
 *
 * Autor: Víctor Gutiérrez Marcos
 */

const fs = require('fs');
const path = require('path');

const ROOT = __dirname;
const BASE_URL = 'https://www.victorgutierrezmarcos.es';

function leer(rel) {
    return fs.readFileSync(path.join(ROOT, rel), 'utf8');
}

function limpiarTexto(html) {
    return html
        .replace(/<[^>]+>/g, '')
        .replace(/&amp;/g, '&')
        .replace(/&nbsp;/g, ' ')
        .replace(/\s+/g, ' ')
        .trim();
}

// ---------------------------------------------------------------------------
// Temario
// ---------------------------------------------------------------------------

const EJERCICIOS = [
    {
        id: 1, slug: 'primer-ejercicio', nombre: 'Primer ejercicio',
        descripcion: 'Test y Dictamen de coyuntura', tipo: 'recursos'
    },
    {
        id: 2, slug: 'segundo-ejercicio', nombre: 'Segundo ejercicio',
        descripcion: 'Idiomas: Inglés (obligatorio) y otro a elegir', tipo: 'info'
    },
    {
        id: 3, slug: 'tercer-ejercicio', nombre: 'Tercer ejercicio',
        descripcion: 'Economía General y Economía Internacional', tipo: 'temas'
    },
    {
        id: 4, slug: 'cuarto-ejercicio', nombre: 'Cuarto ejercicio',
        descripcion: 'Economía Española y Hacienda Pública', tipo: 'temas'
    },
    {
        id: 5, slug: 'quinto-ejercicio', nombre: 'Quinto ejercicio',
        descripcion: 'Marketing, Econometría y Derecho', tipo: 'partes'
    }
];

/**
 * Extrae partes y temas de una página de ejercicio con acordeones
 * (tercer-ejercicio.html y cuarto-ejercicio.html).
 */
function parsearEjercicioConTemas(html, slug) {
    const partes = [];
    // Troceamos por cabecera de grupo: cada trozo contiene los temas de esa parte
    // hasta la siguiente cabecera (o el final de la lista).
    const trozos = html.split(/<div class="tema-group-header"/).slice(1);
    for (const trozo of trozos) {
        const g = trozo.match(/<span>([^<]+)<\/span>([\s\S]*?)(?:<\/article>|$)/);
        if (!g) continue;
        const tituloParte = limpiarTexto(g[1]);                     // "Parte A: Economía general"
        const letra = (tituloParte.match(/Parte ([A-Z])/) || [])[1] || '';
        const nombreParte = tituloParte.replace(/^Parte [A-Z]:\s*/, '');
        const temas = [];
        // el bloque puede llevar un segundo enlace opcional al DOCX del tema
        const itemRe = /<div class="tema-item"><a href="([^"]+)"[^>]*>([\s\S]*?)<\/a>([\s\S]*?)<\/div>/g;
        let it;
        while ((it = itemRe.exec(g[2])) !== null) {
            const href = it[1];
            const inner = it[2];
            const docxMatch = (it[3] || '').match(/class="tema-item-docx" href="([^"]+)"/);
            const disponible = !/tema-no-disponible\.html/.test(href);
            const codigoMatch = inner.match(/Tema\s+(\d+\.[A-Z]\.\d+)/);
            const tituloMatch = inner.match(/<span class="tema-item-title">([\s\S]*?)<\/span>/);
            if (!codigoMatch) continue;
            const temaAnterior = /badge-anterior/.test(inner);
            temas.push({
                codigo: codigoMatch[1],
                titulo: tituloMatch ? limpiarTexto(tituloMatch[1]) : limpiarTexto(inner),
                disponible,
                temarioAnterior: temaAnterior,
                url: disponible ? `${BASE_URL}/oposicion/temario/${href}` : null,
                ...(docxMatch ? { urlDocx: `${BASE_URL}/oposicion/temario/${docxMatch[1]}` } : {})
            });
        }
        partes.push({ letra, nombre: nombreParte, temas });
    }
    return partes;
}

/**
 * Temas del quinto ejercicio (la web solo publica un PDF por parte, así que los
 * títulos se mantienen aquí; coinciden con la hoja "Listado de temas" del Excel
 * de organización). Actualizar a mano si cambia el programa.
 */
const TEMAS_QUINTO = {
    A: [
        'Los regímenes de comercio exterior.',
        'Los instrumentos de defensa comercial.',
        'Los instrumentos de atracción de inversiones exteriores.',
        'Los instrumentos de promoción del turismo en España.',
        'La regulación de las inversiones extranjeras en España y de las españolas en el exterior.',
        'Formas de penetración e implantación en los mercados. El estudio de los mercados exteriores y la prospección.',
        'Los canales de distribución y las redes de venta.',
        'La oferta internacional: el producto y el precio. La comunicación en el comercio internacional.',
        'El cuadro jurídico de las operaciones de comercio exterior: el contrato de venta internacional y la resolución de litigios.',
        'Las políticas logísticas y financieras de la empresa exportadora. Los medios de pago en el comercio internacional.'
    ],
    B: [
        'Supuestos clásicos del modelo de regresión lineal. Aproximación lineal al modelo no lineal. Método de mínimos cuadrados ordinarios y método de máxima verosimilitud. Medidas de bondad de ajuste del modelo.',
        'Propiedades de los estimadores de mínimos cuadrados ordinarios para muestras finitas y muestras grandes en el modelo de regresión lineal. Contraste de hipótesis e intervalos de confianza.',
        'Heterocedasticidad y autocorrelación: origen, consecuencias, detección y soluciones. Estimación por mínimos cuadrados generalizados.',
        'La causalidad en los modelos de regresión. Problema de la variable omitida y estimación por variables instrumentales. Otras soluciones: diseños experimentales, regresión en discontinuidad y diferencias en diferencias.',
        'Procesos estocásticos. Ruido blanco, AR, MA, ARMA y ARIMA: identificación, estimación, verificación y predicción.',
        'Datos de panel. Descripción del problema. El modelo de efectos fijos y de efectos aleatorios. Estimación.'
    ],
    C: [
        'Las fuentes del Derecho Administrativo. La Constitución. La ley. Los decretos-leyes. La delegación legislativa.',
        'El reglamento. La potestad reglamentaria. Los reglamentos ilegales. Actos administrativos generales, circulares e instrucciones.',
        'El acto administrativo: concepto, clases y elementos. Su motivación y notificación. Eficacia y validez de los actos administrativos. Revisión, anulación y revocación.',
        'Los recursos administrativos.',
        'La jurisdicción contencioso-administrativa. Extensión y límites. Las partes del procedimiento. La sentencia. Recursos.',
        'Los contratos del sector público: concepto y clases. Estudio de sus elementos. Su cumplimiento. La revisión de precios y otras alteraciones contractuales. Incumplimiento de los contratos.',
        'El servicio público: concepto y clases. Forma de gestión de los servicios públicos. Examen especial de la gestión directa. La gestión indirecta: modalidades. La concesión. Régimen jurídico.',
        'Procedimiento administrativo común de las administraciones públicas: objeto y ámbito de aplicación. El procedimiento administrativo: concepto y naturaleza. Las garantías del procedimiento. Iniciación, ordenación, instrucción y terminación del procedimiento administrativo común. Los procedimientos especiales.',
        'Régimen jurídico del personal al servicio de las administraciones públicas. Ley del Estatuto Básico del Empleado Público. La Ley de Medidas para la Reforma de la Función Pública. Órganos superiores de la Función Pública. Oferta de empleo público.',
        'La Constitución española de 1978: estructura y contenido. Derechos y deberes fundamentales. Su garantía y suspensión. El Defensor del Pueblo. El Tribunal de Cuentas. El Tribunal Constitucional. Reforma de la Constitución.',
        'El Gobierno, su Presidente y el Consejo de Ministros. La Ley de Régimen Jurídico del Sector Público. Objeto y ámbito de aplicación. Principios generales. Organización y funcionamiento de la Administración General del Estado. Organización Central. Órganos Superiores y Directivos. Los Ministerios y su estructura interna. La Organización territorial de la Administración General del Estado. Las Delegaciones y Subdelegaciones del Gobierno.',
        'Organización y competencias del Ministerio de Asuntos Económicos y Transformación Digital, y del Ministerio de Industria, Comercio y Turismo. Especial mención a la Secretaría de Estado de Economía y Apoyo a la Empresa, y a la Secretaría de Estado de Comercio. Otros Ministerios económicos. La Administración Territorial del Ministerio de Industria, Comercio y Turismo. Su administración institucional. ICEX España Exportación e Inversiones.',
        'Organización territorial del Estado. Las Comunidades Autónomas: constitución, competencias, Estatutos de autonomía. El sistema institucional de las Comunidades Autónomas. La Administración Local.',
        'Políticas de igualdad de género. La Ley Orgánica 3/2007, de 22 de marzo, para la igualdad efectiva de mujeres y hombres. Políticas contra la violencia de género. La Ley Orgánica 1/2004, de 28 de diciembre, de Medidas de Protección Integral contra la Violencia de Género. Políticas dirigidas a la atención de personas discapacitadas y/o dependientes: la Ley 39/2006, de 14 de diciembre, de Promoción de la Autonomía Personal y atención a las personas en situación de dependencia.',
        'La gobernanza pública y el gobierno abierto. Concepto y principios informadores del gobierno abierto: colaboración, participación, transparencia y rendición de cuentas. Datos abiertos y reutilización. El marco jurídico y los planes de gobierno abierto en España.'
    ]
};

/**
 * Quinto ejercicio: una lista plana de partes con PDF o no disponible.
 * Cada parte lleva además sus temas, que apuntan al PDF de la parte completa.
 */
function parsearQuinto(html) {
    const partes = [];
    const itemRe = /<div class="tema-item">\s*<a href="([^"]+)"[^>]*>([\s\S]*?)<\/a>\s*<\/div>/g;
    let it;
    while ((it = itemRe.exec(html)) !== null) {
        const href = it[1];
        const texto = limpiarTexto(it[2]);                         // "Parte A: Marketing internacional..."
        const letra = (texto.match(/Parte ([A-Z])/) || [])[1] || '';
        const disponible = !/tema-no-disponible\.html/.test(href);
        const url = disponible ? `${BASE_URL}/oposicion/temario/${href}` : null;
        partes.push({
            letra,
            nombre: texto.replace(/^Parte [A-Z]:\s*/, ''),
            disponible,
            url,
            temas: (TEMAS_QUINTO[letra] || []).map((titulo, i) => ({
                codigo: `5.${letra}.${i + 1}`,
                titulo,
                disponible,
                temarioAnterior: false,
                url,
                pdfDeParte: true
            }))
        });
    }
    return partes;
}

function construirTemario() {
    const ejercicios = EJERCICIOS.map(ej => {
        const html = leer(`oposicion/temario/${ej.slug}.html`);
        const base = {
            id: ej.id,
            slug: ej.slug,
            nombre: ej.nombre,
            descripcion: ej.descripcion,
            urlPagina: `${BASE_URL}/oposicion/temario/${ej.slug}.html`,
            partes: []
        };
        if (ej.tipo === 'temas') base.partes = parsearEjercicioConTemas(html, ej.slug);
        if (ej.tipo === 'partes') base.partes = parsearQuinto(html);
        if (ej.id === 1) {
            base.recursos = [
                { id: 'simulador', titulo: 'Simulador de test', tipo: 'app', url: `${BASE_URL}/oposicion/temario/primer-ejercicio/test/simulador.html` },
                { id: 'examenes', titulo: 'Exámenes oficiales de test (PDF, 11 MB)', tipo: 'pdf', url: `${BASE_URL}/oposicion/temario/primer-ejercicio/test/examenes_oficiales_test.pdf` },
                { id: 'examenes-dictamen', titulo: 'Exámenes oficiales del dictamen (PDF, 7 MB)', tipo: 'pdf', url: `${BASE_URL}/oposicion/temario/primer-ejercicio/examenes_oficiales_dictamen.pdf` },
                { id: 'plantillas', titulo: 'Plantillas para practicar test', tipo: 'pdf', url: `${BASE_URL}/oposicion/temario/primer-ejercicio/test/plantillas_para_practicar_test.pdf` },
                { id: 'dictamen', titulo: 'Esquema del dictamen económico', tipo: 'pdf', url: `${BASE_URL}/oposicion/temario/primer-ejercicio/esquema_dictamen_economico.pdf` },
                { id: 'dictamen-docx', titulo: 'Esquema del dictamen económico 2025 (Word)', tipo: 'docx', url: `${BASE_URL}/oposicion/temario/primer-ejercicio/esquema_dictamen_economico_2025.docx` }
            ];
        }
        return base;
    });

    const organizacion = [
        { id: 'excel', titulo: 'Estrategia y organización (Excel)', descripcion: 'Probabilidades de que caiga un tema estudiado, simulador de sorteos y base para cronogramas.', tipo: 'xlsm', url: `${BASE_URL}/oposicion/organizacion/preparacion_oposicion_tcee.xlsm` },
        { id: 'estructura', titulo: 'Estructura del temario', descripcion: 'Presentación con una propuesta de estructura de los temas del tercer y cuarto ejercicio.', tipo: 'pdf', url: `${BASE_URL}/oposicion/organizacion/estructura_temario.pdf` },
        { id: 'cantar', titulo: 'Cómo cantar un tema', descripcion: 'Formato, organización de conceptos y consejos para la exposición oral.', tipo: 'pdf', url: `${BASE_URL}/oposicion/organizacion/como_cantar_un_tema.pdf` },
        { id: 'convocatoria', titulo: 'Convocatoria (BOE)', descripcion: 'Texto de la última convocatoria publicada en el BOE.', tipo: 'pdf', url: `${BASE_URL}/oposicion/organizacion/OEP2025TECOS_Convocatoria_BOE.pdf` },
        { id: 'plantilla-largos', titulo: 'Plantilla Word para temas largos', descripcion: '', tipo: 'dotx', url: `${BASE_URL}/oposicion/organizacion/1_plantilla_temas_largos.dotx` },
        { id: 'plantilla-cortos', titulo: 'Plantilla Word para temas cortos', descripcion: '', tipo: 'dotx', url: `${BASE_URL}/oposicion/organizacion/2_plantilla_temas_cortos.dotx` }
    ];

    const totalTemas = ejercicios.reduce((n, e) => n + e.partes.reduce((m, p) => m + p.temas.length, 0), 0);
    const disponibles = ejercicios.reduce((n, e) => n + e.partes.reduce((m, p) => m + p.temas.filter(t => t.disponible).length, 0), 0);

    return {
        version: 1,
        resumen: { totalTemas, temasDisponibles: disponibles },
        ejercicios,
        organizacion
    };
}

// ---------------------------------------------------------------------------
// Enlaces
// ---------------------------------------------------------------------------

function construirEnlaces() {
    const html = leer('oposicion/enlaces.html');
    const categorias = [];
    const seccionRe = /<h3>([^<]+)<\/h3>\s*<ul[^>]*>([\s\S]*?)<\/ul>/g;
    let s;
    while ((s = seccionRe.exec(html)) !== null) {
        const enlaces = [];
        const aRe = /<a href="([^"]+)"[^>]*>([^<]+)<\/a>/g;
        let a;
        while ((a = aRe.exec(s[2])) !== null) {
            enlaces.push({ titulo: limpiarTexto(a[2]), url: a[1] });
        }
        categorias.push({ nombre: limpiarTexto(s[1]), enlaces });
    }

    // Otras webs de opositores enlazadas desde oposicion/index.html
    const indexHtml = leer('oposicion/index.html');
    const otras = [];
    const otrasRe = /<a href="(https?:\/\/[^"]+)"[^>]*>([^<]+)<\/a>/g;
    let o;
    while ((o = otrasRe.exec(indexHtml)) !== null) {
        const url = o[1];
        if (/linkedin|x\.com|github|officeapps|fonts\.g|googletagmanager|victorgutierrezmarcos/.test(url)) continue;
        otras.push({ titulo: limpiarTexto(o[2]), url });
    }
    if (otras.length) categorias.push({ nombre: 'Otras webs de opositores', enlaces: otras });

    return { version: 1, categorias };
}

// ---------------------------------------------------------------------------

function escribir(rel, obj) {
    const destino = path.join(ROOT, rel);
    fs.writeFileSync(destino, JSON.stringify(obj, null, 2) + '\n', 'utf8');
    console.log(`✔ ${rel}`);
}

const temario = construirTemario();
escribir('oposicion/temario/temario.json', temario);
console.log(`  ${temario.resumen.totalTemas} temas (${temario.resumen.temasDisponibles} con PDF)`);

const enlaces = construirEnlaces();
escribir('oposicion/enlaces.json', enlaces);
console.log(`  ${enlaces.categorias.length} categorías de enlaces`);
