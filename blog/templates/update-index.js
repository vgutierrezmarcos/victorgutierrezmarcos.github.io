// Update blog index with new article
// Usage: cscript //nologo update-index.js article.qmd

var fso = new ActiveXObject("Scripting.FileSystemObject");
var args = WScript.Arguments;

if (args.length < 1) {
    WScript.Echo("Uso: cscript //nologo update-index.js articulo.qmd");
    WScript.Quit(1);
}

var qmdFile = args(0);
var scriptDir = fso.GetParentFolderName(WScript.ScriptFullName);
var blogDir = fso.GetParentFolderName(scriptDir);
var indexFile = fso.BuildPath(blogDir, "index.html");
var imagesDir = fso.BuildPath(blogDir, "images");
var slug = fso.GetBaseName(qmdFile);
var htmlFile = fso.BuildPath(blogDir, slug + ".html");

// Read file with UTF-8
function readFile(path) {
    var stream = new ActiveXObject("ADODB.Stream");
    stream.CharSet = "utf-8";
    stream.Open();
    stream.LoadFromFile(path);
    var text = stream.ReadText();
    stream.Close();
    return text;
}

// Write file with UTF-8
function writeFile(path, content) {
    var stream = new ActiveXObject("ADODB.Stream");
    stream.CharSet = "utf-8";
    stream.Open();
    stream.WriteText(content);
    stream.SaveToFile(path, 2); // 2 = overwrite
    stream.Close();
}

// Trim polyfill for JScript
function trim(str) {
    return str.replace(/^\s+|\s+$/g, "");
}

// Extract YAML value
function getYamlValue(yaml, key) {
    var regex = new RegExp("^" + key + ":\\s*[\"']?([^\"'\\r\\n]+)[\"']?", "m");
    var match = yaml.match(regex);
    return match ? trim(match[1]) : "";
}

// Format date in Spanish
function formatDate(dateStr) {
    var meses = ["enero","febrero","marzo","abril","mayo","junio","julio","agosto","septiembre","octubre","noviembre","diciembre"];
    var parts = dateStr.split("-");
    if (parts.length === 3) {
        var day = parseInt(parts[2], 10);
        var month = parseInt(parts[1], 10) - 1;
        var year = parts[0];
        return day + " de " + meses[month] + " de " + year;
    }
    return dateStr;
}

// Extract first image from HTML content
function extractFirstImage(htmlContent) {
    // Look for <img> tags in the article body
    // Skip logos and icons (small images, SVGs, favicons)
    var imgRegex = /<img[^>]+src=["']([^"']+)["'][^>]*(?:alt=["']([^"']*)["'])?[^>]*>/gi;
    var match;

    while ((match = imgRegex.exec(htmlContent)) !== null) {
        var src = match[1];
        var alt = match[2] || "";

        // Skip data URIs, SVGs, favicons, logos
        if (src.indexOf("data:") === 0) continue;
        if (src.indexOf(".svg") !== -1) continue;
        if (src.indexOf("favicon") !== -1) continue;
        if (src.indexOf("logo") !== -1) continue;
        if (src.indexOf("apple-touch") !== -1) continue;

        // Found a valid image
        return { src: src, alt: alt };
    }

    return null;
}

// Copy image to blog/images folder and return new path
function copyImageToImagesFolder(imageSrc, slug) {
    // If image is already in images folder, return as is
    if (imageSrc.indexOf("images/") === 0) {
        return imageSrc;
    }

    // Get filename from src
    var srcParts = imageSrc.split("/");
    var filename = srcParts[srcParts.length - 1];

    // Remove query strings if any
    if (filename.indexOf("?") !== -1) {
        filename = filename.split("?")[0];
    }

    // Create new filename with slug prefix to avoid conflicts
    var ext = "";
    var dotPos = filename.lastIndexOf(".");
    if (dotPos !== -1) {
        ext = filename.substring(dotPos);
        filename = slug + "-featured" + ext;
    } else {
        filename = slug + "-featured.png";
    }

    var newPath = "images/" + filename;
    var destPath = fso.BuildPath(imagesDir, filename);

    // Try to copy the file if it exists locally
    try {
        // Handle relative paths - the image might be embedded or in a subfolder
        var sourcePath = fso.BuildPath(blogDir, imageSrc);
        if (fso.FileExists(sourcePath)) {
            // Ensure images directory exists
            if (!fso.FolderExists(imagesDir)) {
                fso.CreateFolder(imagesDir);
            }
            fso.CopyFile(sourcePath, destPath, true);
            return newPath;
        }
    } catch (e) {
        // If copy fails, just use original path
    }

    return imageSrc;
}

try {
    var content = readFile(qmdFile);

    // Extract YAML
    var yamlMatch = content.match(/^---\r?\n([\s\S]+?)\r?\n---/);
    if (!yamlMatch) {
        WScript.Echo("  Error: No se encontro YAML en el archivo");
        WScript.Quit(1);
    }
    var yaml = yamlMatch[1];

    // Parse values
    var title = getYamlValue(yaml, "title");
    var date = getYamlValue(yaml, "date");
    var categoria = getYamlValue(yaml, "categoria");
    var description = getYamlValue(yaml, "description");
    if (!description) description = getYamlValue(yaml, "subtitle");

    // Check for explicit image in YAML
    var yamlImage = getYamlValue(yaml, "image");
    var yamlImageAlt = getYamlValue(yaml, "image-alt");
    var yamlImageCaption = getYamlValue(yaml, "image-caption");

    var fechaLegible = formatDate(date);
    var fechaISO = date;

    // Read index
    var index = readFile(indexFile);

    // Check if already exists
    if (index.indexOf(slug + ".html") !== -1) {
        WScript.Echo("  El articulo ya existe en el indice");
        WScript.Quit(0);
    }

    // Try to find an image
    var imageInfo = null;

    // First, check YAML for explicit image
    if (yamlImage) {
        imageInfo = { src: yamlImage, alt: yamlImageAlt || title, caption: yamlImageCaption };
    }
    // Then, try to extract from rendered HTML
    else if (fso.FileExists(htmlFile)) {
        var htmlContent = readFile(htmlFile);
        var extracted = extractFirstImage(htmlContent);
        if (extracted) {
            // Copy image to images folder
            var newSrc = copyImageToImagesFolder(extracted.src, slug);
            imageInfo = { src: newSrc, alt: extracted.alt || title, caption: "" };
        }
    }

    // Create article HTML
    var articleHtml;

    if (imageInfo && imageInfo.src) {
        // Article with image
        var captionHtml = imageInfo.caption ? '\n                            <figcaption>' + imageInfo.caption + '</figcaption>' : '';

        articleHtml = '\n' +
'                    <article class="article-card has-image">\n' +
'                        <figure class="article-card-image">\n' +
'                            <a href="' + slug + '.html">\n' +
'                                <img src="' + imageInfo.src + '" alt="' + imageInfo.alt + '">\n' +
'                            </a>' + captionHtml + '\n' +
'                        </figure>\n' +
'                        <div class="article-card-body">\n' +
'                            <div class="article-meta">\n' +
'                                <time datetime="' + fechaISO + '">' + fechaLegible + '</time>\n' +
'                                <span class="article-category">' + categoria + '</span>\n' +
'                            </div>\n' +
'                            <h3 class="article-title">\n' +
'                                <a href="' + slug + '.html">' + title + '</a>\n' +
'                            </h3>\n' +
'                            <p class="article-excerpt">\n' +
'                                ' + description + '\n' +
'                            </p>\n' +
'                            <div class="article-actions">\n' +
'                                <a href="' + slug + '.html" class="read-more">Leer articulo →</a>\n' +
'                                <a href="' + slug + '.pdf" class="download-pdf" download>\n' +
'                                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">\n' +
'                                        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>\n' +
'                                        <polyline points="7 10 12 15 17 10"/>\n' +
'                                        <line x1="12" y1="15" x2="12" y2="3"/>\n' +
'                                    </svg>\n' +
'                                    PDF\n' +
'                                </a>\n' +
'                            </div>\n' +
'                        </div>\n' +
'                    </article>\n';

        WScript.Echo("  Imagen encontrada: " + imageInfo.src);
    } else {
        // Article without image
        articleHtml = '\n' +
'                    <article class="article-card">\n' +
'                        <div class="article-meta">\n' +
'                            <time datetime="' + fechaISO + '">' + fechaLegible + '</time>\n' +
'                            <span class="article-category">' + categoria + '</span>\n' +
'                        </div>\n' +
'                        <h3 class="article-title">\n' +
'                            <a href="' + slug + '.html">' + title + '</a>\n' +
'                        </h3>\n' +
'                        <p class="article-excerpt">\n' +
'                            ' + description + '\n' +
'                        </p>\n' +
'                        <div class="article-actions">\n' +
'                            <a href="' + slug + '.html" class="read-more">Leer articulo →</a>\n' +
'                            <a href="' + slug + '.pdf" class="download-pdf" download>\n' +
'                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">\n' +
'                                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>\n' +
'                                    <polyline points="7 10 12 15 17 10"/>\n' +
'                                    <line x1="12" y1="15" x2="12" y2="3"/>\n' +
'                                </svg>\n' +
'                                PDF\n' +
'                            </a>\n' +
'                        </div>\n' +
'                    </article>\n';
    }

    // Insert after marker
    var marker = "<!-- INICIO ART";
    var markerPos = index.indexOf(marker);
    if (markerPos === -1) {
        WScript.Echo("  Error: No se encontro el marcador en index.html");
        WScript.Quit(1);
    }

    var endMarker = index.indexOf("-->", markerPos);
    if (endMarker === -1) {
        WScript.Echo("  Error: Marcador mal formado");
        WScript.Quit(1);
    }

    // Find end of the comment block that contains templates
    var templateEnd = index.indexOf("<!-- FIN ARTÍCULOS -->", markerPos);
    if (templateEnd === -1) {
        templateEnd = index.indexOf("<!-- FIN ART", markerPos);
    }

    // Find the proper insertion point after any template comments
    var insertPos = endMarker + 3;
    var nextComment = index.indexOf("<!--", insertPos);

    // Skip over template comments if they exist right after the marker
    if (nextComment !== -1 && nextComment < templateEnd) {
        var commentEnd = index.indexOf("-->", nextComment);
        if (commentEnd !== -1 && commentEnd < templateEnd) {
            insertPos = commentEnd + 3;
        }
    }

    index = index.substring(0, insertPos) + articleHtml + index.substring(insertPos);

    // Save
    writeFile(indexFile, index);
    WScript.Echo("  Indice actualizado correctamente");

} catch (e) {
    WScript.Echo("  Error: " + e.message);
    WScript.Quit(1);
}
