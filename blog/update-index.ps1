# Update blog index with new article
param(
    [Parameter(Mandatory=$true)]
    [string]$QmdFile
)

$indexFile = Join-Path $PSScriptRoot "index.html"
$slug = [System.IO.Path]::GetFileNameWithoutExtension($QmdFile)

# Read qmd file
$content = Get-Content $QmdFile -Raw -Encoding UTF8

# Extract YAML
if ($content -match '(?s)^---\r?\n(.+?)\r?\n---') {
    $yaml = $Matches[1]
} else {
    Write-Host "  Error: No se encontro YAML en el archivo"
    exit 1
}

# Parse YAML values
function Get-YamlValue($yaml, $key) {
    if ($yaml -match "(?m)^${key}:\s*[`"']?([^`"'`r`n]+)[`"']?") {
        return $Matches[1].Trim()
    }
    return ""
}

$title = Get-YamlValue $yaml "title"
$date = Get-YamlValue $yaml "date"
$categoria = Get-YamlValue $yaml "categoria"
$description = Get-YamlValue $yaml "description"
if (-not $description) { $description = Get-YamlValue $yaml "subtitle" }

# Format date in Spanish
$meses = @("enero","febrero","marzo","abril","mayo","junio","julio","agosto","septiembre","octubre","noviembre","diciembre")
try {
    $dateObj = [datetime]::ParseExact($date, "yyyy-MM-dd", $null)
    $fechaLegible = "{0} de {1} de {2}" -f $dateObj.Day, $meses[$dateObj.Month - 1], $dateObj.Year
    $fechaISO = $date
} catch {
    $fechaLegible = $date
    $fechaISO = (Get-Date -Format "yyyy-MM-dd")
}

# Read index.html
$index = Get-Content $indexFile -Raw -Encoding UTF8

# Check if article already exists
if ($index -match [regex]::Escape("$slug.html")) {
    Write-Host "  El articulo ya existe en el indice"
    exit 0
}

# Create article HTML
$articleHtml = @"

                    <article class="article-card">
                        <div class="article-meta">
                            <time datetime="$fechaISO">$fechaLegible</time>
                            <span class="article-category">$categoria</span>
                        </div>
                        <h3 class="article-title">
                            <a href="$slug.html">$title</a>
                        </h3>
                        <p class="article-excerpt">
                            $description
                        </p>
                        <div class="article-actions">
                            <a href="$slug.html" class="read-more">Leer articulo</a>
                            <a href="$slug.pdf" class="download-pdf" download>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
                                    <polyline points="7 10 12 15 17 10"/>
                                    <line x1="12" y1="15" x2="12" y2="3"/>
                                </svg>
                                PDF
                            </a>
                        </div>
                    </article>
"@

# Insert after marker
$index = $index -replace '(<!-- INICIO ART[^>]*-->)', "`$1$articleHtml"

# Save with UTF8 without BOM
[System.IO.File]::WriteAllText($indexFile, $index, [System.Text.UTF8Encoding]::new($false))
Write-Host "  Indice actualizado correctamente"
