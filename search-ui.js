/**
 * Interfaz de búsqueda - UI y handlers
 * Versión mejorada con iconos SVG y mejor diseño
 */

class SearchUI {
    constructor() {
        this.searchInput = null;
        this.searchButton = null;
        this.searchResults = null;
        this.searchOverlay = null;
        this.currentQuery = '';
        this.debounceTimer = null;
        this.selectedIndex = -1;
    }

    // Iconos SVG para cada tipo de contenido
    icons = {
        tema: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
            <polyline points="14 2 14 8 20 8"></polyline>
            <line x1="16" y1="13" x2="8" y2="13"></line>
            <line x1="16" y1="17" x2="8" y2="17"></line>
            <polyline points="10 9 9 9 8 9"></polyline>
        </svg>`,
        subtema: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
            <polyline points="14 2 14 8 20 8"></polyline>
        </svg>`,
        ejercicio: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
            <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
        </svg>`,
        page: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"></circle>
            <line x1="2" y1="12" x2="22" y2="12"></line>
            <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path>
        </svg>`,
        pdf: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
            <polyline points="14 2 14 8 20 8"></polyline>
            <path d="M9 15v-2h2a1 1 0 1 1 0 2H9z"></path>
        </svg>`,
        excel: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
            <line x1="3" y1="9" x2="21" y2="9"></line>
            <line x1="3" y1="15" x2="21" y2="15"></line>
            <line x1="9" y1="3" x2="9" y2="21"></line>
            <line x1="15" y1="3" x2="15" y2="21"></line>
        </svg>`,
        word: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
            <polyline points="14 2 14 8 20 8"></polyline>
            <line x1="16" y1="13" x2="8" y2="13"></line>
            <line x1="16" y1="17" x2="8" y2="17"></line>
        </svg>`,
        presentacion: `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
            <line x1="8" y1="21" x2="16" y2="21"></line>
            <line x1="12" y1="17" x2="12" y2="21"></line>
        </svg>`
    };

    async initialize() {
        // Inicializar el motor de búsqueda
        const initialized = await searchEngine.initialize();
        if (!initialized) {
            console.error('No se pudo inicializar el buscador');
            return;
        }

        this.injectStyles();
        this.createSearchUI();
        this.attachEventListeners();
    }

    injectStyles() {
        const styleId = 'search-ui-styles';
        if (document.getElementById(styleId)) return;

        const styles = document.createElement('style');
        styles.id = styleId;
        styles.textContent = `
            /* Overlay */
            .search-overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.6);
                backdrop-filter: blur(4px);
                z-index: 9999;
                display: none;
                align-items: flex-start;
                justify-content: center;
                padding-top: 10vh;
            }

            .search-overlay.active {
                display: flex;
            }

            /* Modal */
            .search-modal {
                background: #fff;
                border-radius: 12px;
                width: 90%;
                max-width: 640px;
                max-height: 70vh;
                display: flex;
                flex-direction: column;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
                overflow: hidden;
            }

            /* Header */
            .search-header {
                padding: 16px;
                border-bottom: 1px solid #e5e7eb;
            }

            .search-input-container {
                display: flex;
                align-items: center;
                gap: 12px;
                background: #f9fafb;
                border: 2px solid #e5e7eb;
                border-radius: 8px;
                padding: 12px 16px;
                transition: border-color 0.2s;
            }

            .search-input-container:focus-within {
                border-color: #6366f1;
                background: #fff;
            }

            .search-icon {
                width: 20px;
                height: 20px;
                color: #9ca3af;
                flex-shrink: 0;
            }

            .search-input {
                flex: 1;
                border: none;
                background: transparent;
                font-size: 16px;
                color: #1f2937;
                outline: none;
            }

            .search-input::placeholder {
                color: #9ca3af;
            }

            .search-close {
                background: none;
                border: none;
                padding: 4px;
                cursor: pointer;
                color: #9ca3af;
                border-radius: 4px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s;
            }

            .search-close:hover {
                background: #f3f4f6;
                color: #4b5563;
            }

            .search-close svg {
                width: 20px;
                height: 20px;
            }

            .search-tips {
                margin-top: 8px;
                font-size: 13px;
                color: #6b7280;
            }

            /* Results container */
            .search-results-container {
                flex: 1;
                overflow-y: auto;
                padding: 8px;
            }

            /* Empty state */
            .search-empty {
                padding: 24px 16px;
                color: #6b7280;
                font-size: 14px;
            }

            .search-empty p {
                margin: 0 0 16px 0;
            }

            .search-suggestions {
                background: #f9fafb;
                border-radius: 8px;
                padding: 16px;
            }

            .search-suggestions p {
                margin: 0 0 8px 0;
                font-weight: 600;
                color: #374151;
            }

            .search-suggestions ul {
                margin: 0;
                padding-left: 20px;
            }

            .search-suggestions li {
                margin: 6px 0;
            }

            .search-suggestions code {
                background: #e5e7eb;
                padding: 2px 6px;
                border-radius: 4px;
                font-size: 13px;
                color: #4b5563;
            }

            /* No results */
            .search-no-results {
                padding: 32px 16px;
                text-align: center;
                color: #6b7280;
            }

            .search-no-results p {
                margin: 0 0 8px 0;
            }

            .search-no-results-hint {
                font-size: 13px;
                color: #9ca3af;
            }

            /* Result groups */
            .search-result-group {
                margin-bottom: 8px;
            }

            .search-result-group-title {
                font-size: 11px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.05em;
                color: #6b7280;
                padding: 8px 12px 4px;
            }

            /* Result items */
            .search-result-item {
                border-radius: 8px;
                transition: background-color 0.15s;
            }

            .search-result-item:hover,
            .search-result-item.selected {
                background: #f3f4f6;
            }

            .search-result-item.unavailable {
                opacity: 0.5;
            }

            .search-result-link {
                display: flex;
                align-items: flex-start;
                gap: 12px;
                padding: 10px 12px;
                text-decoration: none;
                color: inherit;
            }

            .search-result-icon {
                flex-shrink: 0;
                width: 36px;
                height: 36px;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #f3f4f6;
                border-radius: 8px;
                color: #6366f1;
            }

            .search-result-item:hover .search-result-icon,
            .search-result-item.selected .search-result-icon {
                background: #e0e7ff;
            }

            .search-result-content {
                flex: 1;
                min-width: 0;
            }

            .search-result-title {
                font-size: 14px;
                font-weight: 500;
                color: #1f2937;
                margin-bottom: 2px;
                display: flex;
                align-items: center;
                gap: 8px;
                flex-wrap: wrap;
            }

            .search-result-title mark {
                background: #fef08a;
                color: inherit;
                padding: 0 2px;
                border-radius: 2px;
            }

            .search-result-subtitle {
                font-size: 12px;
                color: #6b7280;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .badge-unavailable {
                font-size: 10px;
                font-weight: 500;
                background: #fef2f2;
                color: #dc2626;
                padding: 2px 6px;
                border-radius: 4px;
            }

            /* Footer */
            .search-footer {
                padding: 12px 16px;
                border-top: 1px solid #e5e7eb;
                background: #f9fafb;
            }

            .search-shortcuts {
                display: flex;
                gap: 16px;
                justify-content: center;
                font-size: 12px;
                color: #6b7280;
            }

            .search-shortcuts kbd {
                display: inline-block;
                padding: 2px 6px;
                background: #fff;
                border: 1px solid #d1d5db;
                border-radius: 4px;
                font-family: inherit;
                font-size: 11px;
                box-shadow: 0 1px 2px rgba(0,0,0,0.05);
            }

            /* Responsive */
            @media (max-width: 640px) {
                .search-overlay {
                    padding-top: 5vh;
                }
                
                .search-modal {
                    width: 95%;
                    max-height: 80vh;
                }

                .search-shortcuts {
                    display: none;
                }
            }
        `;
        document.head.appendChild(styles);
    }

    createSearchUI() {
        // Crear el overlay de búsqueda
        const overlay = document.createElement('div');
        overlay.id = 'search-overlay';
        overlay.className = 'search-overlay';
        overlay.innerHTML = `
            <div class="search-modal">
                <div class="search-header">
                    <div class="search-input-container">
                        <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="11" cy="11" r="8"/>
                            <path d="m21 21-4.35-4.35"/>
                        </svg>
                        <input 
                            type="text" 
                            id="search-input" 
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
                        Escribe el número del tema (ej: "4A1", "3.B.5") o palabras clave
                    </div>
                </div>
                <div class="search-results-container">
                    <div id="search-results" class="search-results"></div>
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
            searchLi.innerHTML = `
                <a href="#" id="open-search" class="search-trigger">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="11" cy="11" r="8"/>
                        <path d="m21 21-4.35-4.35"/>
                    </svg>
                    BUSCAR
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
            }, 200);
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

                // Enter para abrir resultado seleccionado
                if (e.key === 'Enter') {
                    const selected = this.searchResults.querySelector('.search-result-item.selected');
                    if (selected) {
                        e.preventDefault();
                        const link = selected.querySelector('a');
                        if (link) {
                            window.location.href = link.href;
                        }
                    }
                }
            }
        });
    }

    openSearch() {
        this.searchOverlay.classList.add('active');
        this.searchInput.focus();
        document.body.style.overflow = 'hidden';
        // Mostrar estado inicial
        this.searchResults.innerHTML = this.renderEmptyState();
    }

    closeSearch() {
        this.searchOverlay.classList.remove('active');
        this.searchInput.value = '';
        this.searchResults.innerHTML = '';
        this.selectedIndex = -1;
        document.body.style.overflow = '';
    }

    navigateResults(direction) {
        const items = this.searchResults.querySelectorAll('.search-result-item');
        if (items.length === 0) return;

        // Quitar selección actual
        items.forEach(item => item.classList.remove('selected'));

        // Actualizar índice
        this.selectedIndex += direction;
        if (this.selectedIndex < 0) this.selectedIndex = items.length - 1;
        if (this.selectedIndex >= items.length) this.selectedIndex = 0;

        // Seleccionar nuevo item
        const selectedItem = items[this.selectedIndex];
        selectedItem.classList.add('selected');
        selectedItem.scrollIntoView({ block: 'nearest' });
    }

    performSearch(query) {
        this.currentQuery = query;
        this.selectedIndex = -1;

        if (!query || query.trim().length < 2) {
            this.searchResults.innerHTML = this.renderEmptyState();
            return;
        }

        const results = searchEngine.search(query);
        this.renderResults(results, query);
    }

    renderEmptyState() {
        return `
            <div class="search-empty">
                <p>Escribe al menos 2 caracteres para buscar...</p>
                <div class="search-suggestions">
                    <p>Sugerencias:</p>
                    <ul>
                        <li>Número de tema: <code>4A1</code>, <code>3.B.5</code>, <code>4B12</code></li>
                        <li>Palabras clave: <code>balanza de pagos</code>, <code>imposición</code></li>
                        <li>Ejercicio: <code>tercer ejercicio</code>, <code>cuarto ejercicio</code></li>
                    </ul>
                </div>
            </div>
        `;
    }

    renderResults(results, query) {
        if (results.length === 0) {
            this.searchResults.innerHTML = `
                <div class="search-no-results">
                    <p>No se encontraron resultados para "<strong>${this.escapeHtml(query)}</strong>"</p>
                    <p class="search-no-results-hint">Prueba con otros términos o el número del tema (ej: 4A1, 3B5)</p>
                </div>
            `;
            return;
        }

        // Agrupar resultados por tipo
        const grouped = this.groupResults(results);
        
        let html = '';
        
        // Renderizar cada grupo
        for (const [groupName, items] of Object.entries(grouped)) {
            if (items.length === 0) continue;
            
            html += `<div class="search-result-group">`;
            html += `<div class="search-result-group-title">${groupName}</div>`;
            
            items.forEach(item => {
                html += this.renderResultItem(item, query);
            });
            
            html += `</div>`;
        }

        this.searchResults.innerHTML = html;
    }

    groupResults(results) {
        const groups = {
            'Temas del 4º ejercicio': [],
            'Temas del 3er ejercicio': [],
            'Otros ejercicios': [],
            'Páginas': [],
            'Recursos': []
        };

        results.forEach(item => {
            if (item.type === 'tema' || item.type === 'subtema') {
                if (item.ejercicio === 'Cuarto ejercicio') {
                    groups['Temas del 4º ejercicio'].push(item);
                } else if (item.ejercicio === 'Tercer ejercicio') {
                    groups['Temas del 3er ejercicio'].push(item);
                } else {
                    groups['Otros ejercicios'].push(item);
                }
            } else if (item.type === 'ejercicio') {
                groups['Otros ejercicios'].push(item);
            } else if (item.type === 'excel' || item.type === 'pdf' || item.type === 'word' || item.type === 'presentacion') {
                groups['Recursos'].push(item);
            } else {
                groups['Páginas'].push(item);
            }
        });

        return groups;
    }

    renderResultItem(item, query) {
        const isUnavailable = item.disponible === false;
        const unavailableClass = isUnavailable ? 'unavailable' : '';
        const unavailableBadge = isUnavailable ? '<span class="badge-unavailable">No disponible</span>' : '';
        
        let icon = this.getTypeIcon(item.type);
        let subtitle = this.getSubtitle(item);
        let title = item.numero ? `${item.numero}: ${item.title}` : item.title;
        
        // Resaltar términos de búsqueda
        title = searchEngine.highlightTerms(title, query);
        
        return `
            <div class="search-result-item ${unavailableClass}" data-url="${item.url}">
                <a href="${item.url}" class="search-result-link">
                    <div class="search-result-icon">${icon}</div>
                    <div class="search-result-content">
                        <div class="search-result-title">${title} ${unavailableBadge}</div>
                        ${subtitle ? `<div class="search-result-subtitle">${subtitle}</div>` : ''}
                    </div>
                </a>
            </div>
        `;
    }

    getTypeIcon(type) {
        return this.icons[type] || this.icons.tema;
    }

    getSubtitle(item) {
        const parts = [];
        
        if (item.ejercicio) {
            parts.push(item.ejercicio);
        }
        
        if (item.grupo) {
            parts.push(item.grupo);
        }
        
        if (item.description) {
            parts.push(item.description);
        }
        
        if (item.category) {
            parts.push(item.category);
        }
        
        return parts.join(' › ');
    }

    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
}

// Inicializar cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
    const searchUI = new SearchUI();
    searchUI.initialize();
});
