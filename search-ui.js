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
                            placeholder="Buscar temas, ejercicios, recursos..."
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
                        <span class="search-tip">💡 Consejo: Escribe el número del tema (ej: "3.A.5") o palabras clave</span>
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
        const suggestions = `
            <div class="search-suggestions">
                <div class="suggestion-group">
                    <h4>🔍 Búsquedas sugeridas:</h4>
                    <div class="suggestion-items">
                        <button class="suggestion-btn" data-query="economía internacional">Economía internacional</button>
                        <button class="suggestion-btn" data-query="política monetaria">Política monetaria</button>
                        <button class="suggestion-btn" data-query="comercio">Comercio</button>
                        <button class="suggestion-btn" data-query="keynes">Keynes</button>
                        <button class="suggestion-btn" data-query="UE">Unión Europea</button>
                    </div>
                </div>
                <div class="suggestion-group">
                    <h4>📚 Accesos rápidos:</h4>
                    <div class="suggestion-items">
                        <button class="suggestion-btn" data-query="tercer ejercicio">Tercer ejercicio</button>
                        <button class="suggestion-btn" data-query="cuarto ejercicio">Cuarto ejercicio</button>
                        <button class="suggestion-btn" data-query="test">Test</button>
                        <button class="suggestion-btn" data-query="organización">Organización</button>
                    </div>
                </div>
            </div>
        `;

        this.searchResults.innerHTML = suggestions;

        // Event listeners para los botones de sugerencias
        this.searchResults.querySelectorAll('.suggestion-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                const query = btn.getAttribute('data-query');
                this.searchInput.value = query;
                this.performSearch(query);
            });
        });
    }

    performSearch(query) {
        this.currentQuery = query;

        if (!query || query.trim().length < 2) {
            this.showInitialSuggestions();
            return;
        }

        const results = searchEngine.search(query);

        if (results.length === 0) {
            this.searchResults.innerHTML = `
                <div class="no-results">
                    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="11" cy="11" r="8"/>
                        <path d="m21 21-4.35-4.35"/>
                    </svg>
                    <h3>No se encontraron resultados</h3>
                    <p>Intenta con otros términos de búsqueda</p>
                </div>
            `;
            return;
        }

        this.renderResults(results, query);
    }

    // Las URL del índice son relativas a /oposicion/ (salvo blog, sobre mí y las absolutas):
    // se pasan a absolutas para que funcionen desde cualquier página
    resolverUrl(url) {
        if (/^(https?:)?\//.test(url)) return url;
        if (url.startsWith('blog/') || url === 'sobre-mi.html') return '/' + url;
        if (url === 'index.html') return '/oposicion/';
        return '/oposicion/' + url;
    }

    renderResults(results, query) {
        const html = results.map((result, index) => {
            const icon = this.getIcon(result);
            const badge = this.getBadge(result);
            const description = result.description || result.content || '';
            const isNoDisponible = result.disponible === false;
            const itemClass = isNoDisponible ? 'search-result-item no-disponible' : 'search-result-item';
            const target = result.url.endsWith('.pdf') ? '_blank' : '_self';
            
            // Si no está disponible, no hacer clickeable el enlace al PDF
            const href = isNoDisponible ? '#' : this.resolverUrl(result.url);
            const onClick = isNoDisponible ? 'onclick="event.preventDefault(); alert(\'Este tema aún no está disponible.\')"' : '';
            
            return `
                <a href="${href}" class="${itemClass}" data-index="${index}" target="${target}" ${onClick}>
                    <div class="result-icon">${icon}</div>
                    <div class="result-content">
                        <div class="result-header">
                            <span class="result-title">${result.title}</span>
                            ${badge}
                        </div>
                        ${result.numero ? `<div class="result-numero">${result.numero}</div>` : ''}
                        ${result.ejercicio ? `<div class="result-ejercicio">${result.ejercicio}${result.grupo ? ' - ' + result.grupo : ''}</div>` : ''}
                        ${description ? `<div class="result-description">${description}</div>` : ''}
                    </div>
                    <div class="result-arrow">${isNoDisponible ? '⛔' : '→'}</div>
                </a>
            `;
        }).join('');

        this.searchResults.innerHTML = `
            <div class="results-header">
                <span class="results-count">${results.length} resultado${results.length !== 1 ? 's' : ''}</span>
            </div>
            ${html}
        `;

        // Highlight del primer resultado
        const firstResult = this.searchResults.querySelector('.search-result-item');
        if (firstResult) {
            firstResult.classList.add('selected');
        }
    }

    getIcon(result) {
        // Si no está disponible, mostrar icono diferente
        if (result.disponible === false) {
            return '📭';
        }
        
        const icons = {
            ejercicio: '📋',
            tema: '📄',
            subtema: '📝',
            page: '🏠',
            excel: '📊',
            pdf: '📕',
            presentacion: '🎯',
            word: '📄',
            default: '📌'
        };

        return icons[result.type] || icons.default;
    }

    getBadge(result) {
        let badges = '';
        
        // Badge de tipo
        if (result.type === 'tema') {
            badges += '<span class="result-badge badge-tema">Tema</span>';
        } else if (result.type === 'ejercicio') {
            badges += '<span class="result-badge badge-ejercicio">Ejercicio</span>';
        } else if (result.category === 'organización') {
            badges += '<span class="result-badge badge-recurso">Recurso</span>';
        }
        
        // Badge de disponibilidad (solo para temas)
        if (result.type === 'tema' && result.disponible === false) {
            badges += '<span class="result-badge badge-no-disponible">No disponible</span>';
        }
        
        return badges;
    }

    navigateResults(direction) {
        const items = Array.from(this.searchResults.querySelectorAll('.search-result-item'));
        if (items.length === 0) return;

        const currentSelected = this.searchResults.querySelector('.search-result-item.selected');
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
        const selected = this.searchResults.querySelector('.search-result-item.selected');
        if (selected) {
            // No hacer click si es un tema no disponible
            if (selected.classList.contains('no-disponible')) {
                alert('Este tema aún no está disponible.');
                return;
            }
            selected.click();
        }
    }
}

// Inicializar cuando el DOM esté listo (solo si search-engine.js está cargado)
if (typeof searchEngine !== 'undefined') {
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => {
            const searchUI = new SearchUI();
            searchUI.initialize();
        });
    } else {
        const searchUI = new SearchUI();
        searchUI.initialize();
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
