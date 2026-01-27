/**
 * Script para enviar newsletter automática cuando se publica un nuevo artículo
 * Utiliza la API de Brevo (antes Sendinblue) para enviar emails a los suscriptores
 */

const fs = require('fs');
const path = require('path');
const https = require('https');

// Configuración
const BLOG_DIR = path.join(__dirname, 'blog');
const PUBLISHED_ARTICLES_FILE = path.join(__dirname, 'blog', 'newsletter', 'published-articles.json');
const SITE_URL = 'https://www.victorgutierrezmarcos.es';

// Lista de Brevo donde están los suscriptores (se configura en Brevo)
// El ID de la lista se debe obtener desde Brevo Dashboard > Contacts > Lists
const BREVO_LIST_ID = parseInt(process.env.BREVO_LIST_ID) || 2; // Lista por defecto

// Helper para extraer frontmatter YAML
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
            if ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'"))) {
                value = value.slice(1, -1);
            }
            metadata[key] = value;
        }
    }

    return metadata;
}

// Obtener todos los artículos actuales (solo los que tienen HTML renderizado)
function getCurrentArticles() {
    const files = fs.readdirSync(BLOG_DIR).filter(file => file.endsWith('.qmd') && !file.startsWith('_'));
    const articles = [];

    for (const file of files) {
        const content = fs.readFileSync(path.join(BLOG_DIR, file), 'utf8');
        const metadata = parseFrontmatter(content);

        if (metadata && metadata.title && metadata.date && metadata.slug) {
            // Solo incluir si el HTML renderizado existe
            const htmlFile = path.join(BLOG_DIR, `${metadata.slug}.html`);
            if (!fs.existsSync(htmlFile)) {
                console.log(`  Skipping "${metadata.title}" - HTML not rendered yet`);
                continue;
            }

            articles.push({
                slug: metadata.slug,
                title: metadata.title,
                date: metadata.date,
                description: metadata.description || '',
                url: `${SITE_URL}/blog/${metadata.slug}.html`
            });
        }
    }

    return articles;
}

// Cargar artículos ya publicados (para detectar nuevos)
function loadPublishedArticles() {
    try {
        if (fs.existsSync(PUBLISHED_ARTICLES_FILE)) {
            const data = fs.readFileSync(PUBLISHED_ARTICLES_FILE, 'utf8');
            return JSON.parse(data);
        }
    } catch (error) {
        console.log('No se encontró archivo de artículos publicados. Se creará uno nuevo.');
    }
    return { articles: [] };
}

// Guardar artículos publicados
function savePublishedArticles(data) {
    const dir = path.dirname(PUBLISHED_ARTICLES_FILE);
    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
    }
    fs.writeFileSync(PUBLISHED_ARTICLES_FILE, JSON.stringify(data, null, 2));
}

// Formatear fecha para mostrar en el email
function formatDate(dateString) {
    const date = new Date(dateString);
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return date.toLocaleDateString('es-ES', options);
}

// Enviar campaña de email via Brevo API
async function sendBrevoNewsletter(article) {
    const apiKey = process.env.BREVO_API_KEY;

    if (!apiKey) {
        console.error('ERROR: BREVO_API_KEY no está configurada');
        console.log('Para configurar, añade el secreto BREVO_API_KEY en GitHub Settings > Secrets');
        process.exit(1);
    }

    // Crear campaña de email
    const campaignData = {
        name: `Nuevo artículo: ${article.title}`,
        subject: `Nuevo artículo: ${article.title}`,
        sender: {
            name: 'Víctor Gutiérrez Marcos',
            email: 'newsletter@victorgutierrezmarcos.es'
        },
        type: 'classic',
        // HTML del email con los parámetros del artículo
        htmlContent: generateEmailHTML(article),
        recipients: {
            listIds: [BREVO_LIST_ID]
        },
        // Enviar inmediatamente
        scheduledAt: new Date().toISOString()
    };

    return new Promise((resolve, reject) => {
        const postData = JSON.stringify(campaignData);

        const options = {
            hostname: 'api.brevo.com',
            port: 443,
            path: '/v3/emailCampaigns',
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'api-key': apiKey,
                'Content-Length': Buffer.byteLength(postData)
            }
        };

        const req = https.request(options, (res) => {
            let data = '';
            res.on('data', chunk => data += chunk);
            res.on('end', () => {
                if (res.statusCode === 201) {
                    const result = JSON.parse(data);
                    console.log(`Campaña creada con ID: ${result.id}`);

                    // Enviar la campaña inmediatamente
                    sendCampaignNow(result.id, apiKey)
                        .then(resolve)
                        .catch(reject);
                } else {
                    console.error(`Error al crear campaña: ${res.statusCode}`);
                    console.error(data);
                    reject(new Error(`HTTP ${res.statusCode}: ${data}`));
                }
            });
        });

        req.on('error', reject);
        req.write(postData);
        req.end();
    });
}

// Enviar campaña inmediatamente
function sendCampaignNow(campaignId, apiKey) {
    return new Promise((resolve, reject) => {
        const options = {
            hostname: 'api.brevo.com',
            port: 443,
            path: `/v3/emailCampaigns/${campaignId}/sendNow`,
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'api-key': apiKey
            }
        };

        const req = https.request(options, (res) => {
            let data = '';
            res.on('data', chunk => data += chunk);
            res.on('end', () => {
                if (res.statusCode === 204 || res.statusCode === 200) {
                    console.log('Campaña enviada correctamente');
                    resolve();
                } else {
                    console.error(`Error al enviar campaña: ${res.statusCode}`);
                    console.error(data);
                    reject(new Error(`HTTP ${res.statusCode}: ${data}`));
                }
            });
        });

        req.on('error', reject);
        req.end();
    });
}

// Generar HTML del email
function generateEmailHTML(article) {
    return `<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Nuevo artículo | Víctor Gutiérrez Marcos</title>
</head>
<body style="margin:0;padding:0;background-color:#E2EFD9;font-family:'Palatino Linotype',Palatino,Georgia,serif;">
  <center style="width:100%;table-layout:fixed;background-color:#E2EFD9;padding:40px 0;">
    <table width="600" align="center" style="background-color:#ffffff;margin:0 auto;width:100%;max-width:600px;border-spacing:0;font-family:'Palatino Linotype',Palatino,Georgia,serif;color:#2d2d2d;border-radius:8px;overflow:hidden;box-shadow:0 4px 12px rgba(0,0,0,0.1);border:1px solid #c8d8c0;">
      <!-- HEADER -->
      <tr>
        <td bgcolor="#5F2987" style="background:linear-gradient(135deg,#5F2987 0%,#4a1f6b 100%);padding:35px 30px;text-align:center;border-bottom:4px solid #b8860b;">
          <h1 style="margin:0;font-family:'Palatino Linotype',Palatino,Georgia,serif;font-size:26px;font-weight:600;color:#ffffff;text-shadow:0 2px 4px rgba(0,0,0,0.2);letter-spacing:0.02em;">
            Víctor Gutiérrez Marcos
          </h1>
          <p style="margin:8px 0 0 0;font-family:'Palatino Linotype',Palatino,Georgia,serif;font-size:15px;color:rgba(255,255,255,0.9);font-style:italic;">
            Análisis sobre política económica y comercio internacional
          </p>
        </td>
      </tr>

      <!-- INTRO -->
      <tr>
        <td style="padding:35px 40px 20px 40px;text-align:center;background-color:#ffffff;">
          <p style="font-family:'Palatino Linotype',Palatino,Georgia,serif;font-size:16px;line-height:1.6;color:#555555;margin:0;">
            Se ha publicado un nuevo artículo en el blog:
          </p>
        </td>
      </tr>

      <!-- ARTICLE CARD -->
      <tr>
        <td style="padding:0 40px 35px 40px;">
          <table width="100%" cellspacing="0" cellpadding="0" style="background:linear-gradient(135deg,#f8f4fb 0%,#f3eef7 100%);border-radius:8px;border-left:4px solid #5F2987;overflow:hidden;">
            <tr>
              <td style="padding:25px 30px;">
                <h2 style="color:#5F2987;font-family:'Palatino Linotype',Palatino,Georgia,serif;margin:0 0 15px 0;font-size:22px;font-weight:600;line-height:1.3;">
                  ${escapeHtml(article.title)}
                </h2>
                <p style="font-family:Helvetica,Arial,sans-serif;font-size:13px;color:#888888;margin:0 0 15px 0;text-transform:uppercase;letter-spacing:0.5px;">
                  ${formatDate(article.date)}
                </p>
                <p style="font-family:'Palatino Linotype',Palatino,Georgia,serif;font-size:15px;line-height:1.7;color:#2d2d2d;margin:0 0 25px 0;">
                  ${escapeHtml(article.description)}
                </p>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td>
                      <a href="${article.url}" target="_blank" style="background-color:#5F2987;border:1px solid #5F2987;border-radius:6px;padding:14px 28px;color:#ffffff;text-decoration:none;font-weight:600;display:inline-block;font-family:Helvetica,Arial,sans-serif;font-size:14px;text-transform:uppercase;letter-spacing:0.5px;box-shadow:0 4px 6px rgba(95,41,135,0.2);">
                        Leer artículo completo
                      </a>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>

      <!-- SEPARATOR -->
      <tr>
        <td style="padding:0 40px;">
          <table width="100%" cellspacing="0" cellpadding="0">
            <tr>
              <td style="border-bottom:1px solid #e0e0e0;"></td>
            </tr>
          </table>
        </td>
      </tr>

      <!-- ADDITIONAL INFO -->
      <tr>
        <td style="padding:30px 40px;text-align:center;background-color:#ffffff;">
          <p style="font-family:'Palatino Linotype',Palatino,Georgia,serif;font-size:14px;line-height:1.6;color:#777777;margin:0;font-style:italic;">
            Si tienes algún comentario o sugerencia sobre este artículo, no dudes en responder a este correo.
          </p>
        </td>
      </tr>

      <!-- FOOTER -->
      <tr>
        <td bgcolor="#4a1f6b" style="background-color:#4a1f6b;padding:25px;text-align:center;border-top:1px solid #b8860b;">
          <p style="margin:0 0 10px 0;font-family:Helvetica,Arial,sans-serif;font-size:12px;color:rgba(255,255,255,0.8);">
            © 2026 Víctor Gutiérrez Marcos
          </p>
          <p style="margin:0 0 15px 0;font-family:Helvetica,Arial,sans-serif;font-size:12px;">
            <a href="https://www.victorgutierrezmarcos.es" style="color:#ffffff;text-decoration:none;border-bottom:1px solid rgba(255,255,255,0.3);">www.victorgutierrezmarcos.es</a>
          </p>
          <p style="margin:0;font-family:Helvetica,Arial,sans-serif;font-size:11px;color:rgba(255,255,255,0.6);">
            <a href="{{ unsubscribe }}" style="color:rgba(255,255,255,0.6);text-decoration:underline;">Cancelar suscripción</a>
          </p>
        </td>
      </tr>
    </table>
  </center>
</body>
</html>`;
}

// Escapar HTML para evitar inyección
function escapeHtml(text) {
    const map = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#039;'
    };
    return text.replace(/[&<>"']/g, m => map[m]);
}

// Función principal
async function main() {
    console.log('=== Newsletter Automática ===\n');

    // Obtener artículos actuales
    const currentArticles = getCurrentArticles();
    console.log(`Artículos encontrados: ${currentArticles.length}`);

    // Cargar registro de artículos ya publicados
    const publishedData = loadPublishedArticles();
    const publishedSlugs = new Set(publishedData.articles.map(a => a.slug));
    console.log(`Artículos previamente publicados: ${publishedSlugs.size}`);

    // Detectar nuevos artículos
    const newArticles = currentArticles.filter(article => !publishedSlugs.has(article.slug));

    if (newArticles.length === 0) {
        console.log('\nNo hay artículos nuevos. No se enviará newsletter.');
        // Aún así, actualizamos el registro por si hay cambios
        savePublishedArticles({ articles: currentArticles, lastUpdate: new Date().toISOString() });
        return;
    }

    console.log(`\nNuevos artículos detectados: ${newArticles.length}`);
    newArticles.forEach(a => console.log(`  - ${a.title}`));

    // Enviar newsletter para cada nuevo artículo
    for (const article of newArticles) {
        console.log(`\nEnviando newsletter para: "${article.title}"...`);
        try {
            await sendBrevoNewsletter(article);
            console.log('Newsletter enviada correctamente.');
        } catch (error) {
            console.error(`Error al enviar newsletter: ${error.message}`);
            // No hacemos exit para permitir procesar otros artículos
        }
    }

    // Actualizar registro de artículos publicados
    savePublishedArticles({
        articles: currentArticles,
        lastUpdate: new Date().toISOString()
    });
    console.log('\nRegistro de artículos actualizado.');
}

// Ejecutar
main().catch(error => {
    console.error('Error fatal:', error);
    process.exit(1);
});
