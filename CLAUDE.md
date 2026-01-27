# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Static website for the Spanish civil service exam "Oposición a Técnico Comercial y Economista del Estado" (TCEE). Hosted on GitHub Pages at victorgutierrezmarcos.es. All content and code comments are in Spanish.

## Architecture

### Static Site Structure
- Pure HTML/CSS/JS (no build system or framework)
- Pages are standalone HTML files with shared CSS (`styles.css`)
- Firebase Authentication (Google Sign-In) with Firestore for user data

### Site Sections
```
/                      # Homepage with 3 cards
├── oposicion/         # Exam preparation materials
│   └── temario/primer-ejercicio/test/  # Test simulator
├── blog/              # Articles (Quarto-based)
└── sobre-mi.html      # About page
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

**Search System** (`search-engine.js`, `search-ui.js`)
- Client-side fuzzy search with Levenshtein distance
- Index generated from HTML content

**Blog & Newsletter** (`blog/`)
- Articles written in Quarto (`.qmd`) with YAML frontmatter
- Template: `blog/_plantilla.qmd` shows required frontmatter fields
- Rendered to HTML/PDF via `render.bat` (runs Quarto)
- Newsletter sent automatically via Brevo API when new articles detected

**Cookie Consent** (`cookie-consent.js`)
- GDPR-compliant banner managing Google Analytics consent
- Stores preferences in localStorage (`vgm_cookie_consent`)

## Commands

```bash
# Rebuild search index after content changes
node build-search-index.js

# Generate RSS feed manually
node generate-rss.js

# Local development
# Open HTML files directly in browser or use any static server
```

## Blog Article Workflow

1. Copy `blog/_plantilla.qmd` to new file (e.g., `blog/my-article.qmd`)
2. Fill in YAML frontmatter (title, date, slug, description required)
3. Run `render.bat` to generate HTML and PDF
4. Commit and push - GitHub Action auto-generates RSS and sends newsletter

Required frontmatter fields for newsletter integration:
- `title`, `date` (YYYY-MM-DD), `slug`, `description`

## GitHub Actions

**`.github/workflows/update-rss.yml`**
- Triggers on `blog/*.html` pushes
- Runs `generate-rss.js` then `send-newsletter.js`
- Requires secrets: `BREVO_API_KEY`, `BREVO_LIST_ID`

**`.github/workflows/create-materials-zip.yml`**
- Creates ZIP of educational materials (PDFs) on push to main
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
