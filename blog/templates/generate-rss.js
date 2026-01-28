// Generate RSS feed for newsletter
// Usage: cscript //nologo generate-rss.js

var fso = new ActiveXObject("Scripting.FileSystemObject");
var scriptDir = fso.GetParentFolderName(WScript.ScriptFullName);
var blogDir = fso.GetParentFolderName(scriptDir);
var newsletterDir = fso.BuildPath(blogDir, "newsletter");
var rssFile = fso.BuildPath(newsletterDir, "rss.xml");
var siteUrl = "https://www.victorgutierrezmarcos.es";

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

// Format date for RSS (RFC-822)
function formatDateRFC822(dateStr) {
    var days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

    var parts = dateStr.split("-");
    if (parts.length === 3) {
        var date = new Date(parseInt(parts[0]), parseInt(parts[1]) - 1, parseInt(parts[2]));
        var day = days[date.getDay()];
        var dd = date.getDate();
        var mon = months[date.getMonth()];
        var yyyy = date.getFullYear();
        return day + ", " + (dd < 10 ? "0" + dd : dd) + " " + mon + " " + yyyy + " 00:00:00 GMT";
    }
    return dateStr;
}

// Get current date in RFC-822 format
function getCurrentDateRFC822() {
    var days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    var now = new Date();
    var day = days[now.getUTCDay()];
    var dd = now.getUTCDate();
    var mon = months[now.getUTCMonth()];
    var yyyy = now.getUTCFullYear();
    var hh = now.getUTCHours();
    var mm = now.getUTCMinutes();
    var ss = now.getUTCSeconds();

    return day + ", " + (dd < 10 ? "0" + dd : dd) + " " + mon + " " + yyyy + " " +
           (hh < 10 ? "0" + hh : hh) + ":" + (mm < 10 ? "0" + mm : mm) + ":" + (ss < 10 ? "0" + ss : ss) + " GMT";
}

// Escape XML special characters
function escapeXml(str) {
    return str.replace(/&/g, "&amp;")
              .replace(/</g, "&lt;")
              .replace(/>/g, "&gt;")
              .replace(/"/g, "&quot;")
              .replace(/'/g, "&apos;");
}

try {
    WScript.Echo("Escaneando archivos .qmd en " + blogDir);

    // Ensure newsletter directory exists
    if (!fso.FolderExists(newsletterDir)) {
        fso.CreateFolder(newsletterDir);
    }

    var folder = fso.GetFolder(blogDir);
    var files = new Enumerator(folder.Files);
    var posts = [];

    for (; !files.atEnd(); files.moveNext()) {
        var file = files.item();
        var fileName = file.Name;

        // Only process .qmd files, skip templates
        if (fileName.match(/\.qmd$/i) && !fileName.match(/^_/)) {
            var content = readFile(file.Path);

            // Extract YAML
            var yamlMatch = content.match(/^---\r?\n([\s\S]+?)\r?\n---/);
            if (yamlMatch) {
                var yaml = yamlMatch[1];
                var title = getYamlValue(yaml, "title");
                var date = getYamlValue(yaml, "date");
                var slug = getYamlValue(yaml, "slug");
                var description = getYamlValue(yaml, "description");
                if (!description) description = getYamlValue(yaml, "subtitle");

                if (title && date && slug) {
                    // Check if HTML exists
                    var htmlFile = fso.BuildPath(blogDir, slug + ".html");
                    if (fso.FileExists(htmlFile)) {
                        posts.push({
                            title: title,
                            date: date,
                            description: description || "",
                            slug: slug,
                            link: siteUrl + "/blog/" + slug + ".html"
                        });
                    } else {
                        WScript.Echo("  Saltando \"" + title + "\" - HTML no renderizado");
                    }
                }
            }
        }
    }

    // Sort posts by date (newest first)
    posts.sort(function(a, b) {
        return (a.date < b.date) ? 1 : (a.date > b.date) ? -1 : 0;
    });

    WScript.Echo("Encontrados " + posts.length + " articulos publicados.");

    // Generate RSS items
    var rssItems = "";
    for (var i = 0; i < posts.length; i++) {
        var post = posts[i];
        rssItems += "\n    <item>\n" +
                    "      <title><![CDATA[" + post.title + "]]></title>\n" +
                    "      <link>" + post.link + "</link>\n" +
                    "      <description><![CDATA[" + post.description + "]]></description>\n" +
                    "      <pubDate>" + formatDateRFC822(post.date) + "</pubDate>\n" +
                    "      <guid>" + post.link + "</guid>\n" +
                    "    </item>";
    }

    // Generate RSS content
    var rssContent = '<?xml version="1.0" encoding="UTF-8" ?>\n' +
        '<rss version="2.0">\n' +
        '  <channel>\n' +
        '    <title>Blog | Victor Gutierrez Marcos</title>\n' +
        '    <link>' + siteUrl + '/blog/</link>\n' +
        '    <description>Articulos y analisis sobre politica economica y comercio internacional.</description>\n' +
        '    <language>es-es</language>\n' +
        '    <lastBuildDate>' + getCurrentDateRFC822() + '</lastBuildDate>' +
        rssItems + '\n' +
        '  </channel>\n' +
        '</rss>';

    // Write RSS file
    writeFile(rssFile, rssContent);
    WScript.Echo("RSS generado en " + rssFile);

} catch (e) {
    WScript.Echo("Error: " + e.message);
    WScript.Quit(1);
}
