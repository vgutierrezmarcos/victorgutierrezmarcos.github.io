/**
 * Script para generar sitemap.xml automáticamente
 * Escanea los archivos HTML del sitio y genera un sitemap válido
 * Autor: Víctor Gutiérrez Marcos
 */

const fs = require('fs');
const { execFileSync } = require('child_process');
const path = require('path');

const BASE_URL = 'https://www.victorgutierrezmarcos.es';
const ROOT_DIR = __dirname;

// Páginas con prioridades y frecuencias personalizadas
const PAGE_CONFIG = {
    'index.html': { priority: '1.0', changefreq: 'monthly' },
    'sobre-mi.html': { priority: '0.7', changefreq: 'yearly' },
    'comunidad.html': { priority: '0.7', changefreq: 'monthly' },
    'politica-cookies.html': { priority: '0.3', changefreq: 'yearly' },
    'oposicion/index.html': { priority: '0.9', changefreq: 'monthly' },
    'oposicion/temario.html': { priority: '0.9', changefreq: 'monthly' },
    'oposicion/por-que-tcee.html': { priority: '0.9', changefreq: 'monthly' },
    'oposicion/cifras.html': { priority: '0.8', changefreq: 'yearly' },
    'oposicion/organizacion.html': { priority: '0.8', changefreq: 'monthly' },
    'oposicion/enlaces.html': { priority: '0.8', changefreq: 'monthly' },
    'blog/index.html': { priority: '0.8', changefreq: 'weekly' },
    'app/index.html': { priority: '0.8', changefreq: 'monthly' },
};

// Directorios y archivos a excluir
const EXCLUDE_PATTERNS = [
    /^blog\/newsletter\//,
    /^blog\/templates\//,
    /^blog\/.*_files\//,
    /(^|\/)\./,   // carpetas ocultas (.github, .Rproj.user…)
    /^app\/.+\//,   // de la app móvil solo se publica su página (app/index.html)
    /^node_modules\//,
    /404\.html$/,
    /tema-no-disponible\.html$/,
    /^scripts\//,
    /^backup\//,
    /(^|\/)oculto\//,
    /^politica-cookies\.html$/,  // lleva noindex
    /^temario(\/|\.html$)/,      // páginas puente de direcciones antiguas
    /^(enlaces|organizacion)\.html$/,
    /^oposicion\/temario\/index\.html$/,  // página puente de /oposicion/temario/
    /^oposicion\/que-es-tcee\.html$/,   // página puente de la guía (ahora por-que-tcee.html)
    /^oposicion\/temario\/fuentes\//,   // fuentes LaTeX de los temas revisados (PDF de cada gráfico, etc.)
];

// Documentos que también van al sitemap (los temas en PDF son lo que más se busca)
const DOC_EXTENSIONS = ['.pdf'];
const DOC_DIRS = ['oposicion/'];

function shouldExclude(relativePath) {
    return EXCLUDE_PATTERNS.some(pattern => pattern.test(relativePath));
}

function getHtmlFiles(dir, base) {
    const results = [];
    const entries = fs.readdirSync(dir, { withFileTypes: true });

    for (const entry of entries) {
        const fullPath = path.join(dir, entry.name);
        const relativePath = path.relative(base, fullPath).replace(/\\/g, '/');

        if (entry.isDirectory()) {
            // Saltar directorios excluidos
            if (!shouldExclude(relativePath + '/')) {
                results.push(...getHtmlFiles(fullPath, base));
            }
        } else if (shouldExclude(relativePath)) {
            continue;
        } else if (entry.name.endsWith('.html')) {
            results.push(relativePath);
        } else if (DOC_EXTENSIONS.includes(path.extname(entry.name).toLowerCase()) && DOC_DIRS.some(d => relativePath.startsWith(d))) {
            results.push(relativePath);
        }
    }

    return results;
}

function getLastModDate(filePath) {
    // Fecha del último commit que tocó el fichero (en GitHub Actions la fecha de
    // modificación del disco es siempre la del checkout)
    try {
        const fecha = execFileSync('git', ['log', '-1', '--format=%cs', '--', filePath], { cwd: ROOT_DIR, encoding: 'utf-8' }).trim();
        if (fecha) return fecha;
    } catch { /* sin git: se usa la fecha del disco */ }
    try {
        const stats = fs.statSync(filePath);
        return stats.mtime.toISOString().split('T')[0];
    } catch {
        return new Date().toISOString().split('T')[0];
    }
}

function fileToUrl(relativePath) {
    // index.html -> directorio/
    if (relativePath === 'index.html') {
        return BASE_URL + '/';
    }
    if (relativePath.endsWith('/index.html')) {
        return BASE_URL + '/' + relativePath.replace(/\/index\.html$/, '/');
    }
    return BASE_URL + '/' + relativePath;
}

// PDF enlazados desde alguna página publicada: los que no se enlazan (temas aún no
// disponibles, borradores) no se anuncian en el sitemap
function pdfsEnlazados(paginas) {
    const enlazados = new Set();
    for (const pagina of paginas) {
        const html = fs.readFileSync(path.join(ROOT_DIR, pagina), 'utf-8');
        for (const [, href] of html.matchAll(/href="([^"#?]+\.pdf)"/gi)) {
            if (/^[a-z]+:/i.test(href)) continue;
            if (/-anterior\.pdf$/i.test(href)) continue;   // versión anterior de un tema revisado: no se indexa
            const destino = href.startsWith('/') ? href.slice(1) : path.posix.join(path.posix.dirname(pagina), href);
            enlazados.add(path.posix.normalize(decodeURIComponent(destino)));
        }
    }
    return enlazados;
}

function generateSitemap() {
    const todos = getHtmlFiles(ROOT_DIR, ROOT_DIR);
    const enlazados = pdfsEnlazados(todos.filter(f => f.endsWith('.html')));
    const htmlFiles = todos.filter(f => f.endsWith('.html') || enlazados.has(f));

    // Ordenar: principales primero, luego oposición, luego blog
    htmlFiles.sort((a, b) => {
        const order = (f) => {
            if (f === 'index.html') return 0;
            if (!f.includes('/')) return 1;
            if (f.startsWith('oposicion/')) return 2;
            if (f.startsWith('blog/')) return 3;
            return 4;
        };
        const docs = (f) => (f.endsWith('.html') ? 0 : 1);
        return docs(a) - docs(b) || order(a) - order(b) || a.localeCompare(b);
    });

    let xml = '<?xml version="1.0" encoding="UTF-8"?>\n';
    xml += '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n';

    for (const file of htmlFiles) {
        const url = fileToUrl(file).split('/').map((p, i) => (i < 3 ? p : encodeURIComponent(p))).join('/');
        const fullPath = path.join(ROOT_DIR, file);
        const lastmod = getLastModDate(fullPath);

        const config = PAGE_CONFIG[file] || {};
        const esDoc = !file.endsWith('.html');
        const priority = config.priority || (esDoc ? '0.5' : file.startsWith('blog/') && file !== 'blog/index.html' ? '0.6' : '0.7');
        const changefreq = config.changefreq || (esDoc || (file.startsWith('blog/') && file !== 'blog/index.html') ? 'yearly' : 'monthly');

        xml += '  <url>\n';
        xml += `    <loc>${url}</loc>\n`;
        xml += `    <lastmod>${lastmod}</lastmod>\n`;
        xml += `    <changefreq>${changefreq}</changefreq>\n`;
        xml += `    <priority>${priority}</priority>\n`;
        xml += '  </url>\n';
    }

    xml += '</urlset>\n';

    const outputPath = path.join(ROOT_DIR, 'sitemap.xml');
    fs.writeFileSync(outputPath, xml, 'utf-8');
    console.log(`Sitemap generado: ${htmlFiles.length} URLs en sitemap.xml`);
}

generateSitemap();
