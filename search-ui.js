// Iconos de trazo fino de los resultados (los mismos que el resto de la web)
const ICONOS_BUSQUEDA = {
    portapapeles: '<svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="5" y="4.5" width="14" height="16" rx="2"/><path d="M9 4.5V3.5h6v1"/><path d="M8.5 10h7M8.5 14h5"/></svg>',
    documento: '<svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M14 3H7a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V8z"/><path d="M14 3v5h5"/><path d="M9 13h6M9 17h4"/></svg>',
    casa: '<svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 10.5 12 4l8 6.5V20H4z"/><path d="M10 20v-5h4v5"/></svg>',
    tabla: '<svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="4" y="4" width="16" height="16" rx="1.5"/><path d="M4 9.5h16M4 14.5h16M10 4v16"/></svg>',
    pantalla: '<svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="3" y="4" width="18" height="12" rx="1.5"/><path d="M12 16v4M8.5 20h7"/></svg>',
    marcador: '<svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M7 3.5h10v17l-5-3.5-5 3.5z"/></svg>',
    bandeja: '<svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M3.5 13.5 6 5.5h12l2.5 8V19a1 1 0 0 1-1 1h-15a1 1 0 0 1-1-1z"/><path d="M3.5 13.5H9l1 2h4l1-2h5.5"/></svg>',
    prohibido: '<svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="9"/><path d="M5.6 5.6l12.8 12.8"/></svg>',
    derecha: '<svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="m9 6 6 6-6 6"/></svg>',
};

function escBusqueda(t) { return String(t == null ? '' : t).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;'); }

const TIPOS_BUSQUEDA = [['', 'Todo'], ['Temas', 'Temas'], ['Preguntas de test', 'Test'], ['Páginas', 'Páginas'], ['Blog', 'Blog']];

/**
 * Pinta los resultados del motor (search-engine.js) en [cont]: los temas por número
 * primero, después los grupos (un tema con sus apartados y el fragmento resaltado, o
 * una página o pregunta suelta). Lo usan la ventana del buscador y /buscar.html.
 */
function pintarResultados(cont, r, query, { filtro = '', alFiltrar, alSugerir, enlaceTodos = false } = {}) {
    const fichas = TIPOS_BUSQUEDA.map(([v, t]) => `<button type="button" class="busqueda-filtro${v === filtro ? ' activo' : ''}" data-filtro="${v}" aria-pressed="${v === filtro}">${t}</button>`).join('');
    const extracto = e => (e ? `<div class="result-description result-extracto">${e}</div>` : '');
    const icono = g => (g.tipo === 'tema' ? ICONOS_BUSQUEDA.documento : g.tipo === 'test' ? ICONOS_BUSQUEDA.portapapeles : g.tipo === 'blog' ? ICONOS_BUSQUEDA.marcador : ICONOS_BUSQUEDA.casa);
    const etiqueta = { tema: 'Tema', test: 'Test', blog: 'Blog', pagina: 'Página' };
    const destinoAttr = pdf => (pdf ? ' target="_blank" rel="noopener"' : '');
    let html = `<div class="busqueda-filtros" role="group" aria-label="Filtrar resultados">${fichas}</div>`;
    const directos = r.directos.map(t => {
        const url = searchEngine.urlTema(t);
        const revisado = url && /\/tercer-ejercicio\/3[AB]\d\d\.pdf$/.test(url);
        const href = revisado ? url.replace(/\.pdf$/, '.html') : url;
        return url
            ? `<a class="search-result-item" href="${escBusqueda(href)}"${destinoAttr(!revisado)}><div class="result-icon">${ICONOS_BUSQUEDA.documento}</div><div class="result-content"><div class="result-header"><span class="result-title">Tema ${escBusqueda(t.numero)}</span><span class="result-badge badge-tema">Tema</span></div><div class="result-description">${escBusqueda(t.title)}</div></div><div class="result-arrow">${ICONOS_BUSQUEDA.derecha}</div></a>`
            : `<div class="search-result-item no-disponible"><div class="result-icon">${ICONOS_BUSQUEDA.bandeja}</div><div class="result-content"><div class="result-header"><span class="result-title">Tema ${escBusqueda(t.numero)}</span><span class="result-badge badge-no-disponible">No disponible</span></div><div class="result-description">${escBusqueda(t.title)}</div></div></div>`;
    }).join('');
    const grupos = r.grupos.map(g => {
        if (g.tipo === 'tema') {
            const subs = g.items.map(i => `<a class="search-result-item busqueda-apartado" href="${escBusqueda(i.url)}"${destinoAttr(i.pdf)}><div class="result-content"><div class="result-title">${escBusqueda(i.apartado)}</div>${extracto(i.extracto)}</div><div class="result-arrow">${ICONOS_BUSQUEDA.derecha}</div></a>`).join('');
            return `<div class="busqueda-grupo"><a class="search-result-item busqueda-tema" href="${escBusqueda(g.url)}"${destinoAttr(g.pdf)}><div class="result-icon">${ICONOS_BUSQUEDA.documento}</div><div class="result-content"><div class="result-header"><span class="result-title">${escBusqueda(g.titulo)}</span><span class="result-badge badge-tema">Tema</span></div></div><div class="result-arrow">${ICONOS_BUSQUEDA.derecha}</div></a>${subs}</div>`;
        }
        return `<a class="search-result-item" href="${escBusqueda(g.url)}"${destinoAttr(g.pdf)}><div class="result-icon">${icono(g)}</div><div class="result-content"><div class="result-header"><span class="result-title">${escBusqueda(g.titulo)}</span><span class="result-badge badge-${g.tipo === 'test' ? 'ejercicio' : 'recurso'}">${etiqueta[g.tipo] || ''}</span></div>${extracto(g.extracto)}</div><div class="result-arrow">${ICONOS_BUSQUEDA.derecha}</div></a>`;
    }).join('');
    if (!directos && !grupos) {
        html += `<div class="no-results"><h3>Sin resultados para «${escBusqueda(query)}»</h3>${r.sugerencia ? `<p>¿Quisiste decir <button type="button" class="boton--texto busqueda-sugerencia" data-q="${escBusqueda(r.sugerencia)}">${escBusqueda(r.sugerencia)}</button>?</p>` : '<p>Prueba con otra palabra, el número del tema o quita el filtro.</p>'}</div>`;
    } else {
        if (r.sugerencia) html += `<p class="busqueda-ayuda">¿Quisiste decir <button type="button" class="busqueda-sugerencia" data-q="${escBusqueda(r.sugerencia)}">${escBusqueda(r.sugerencia)}</button>?</p>`;
        html += `<div class="results-header"><span class="results-count">${r.total + r.directos.length} resultado${r.total + r.directos.length !== 1 ? 's' : ''}</span>${enlaceTodos ? `<a class="busqueda-todos" href="/buscar.html?q=${encodeURIComponent(query)}${filtro ? '&tipo=' + encodeURIComponent(filtro) : ''}">Ver en una página</a>` : ''}</div>${directos}${grupos}`;
    }
    cont.innerHTML = html;
    cont.querySelectorAll('.busqueda-filtro').forEach(b => b.addEventListener('click', () => alFiltrar && alFiltrar(b.getAttribute('data-filtro'))));
    const sug = cont.querySelector('.busqueda-sugerencia');
    if (sug) sug.addEventListener('click', () => alSugerir && alSugerir(sug.getAttribute('data-q')));
    const primero = cont.querySelector('a.search-result-item');
    if (primero) primero.classList.add('selected');
}

/**
 * Interfaz de búsqueda - UI y handlers
 * Actualizado para mostrar estado de disponibilidad
 */

class SearchUI {
    constructor() {
        this.searchInput = null;
        this.searchButton = null;
        this.searchResults = null;
        this.searchOverlay = null;
        this.currentQuery = '';
        this.debounceTimer = null;
    }

    async initialize() {
        // El botón sale ya; el índice se descarga al abrir el buscador
        this.createSearchUI();
        this.attachEventListeners();
    }

    createSearchUI() {
        // Crear el overlay de búsqueda
        const overlay = document.createElement('div');
        overlay.id = 'search-overlay';
        overlay.className = 'search-overlay';
        overlay.innerHTML = `
            <div class="search-modal" role="dialog" aria-modal="true" aria-label="Buscar en la web">
                <div class="search-header">
                    <div class="search-input-container">
                        <svg class="search-icon" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="11" cy="11" r="8"/>
                            <path d="m21 21-4.35-4.35"/>
                        </svg>
                        <input 
                            type="text" 
                            id="search-input" 
                            aria-label="Buscar temas, ejercicios y recursos" 
                            aria-controls="search-results" 
                            class="search-input" 
                            placeholder="Busca un tema, un concepto o una pregunta…"
                            autocomplete="off"
                            spellcheck="false"
                        />
                        <button class="search-close" aria-label="Cerrar búsqueda">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <line x1="18" y1="6" x2="6" y2="18"/>
                                <line x1="6" y1="6" x2="18" y2="18"/>
                            </svg>
                        </button>
                    </div>
                    <div class="search-tips">
                        <span class="search-tip"><svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M9.5 18h5M10.5 21h3"/><path d="M12 3a6 6 0 0 0-3.5 10.9c.6.5 1 1.2 1 2.1h5c0-.9.4-1.6 1-2.1A6 6 0 0 0 12 3z"/></svg> Busca dentro de todos los temas: un concepto («Marshall-Lerner»), un autor o el número del tema («3.A.5»)</span>
                    </div>
                </div>
                <div class="search-results-container">
                    <div id="search-results" class="search-results" aria-live="polite"></div>
                </div>
                <div class="search-footer">
                    <div class="search-shortcuts">
                        <span><kbd>↑</kbd> <kbd>↓</kbd> para navegar</span>
                        <span><kbd>Enter</kbd> para abrir</span>
                        <span><kbd>Esc</kbd> para cerrar</span>
                    </div>
                </div>
            </div>
        `;

        document.body.appendChild(overlay);

        this.searchOverlay = overlay;
        this.searchInput = document.getElementById('search-input');
        this.searchResults = document.getElementById('search-results');

        // Agregar botón de búsqueda en la navegación
        const nav = document.querySelector('.nav-list');
        if (nav) {
            const searchLi = document.createElement('li');
            searchLi.className = 'nav-right-item'; // Clase para alineación a la derecha
            searchLi.innerHTML = `
                <a href="#" id="open-search" class="search-trigger" role="button" aria-haspopup="dialog" aria-label="Buscar (Ctrl+K)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="11" cy="11" r="8"/>
                        <path d="m21 21-4.35-4.35"/>
                    </svg>
                    Buscar
                </a>
            `;
            nav.appendChild(searchLi);
        }
    }

    attachEventListeners() {
        // Abrir búsqueda
        const openSearchBtn = document.getElementById('open-search');
        if (openSearchBtn) {
            openSearchBtn.addEventListener('click', (e) => {
                e.preventDefault();
                this.openSearch();
            });
        }

        // Abrir búsqueda desde el blog
        const blogSearchBtn = document.getElementById('blog-search-btn');
        if (blogSearchBtn) {
            blogSearchBtn.addEventListener('click', (e) => {
                e.preventDefault();
                this.openSearch();
            });
        }

        // Cerrar búsqueda
        const closeBtn = this.searchOverlay.querySelector('.search-close');
        closeBtn.addEventListener('click', () => this.closeSearch());

        // Cerrar al hacer click fuera del modal
        this.searchOverlay.addEventListener('click', (e) => {
            if (e.target === this.searchOverlay) {
                this.closeSearch();
            }
        });

        // Input de búsqueda con debounce
        this.searchInput.addEventListener('input', (e) => {
            clearTimeout(this.debounceTimer);
            this.debounceTimer = setTimeout(() => {
                this.performSearch(e.target.value);
            }, 300);
        });

        // Atajos de teclado
        document.addEventListener('keydown', (e) => {
            // Ctrl/Cmd + K para abrir búsqueda
            if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
                e.preventDefault();
                this.openSearch();
            }

            // Escape para cerrar
            if (e.key === 'Escape' && this.searchOverlay.classList.contains('active')) {
                this.closeSearch();
            }

            // Navegación con flechas
            if (this.searchOverlay.classList.contains('active')) {
                if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
                    e.preventDefault();
                    this.navigateResults(e.key === 'ArrowDown' ? 1 : -1);
                }

                if (e.key === 'Enter') {
                    e.preventDefault();
                    this.selectCurrentResult();
                }
            }
        });
    }

    openSearch() {
        searchEngine.initialize().then(ok => {
            if (!ok) console.error('No se pudo inicializar el buscador');
            else if (this.currentQuery) this.performSearch(this.currentQuery);
        });
        this.searchOverlay.classList.add('active');
        document.body.style.overflow = 'hidden';
        this.searchInput.focus();
        
        // Mostrar sugerencias iniciales
        if (this.currentQuery === '') {
            this.showInitialSuggestions();
        }
    }

    closeSearch() {
        this.searchOverlay.classList.remove('active');
        document.body.style.overflow = '';
        this.searchInput.value = '';
        this.searchResults.innerHTML = '';
        this.currentQuery = '';
    }

    showInitialSuggestions() {
        const ej = ['equilibrio de Nash', '3.A.14', 'curva de Phillips', 'Marshall-Lerner', 'nota de corte', 'dictamen de coyuntura'];
        this.searchResults.innerHTML = `
            <div class="search-suggestions">
                <div class="suggestion-group">
                    <h4>Busca un tema, un concepto o una pregunta del test</h4>
                    <div class="suggestion-items">
                        ${ej.map(q => `<button class="suggestion-btn" data-query="${q}">${q}</button>`).join('')}
                    </div>
                </div>
            </div>`;
        this.searchResults.querySelectorAll('.suggestion-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                this.searchInput.value = btn.getAttribute('data-query');
                this.performSearch(this.searchInput.value);
            });
        });
    }

    // Analytics (solo si está aceptado: gtag lo carga cookie-consent.js): la búsqueda
    // cuando el usuario deja de escribir, y aparte las que no dan nada.
    medir(query, total) {
        clearTimeout(this.medicion);
        this.medicion = setTimeout(() => {
            if (typeof window.gtag !== 'function' || !query || query.length < 3) return;
            window.gtag('event', 'view_search_results', { search_term: query.slice(0, 100) });
            if (!total) window.gtag('event', 'busqueda_sin_resultados', { search_term: query.slice(0, 100) });
        }, 2000);
    }

    async performSearch(query) {
        this.currentQuery = query;
        if (!query || query.trim().length < 2) {
            this.showInitialSuggestions();
            return;
        }
        const turno = (this.turno = (this.turno || 0) + 1);
        const r = await searchEngine.buscar(query.trim(), { tipo: this.filtro || '' });
        if (turno !== this.turno) return; // ya se ha escrito otra cosa
        this.medir(query.trim(), r.total + r.directos.length);
        pintarResultados(this.searchResults, r, query.trim(), { filtro: this.filtro || '', alFiltrar: f => { this.filtro = f; this.performSearch(this.currentQuery); }, alSugerir: q => { this.searchInput.value = q; this.performSearch(q); }, enlaceTodos: true });
    }

    navigateResults(direction) {
        const items = Array.from(this.searchResults.querySelectorAll('a.search-result-item'));
        if (items.length === 0) return;

        const currentSelected = this.searchResults.querySelector('a.search-result-item.selected');
        let currentIndex = currentSelected ? items.indexOf(currentSelected) : -1;

        // Remover selección actual
        if (currentSelected) {
            currentSelected.classList.remove('selected');
        }

        // Calcular nuevo índice
        currentIndex += direction;
        if (currentIndex < 0) currentIndex = items.length - 1;
        if (currentIndex >= items.length) currentIndex = 0;

        // Seleccionar nuevo item
        const newSelected = items[currentIndex];
        newSelected.classList.add('selected');
        newSelected.scrollIntoView({ block: 'nearest', behavior: 'smooth' });
    }

    selectCurrentResult() {
        const selected = this.searchResults.querySelector('a.search-result-item.selected');
        if (selected) {
            selected.click();
        }
    }
}

/**
 * Página /buscar.html?q=…&tipo=…: el mismo buscador en una página que se puede
 * enlazar. Y la caja de búsqueda de la portada (#busqueda-portada), que lleva aquí.
 */
function paginaBuscar() {
    const cont = document.getElementById('buscar-resultados');
    const input = document.getElementById('buscar-q');
    if (!cont || !input) return;
    const params = new URLSearchParams(location.search);
    let filtro = params.get('tipo') || '';
    let turno = 0, medicion = null;
    async function buscar(q, empujar) {
        q = (q || '').trim();
        if (empujar) {
            const u = new URL(location.href);
            q ? u.searchParams.set('q', q) : u.searchParams.delete('q');
            filtro ? u.searchParams.set('tipo', filtro) : u.searchParams.delete('tipo');
            history.replaceState(null, '', u);
        }
        if (q.length < 2) { cont.innerHTML = ''; return; }
        cont.innerHTML = '<p class="busqueda-cargando">Buscando…</p>';
        const t = ++turno;
        const r = await searchEngine.buscar(q, { tipo: filtro, max: 60 });
        if (t !== turno) return;
        document.title = `«${q}» · Buscar | Víctor Gutiérrez Marcos`;
        pintarResultados(cont, r, q, { filtro, alFiltrar: f => { filtro = f; buscar(input.value, true); }, alSugerir: s => { input.value = s; buscar(s, true); } });
        clearTimeout(medicion);
        medicion = setTimeout(() => {
            if (typeof window.gtag !== 'function' || q.length < 3) return;
            window.gtag('event', 'view_search_results', { search_term: q.slice(0, 100) });
            if (!(r.total + r.directos.length)) window.gtag('event', 'busqueda_sin_resultados', { search_term: q.slice(0, 100) });
        }, 1500);
    }
    input.value = params.get('q') || '';
    let espera = null;
    input.addEventListener('input', () => { clearTimeout(espera); espera = setTimeout(() => buscar(input.value, true), 250); });
    input.form && input.form.addEventListener('submit', e => { e.preventDefault(); buscar(input.value, true); });
    if (input.value) buscar(input.value, false); else input.focus();
}

// Inicializar cuando el DOM esté listo (solo si search-engine.js está cargado)
if (typeof searchEngine !== 'undefined') {
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => {
            const searchUI = new SearchUI();
            searchUI.initialize();
            paginaBuscar();
        });
    } else {
        const searchUI = new SearchUI();
        searchUI.initialize();
        paginaBuscar();
    }
}

// ============================================
// MODO OSCURO
// ============================================

(function() {
    // Aplicar tema guardado antes de que se pinte la página
    var saved = localStorage.getItem('vgm_theme');
    if (saved === 'dark' || (!saved && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.setAttribute('data-theme', 'dark');
    }

    function createToggle() {
        var btn = document.createElement('button');
        btn.className = 'theme-toggle';
        btn.setAttribute('aria-label', 'Cambiar entre modo claro y oscuro');
        // Luna (en claro: pasar a oscuro) y sol (en oscuro: pasar a claro), de trazo fino.
        btn.innerHTML =
            '<svg class="icon-light" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">' +
                '<path d="M20 14.5A8 8 0 0 1 9.5 4a8 8 0 1 0 10.5 10.5z"/></svg>' +
            '<svg class="icon-dark" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">' +
                '<circle cx="12" cy="12" r="4"/><path d="M12 2.5v2M12 19.5v2M2.5 12h2M19.5 12h2M5.3 5.3l1.4 1.4M17.3 17.3l1.4 1.4M5.3 18.7l1.4-1.4M17.3 6.7l1.4-1.4"/></svg>';
        document.body.appendChild(btn);

        btn.addEventListener('click', function() {
            var isDark = document.documentElement.getAttribute('data-theme') === 'dark';
            if (isDark) {
                document.documentElement.removeAttribute('data-theme');
                localStorage.setItem('vgm_theme', 'light');
            } else {
                document.documentElement.setAttribute('data-theme', 'dark');
                localStorage.setItem('vgm_theme', 'dark');
            }
        });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', createToggle);
    } else {
        createToggle();
    }
})();

// ============================================
// BOTÓN VOLVER ARRIBA
// ============================================

(function() {
    var btn = document.createElement('button');
    btn.className = 'back-to-top';
    btn.setAttribute('aria-label', 'Volver arriba');
    btn.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path stroke-linecap="round" stroke-linejoin="round" d="M5 15l7-7 7 7"/></svg>';
    document.body.appendChild(btn);

    window.addEventListener('scroll', function() {
        if (window.scrollY > 400) {
            btn.classList.add('visible');
        } else {
            btn.classList.remove('visible');
        }
    }, { passive: true });

    btn.addEventListener('click', function() {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
})();

// ============================================
// MENÚ EN TIRA (MÓVIL): centrar la sección activa
// ============================================

(function() {
    function centrarActivos() {
        document.querySelectorAll('.nav-list').forEach(function(lista) {
            var activo = lista.querySelector('a.active');
            if (!activo || lista.scrollWidth <= lista.clientWidth) return;
            var li = activo.parentElement;
            lista.scrollLeft = li.offsetLeft - (lista.clientWidth - li.offsetWidth) / 2;
        });
    }
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', centrarActivos);
    } else {
        centrarActivos();
    }
})();
