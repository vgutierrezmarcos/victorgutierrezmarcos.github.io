const fs = require('fs');
const path = require('path');

// Configuration
const BLOG_DIR = path.join(__dirname, 'blog');
const OUTPUT_FILE = path.join(__dirname, 'rss.xml');
const SITE_URL = 'https://www.victorgutierrezmarcos.es';
const BLOG_URL = `${SITE_URL}/blog`;

// Helper to escape XML special characters
function escapeXml(unsafe) {
    if (!unsafe) return '';
    return unsafe.replace(/[<>&'"]/g, function (c) {
        switch (c) {
            case '<': return '&lt;';
            case '>': return '&gt;';
            case '&': return '&amp;';
            case '\'': return '&apos;';
            case '"': return '&quot;';
        }
    });
}

// Function to parse date from filename or content (placeholder logic)
// Assuming standard blog post format or file stats
function getPostMetadata(filePath) {
    const content = fs.readFileSync(filePath, 'utf8');
    const filename = path.basename(filePath);
    
    // Extract title
    const titleMatch = content.match(/<title>([^<]+)<\/title>/);
    let title = titleMatch ? titleMatch[1].replace(' | Víctor Gutiérrez Marcos', '') : filename;
    
    // Extract description
    const descMatch = content.match(/<meta name="description" content="([^"]+)">/);
    let description = descMatch ? descMatch[1] : '';

    // Extract date (Trying to find a date in the content or use file mtime)
    // Looking for <time datetime="YYYY-MM-DD"> format if exists
    const dateMatch = content.match(/<time[^>]*datetime="([^"]+)"[^>]*>/);
    let dateStr = dateMatch ? dateMatch[1] : null;
    
    let date;
    if (dateStr) {
        date = new Date(dateStr);
    } else {
        const stats = fs.statSync(filePath);
        date = stats.birthtime; // Creation time
    }

    return {
        title,
        description,
        date,
        url: `${BLOG_URL}/${filename}` // Flat structure assumption inside blog/
    };
}

function generateRSS() {
    console.log('Generando RSS feed...');
    
    let items = [];

    // Scan for HTML files in blog directory (excluding index.html and templates)
    // We assume posts are directly in blog/ or specific subfolders. 
    // Based on previous ls, there are no posts yet, only index and templates.
    // I will scan top level blog folder for now.
    
    if (fs.existsSync(BLOG_DIR)) {
        const files = fs.readdirSync(BLOG_DIR);
        
        files.forEach(file => {
            if (file.endsWith('.html') && file !== 'index.html') {
                const filePath = path.join(BLOG_DIR, file);
                try {
                    const meta = getPostMetadata(filePath);
                    items.push(meta);
                } catch (e) {
                    console.error(`Error processing ${file}:`, e);
                }
            }
        });
    }

    // Sort by date descending
    items.sort((a, b) => b.date - a.date);

    const rssContent = `<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
    <title>Víctor Gutiérrez Marcos - Blog</title>
    <link>${BLOG_URL}</link>
    <description>Artículos y análisis sobre economía, política económica y comercio internacional.</description>
    <language>es</language>
    <lastBuildDate>${new Date().toUTCString()}</lastBuildDate>
    <atom:link href="${SITE_URL}/rss.xml" rel="self" type="application/rss+xml" />
    ${items.map(item => `
    <item>
        <title>${escapeXml(item.title)}</title>
        <link>${item.url}</link>
        <guid>${item.url}</guid>
        <pubDate>${item.date.toUTCString()}</pubDate>
        <description>${escapeXml(item.description)}</description>
    </item>`).join('')}
</channel>
</rss>`;

    fs.writeFileSync(OUTPUT_FILE, rssContent);
    console.log(`RSS feed generado en ${OUTPUT_FILE} con ${items.length} artículos.`);
}

generateRSS();
