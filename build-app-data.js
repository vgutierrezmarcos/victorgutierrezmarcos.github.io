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
 * Quinto ejercicio: una lista plana de partes con PDF o no disponible.
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
        partes.push({
            letra,
            nombre: texto.replace(/^Parte [A-Z]:\s*/, ''),
            disponible,
            url: disponible ? `${BASE_URL}/oposicion/temario/${href}` : null,
            temas: []
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
                { id: 'examenes', titulo: 'Exámenes oficiales de test (PDF, 63 MB)', tipo: 'pdf', url: `${BASE_URL}/oposicion/temario/primer-ejercicio/test/examenes_oficiales_test.pdf` },
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
        { id: 'convocatoria', titulo: 'Convocatoria OEP 2025 (BOE)', descripcion: 'Texto de la convocatoria publicada en el BOE.', tipo: 'pdf', url: `${BASE_URL}/oposicion/organizacion/OEP2025TECOS_Convocatoria_BOE.pdf` },
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
