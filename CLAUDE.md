# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Static website for the Spanish civil service exam "Oposición a Técnico Comercial y Economista del Estado" (TCEE). Hosted on GitHub Pages at victorgutierrezmarcos.es. All content and code comments are in Spanish. The author's name is **Víctor Gutiérrez Marcos** (with accent on the í) — always use the accented form everywhere, including non-visible code (meta tags, comments, alt text, etc.).

## Architecture

### Static Site Structure
- Pure HTML/CSS/JS (no build system or framework, no `package.json`)
- Pages are standalone HTML files with shared CSS (`styles.css`)
- Firebase Authentication (Google Sign-In) with Firestore for user data
- Domain: `victorgutierrezmarcos.es` (CNAME file)

### Site Sections
```
/                      # Homepage with 3 cards
├── oposicion/         # Exam preparation materials
│   └── temario/primer-ejercicio/test/  # Test simulator
├── blog/              # Articles (Quarto-based)
├── comunidad.html     # Community page
├── sobre-mi.html      # About page
└── politica-cookies.html  # Cookie/privacy policy
```

### Key Systems

**Authentication** (`auth.js`, `firebase-config.js`)
- Google Sign-In via Firebase Auth
- User exam history stored in Firestore (`users/{uid}/exam_results`)
- Login button injected into nav via `injectLoginButton()`

**Test Simulator** (`oposicion/temario/primer-ejercicio/test/`)
- `simulador.html` - Interactive test practice
- `preguntas.json` - Question bank with metadata (exam, year, tema)
- Results saved to Firestore when logged in

**Search System** (`search-engine.js`, `search-ui.js`, `build-search-index.js`)
- Client-side fuzzy search with Levenshtein distance
- `search-index.json` is pre-built and contains hardcoded curriculum topics — must be manually updated when curriculum changes
- Keyboard shortcut: Ctrl/Cmd+K to open search modal

**Blog & Newsletter** (`blog/`)
- Articles written in Quarto (`.qmd`) with YAML frontmatter
- Template: `blog/_plantilla.qmd` shows required frontmatter fields
- Rendered to HTML/PDF via `render.bat` (runs Quarto, Windows-only)
- Two separate RSS/index scripts exist: root-level ones for GitHub Actions, and `blog/templates/` ones for local `render.bat`
- Newsletter sent automatically via Brevo API when new articles detected
- `blog/newsletter/published-articles.json` tracks already-sent articles (prevents re-sending)
- Only articles with rendered `.html` files are included in RSS/newsletter

**Cookie Consent** (`cookie-consent.js`)
- GDPR-compliant banner managing Google Analytics consent (`G-ZC63ML9ECJ`)
- Stores preferences in localStorage (`vgm_cookie_consent`)

### Design System (CSS Variables in `styles.css`)
- Primary color: `#5F2987` (purple)
- Background: `#E2EFD9` (sage green)
- Display/body font: Palatino Linotype, Georgia (serif)
- UI font: Source Sans 3 (sans-serif)
- Max width: `1000px`

## Commands

```bash
# Rebuild search index after content changes
node build-search-index.js

# Generate RSS feed manually
node generate-rss.js

# Render a blog article (Windows only, requires Quarto installed)
cd blog && render.bat YYYYMMDD_slug.qmd

# Local development — no build step, open HTML files directly or use any static server
```

## Blog Article Workflow

1. Copy `blog/_plantilla.qmd` to new file named `blog/YYYYMMDD_slug.qmd`
2. Fill in YAML frontmatter (title, date, slug, description required)
3. Run `render.bat filename.qmd` to generate HTML and PDF
4. Commit and push — GitHub Action auto-generates RSS and sends newsletter

Required frontmatter fields for newsletter integration:
- `title`, `date` (YYYY-MM-DD), `slug`, `description`

## GitHub Actions

**`.github/workflows/update-rss.yml`**
- Triggers on `blog/*.html` pushes (also `generate-rss.js`, `send-newsletter.js`, and workflow file changes)
- Supports manual dispatch with optional `skip_newsletter` input
- Runs `generate-rss.js` then `send-newsletter.js`
- Auto-commits updated `rss.xml` and `published-articles.json` with `[skip ci]`
- Requires secrets: `BREVO_API_KEY`, `BREVO_LIST_ID`

**`.github/workflows/create-materials-zip.yml`**
- Triggers on every push to main (and manual dispatch)
- Creates ZIP of educational materials (PDFs) from `oposicion/`, stripping web assets
- Creates GitHub release tagged `materiales-latest`

## Navigation Pattern

All HTML pages must include these scripts in order at end of body:
```html
<script src="search-engine.js"></script>
<script src="search-ui.js"></script>
<script src="cookie-consent.js"></script>
<!-- Firebase SDKs -->
<script src="https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.10.1/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.10.1/firebase-firestore.js"></script>
<script src="firebase-config.js"></script>
<script src="auth.js"></script>
```

Pages in `oposicion/` have a sub-navigation bar with inline styles for the section links.
