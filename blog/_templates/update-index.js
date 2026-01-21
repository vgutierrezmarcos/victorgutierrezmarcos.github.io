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
var slug = fso.GetBaseName(qmdFile);

// Read qmd file
function readFile(path) {
    var stream = new ActiveXObject("ADODB.Stream");
    stream.CharSet = "utf-8";
    stream.Open();
    stream.LoadFromFile(path);
    var text = stream.ReadText();
    stream.Close();
    return text;
}

// Write file
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

    var fechaLegible = formatDate(date);
    var fechaISO = date;

    // Read index
    var index = readFile(indexFile);

    // Check if already exists
    if (index.indexOf(slug + ".html") !== -1) {
        WScript.Echo("  El articulo ya existe en el indice");
        WScript.Quit(0);
    }

    // Create article HTML
    var articleHtml = '\n' +
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
'                            <a href="' + slug + '.html" class="read-more">Leer articulo</a>\n' +
'                            <a href="' + slug + '.pdf" class="download-pdf" download>\n' +
'                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">\n' +
'                                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>\n' +
'                                    <polyline points="7 10 12 15 17 10"/>\n' +
'                                    <line x1="12" y1="15" x2="12" y2="3"/>\n' +
'                                </svg>\n' +
'                                PDF\n' +
'                            </a>\n' +
'                        </div>\n' +
'                    </article>\n';

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
    endMarker += 3;

    index = index.substring(0, endMarker) + articleHtml + index.substring(endMarker);

    // Save
    writeFile(indexFile, index);
    WScript.Echo("  Indice actualizado correctamente");

} catch (e) {
    WScript.Echo("  Error: " + e.message);
    WScript.Quit(1);
}
