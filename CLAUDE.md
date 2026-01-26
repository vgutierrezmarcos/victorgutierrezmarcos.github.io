# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a static website for preparing for the Spanish civil service exam "Oposición a Técnico Comercial y Economista del Estado" (TCEE). The site is hosted on GitHub Pages at victorgutierrezmarcos.es.

## Architecture

### Static Site Structure
- Pure HTML/CSS/JS static website (no build system or framework)
- Pages are standalone HTML files with shared CSS styles
- Content is organized around 5 exam exercises (ejercicios) with PDF materials

### Key Components

**Search System** (`search-engine.js`, `search-ui.js`, `build-search-index.js`)
- Client-side fuzzy search with Levenshtein distance ranking
- `build-search-index.js` generates `search-index.json` by running `node build-search-index.js`
- Index contains pages, temas (topics), and recursos (resources)

**Test Simulator** (`temario/primer-ejercicio/test/`)
- `simulador.html` - Interactive test practice interface
- `preguntas.json` - Question bank from official exams with metadata (exam, year, tema)
- Questions can be filtered by exam or topic

**Cookie Consent** (`cookie-consent.js`, `cookie-consent.css`)
- GDPR-compliant consent banner
- Manages Google Analytics loading based on consent

### Content Organization
```
temario/
├── primer-ejercicio/     # Test + Dictamen de coyuntura
│   └── test/            # Simulator and question bank
├── segundo-ejercicio/    # Languages
├── tercer-ejercicio/     # Economics (Parts A & B with ~90 topics)
├── cuarto-ejercicio/     # Spanish Economy & Public Finance (Parts A & B)
└── quinto-ejercicio/     # Marketing, Econometrics, Law (Parts A, B & C)
```

## Commands

**Rebuild search index after content changes:**
```bash
node build-search-index.js
```

**Local development:** Open HTML files directly in browser or use any static server.

## GitHub Actions

`.github/workflows/create-materials-zip.yml` - Creates downloadable ZIP of educational materials (PDFs) on push to main. Strips web assets, creates GitHub release tagged `materiales-latest`.

## Language

All content and code comments are in Spanish. The website targets Spanish-speaking civil service exam candidates.
