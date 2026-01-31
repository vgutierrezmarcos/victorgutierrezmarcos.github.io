/**
 * Script para generar sitemap.xml automáticamente
 * Escanea los archivos HTML del sitio y genera un sitemap válido
 * Autor: Víctor Gutiérrez Marcos
 */

const fs = require('fs');
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
    'oposicion/organizacion.html': { priority: '0.8', changefreq: 'monthly' },
    'oposicion/enlaces.html': { priority: '0.8', changefreq: 'monthly' },
    'blog/index.html': { priority: '0.8', changefreq: 'weekly' },
};

// Directorios y archivos a excluir
const EXCLUDE_PATTERNS = [
    /^blog\/newsletter\//,
    /^blog\/templates\//,
    /^blog\/.*_files\//,
    /^\.github\//,
    /^node_modules\//,
    /404\.html$/,
    /tema-no-disponible\.html$/,
];

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
        } else if (entry.name.endsWith('.html') && !shouldExclude(relativePath)) {
            results.push(relativePath);
        }
    }

    return results;
}

function getLastModDate(filePath) {
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

function generateSitemap() {
    const htmlFiles = getHtmlFiles(ROOT_DIR, ROOT_DIR);

    // Ordenar: principales primero, luego oposición, luego blog
    htmlFiles.sort((a, b) => {
        const order = (f) => {
            if (f === 'index.html') return 0;
            if (!f.includes('/')) return 1;
            if (f.startsWith('oposicion/')) return 2;
            if (f.startsWith('blog/')) return 3;
            return 4;
        };
        return order(a) - order(b) || a.localeCompare(b);
    });

    let xml = '<?xml version="1.0" encoding="UTF-8"?>\n';
    xml += '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n';

    for (const file of htmlFiles) {
        const url = fileToUrl(file);
        const fullPath = path.join(ROOT_DIR, file);
        const lastmod = getLastModDate(fullPath);

        const config = PAGE_CONFIG[file] || {};
        const priority = config.priority || (file.startsWith('blog/') && file !== 'blog/index.html' ? '0.6' : '0.7');
        const changefreq = config.changefreq || (file.startsWith('blog/') && file !== 'blog/index.html' ? 'yearly' : 'monthly');

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
