const fs = require('fs');
const path = require('path');

const BLOG_DIR = path.join(__dirname, 'blog');
const RSS_FILE = path.join(BLOG_DIR, 'newsletter', 'rss.xml');
const SITE_URL = 'https://www.victorgutierrezmarcos.es';

// Ensure newsletter directory exists
const newsletterDir = path.dirname(RSS_FILE);
if (!fs.existsSync(newsletterDir)) {
    fs.mkdirSync(newsletterDir, { recursive: true });
}

// Helper to extract YAML frontmatter
function parseFrontmatter(content) {
    const match = content.match(/^---\r?\n([\s\S]+?)\r?\n---/);
    if (!match) return null;
    
    const yaml = match[1];
    const metadata = {};
    
    const lines = yaml.split('\n');
    for (const line of lines) {
        const parts = line.split(':');
        if (parts.length >= 2) {
            const key = parts[0].trim();
            let value = parts.slice(1).join(':').trim();
            // Remove quotes if present
            if ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'"))) {
                value = value.slice(1, -1);
            }
            metadata[key] = value;
        }
    }
    
    return metadata;
}

// Helper to format date for RSS (RFC-822)
// Input: YYYY-MM-DD
function formatDateRFC822(dateString) {
    const date = new Date(dateString);
    return date.toUTCString();
}

function generateRSS() {
    console.log('Scanning for .qmd files in ' + BLOG_DIR);
    
    const files = fs.readdirSync(BLOG_DIR).filter(file => file.endsWith('.qmd') && !file.startsWith('_'));
    
    const posts = [];
    
    for (const file of files) {
        const content = fs.readFileSync(path.join(BLOG_DIR, file), 'utf8');
        const metadata = parseFrontmatter(content);
        
        if (metadata && metadata.title && metadata.date && metadata.slug) {
            posts.push({
                title: metadata.title,
                date: metadata.date, // Keep original for sorting
                description: metadata.description || '',
                slug: metadata.slug,
                link: `${SITE_URL}/blog/${metadata.slug}.html`
            });
        }
    }
    
    // Sort posts by date (newest first)
    posts.sort((a, b) => new Date(b.date) - new Date(a.date));
    
    console.log(`Found ${posts.length} posts.`);

    const rssItems = posts.map(post => `
    <item>
      <title><![CDATA[${post.title}]]></title>
      <link>${post.link}</link>
      <description><![CDATA[${post.description}]]></description>
      <pubDate>${formatDateRFC822(post.date)}</pubDate>
      <guid>${post.link}</guid>
    </item>`).join('');

    const rssContent = `<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0">
  <channel>
    <title>Blog | Víctor Gutiérrez Marcos</title>
    <link>${SITE_URL}/blog/</link>
    <description>Artículos y análisis sobre política económica y comercio internacional.</description>
    <language>es-es</language>
    <lastBuildDate>${new Date().toUTCString()}</lastBuildDate>
${rssItems}
  </channel>
</rss>`;

    fs.writeFileSync(RSS_FILE, rssContent);
    console.log(`RSS feed generated at ${RSS_FILE}`);
}

generateRSS();
