/* ==========================================================================
   COOKIE CONSENT - Cumplimiento RGPD
   Víctor Gutiérrez Marcos - victorgutierrezmarcos.es
   ========================================================================== */

(function() {
    'use strict';

    // Configuración - REEMPLAZA CON TU ID DE GOOGLE ANALYTICS
    const GA_MEASUREMENT_ID = 'G-ZC63ML9ECJ'; // ← Cambia esto por tu ID real

    // Nombres de las cookies
    const CONSENT_COOKIE = 'vgm_cookie_consent';
    const CONSENT_VERSION = '1.0';

    // Estado del consentimiento
    const ConsentManager = {
        
        // Verificar si ya hay consentimiento guardado
        hasConsent: function() {
            return this.getConsent() !== null;
        },

        // Obtener el consentimiento actual
        getConsent: function() {
            try {
                const consent = localStorage.getItem(CONSENT_COOKIE);
                if (consent) {
                    const parsed = JSON.parse(consent);
                    // Verificar versión
                    if (parsed.version === CONSENT_VERSION) {
                        return parsed;
                    }
                }
            } catch (e) {
                console.error('Error leyendo consentimiento:', e);
            }
            return null;
        },

        // Guardar consentimiento
        saveConsent: function(analytics, preferences) {
            const consent = {
                version: CONSENT_VERSION,
                timestamp: new Date().toISOString(),
                analytics: analytics,
                preferences: preferences
            };
            try {
                localStorage.setItem(CONSENT_COOKIE, JSON.stringify(consent));
            } catch (e) {
                console.error('Error guardando consentimiento:', e);
            }
            return consent;
        },

        // Eliminar consentimiento
        revokeConsent: function() {
            try {
                localStorage.removeItem(CONSENT_COOKIE);
                // Eliminar cookies de Google Analytics
                this.deleteGACookies();
            } catch (e) {
                console.error('Error eliminando consentimiento:', e);
            }
        },

        // Eliminar cookies de Google Analytics
        deleteGACookies: function() {
            const domain = window.location.hostname;
            const cookies = document.cookie.split(';');
            
            cookies.forEach(function(cookie) {
                const name = cookie.split('=')[0].trim();
                if (name.startsWith('_ga') || name.startsWith('_gid') || name.startsWith('_gat')) {
                    document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
                    document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/; domain=' + domain;
                    document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/; domain=.' + domain;
                }
            });
        }
    };

    // Gestión de Google Analytics
    const Analytics = {
        loaded: false,

        // Cargar Google Analytics
        load: function() {
            if (this.loaded) return;
            if (GA_MEASUREMENT_ID === 'G-XXXXXXXXXX') {
                console.warn('Cookie Consent: Configura tu ID de Google Analytics en cookie-consent.js');
                return;
            }

            // Crear y añadir el script de gtag
            const script = document.createElement('script');
            script.async = true;
            script.src = 'https://www.googletagmanager.com/gtag/js?id=' + GA_MEASUREMENT_ID;
            document.head.appendChild(script);

            // Inicializar gtag
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            window.gtag = gtag;
            gtag('js', new Date());
            
            // Configurar con anonimización de IP (recomendado para RGPD)
            gtag('config', GA_MEASUREMENT_ID, {
                'anonymize_ip': true,
                'cookie_flags': 'SameSite=None;Secure'
            });

            this.loaded = true;
            console.log('Google Analytics cargado');
        },

        // Desactivar seguimiento
        disable: function() {
            window['ga-disable-' + GA_MEASUREMENT_ID] = true;
        }
    };

    // Interfaz de usuario del banner
    const BannerUI = {
        
        // Crear el banner
        create: function() {
            const banner = document.createElement('div');
            banner.id = 'cookie-consent-banner';
            banner.className = 'cookie-banner';
            banner.setAttribute('role', 'dialog');
            banner.setAttribute('aria-labelledby', 'cookie-banner-title');
            banner.setAttribute('aria-describedby', 'cookie-banner-description');
            
            banner.innerHTML = `
                <div class="cookie-banner-content">
                    <div class="cookie-banner-text">
                        <h3 id="cookie-banner-title">🍪 Uso de cookies y almacenamiento local</h3>
                        <p id="cookie-banner-description">
                            Este sitio web utiliza cookies y tecnologías similares (localStorage) para: gestionar
                            tu sesión de usuario si inicias sesión con Google, almacenar tus preferencias, y con tu
                            consentimiento, analizar el tráfico mediante Google Analytics. Puedes aceptar, rechazar
                            o configurar tus preferencias.
                        </p>
                        <a href="/politica-cookies.html" class="cookie-link">Más información sobre cookies y privacidad</a>
                    </div>

                    <div class="cookie-banner-actions">
                        <button id="cookie-accept-all" class="cookie-btn cookie-btn-primary">
                            Aceptar todas
                        </button>
                        <button id="cookie-reject-all" class="cookie-btn cookie-btn-secondary">
                            Solo esenciales
                        </button>
                        <button id="cookie-customize" class="cookie-btn cookie-btn-link">
                            Configurar
                        </button>
                    </div>
                </div>
            `;
            
            document.body.appendChild(banner);
            this.bindEvents(banner);
            
            // Mostrar con animación
            requestAnimationFrame(function() {
                banner.classList.add('cookie-banner-visible');
            });
            
            return banner;
        },

        // Crear modal de configuración
        createSettingsModal: function() {
            const modal = document.createElement('div');
            modal.id = 'cookie-settings-modal';
            modal.className = 'cookie-modal';
            modal.setAttribute('role', 'dialog');
            modal.setAttribute('aria-modal', 'true');
            modal.setAttribute('aria-labelledby', 'cookie-settings-title');
            
            const consent = ConsentManager.getConsent();
            const analyticsChecked = consent ? consent.analytics : false;
            
            modal.innerHTML = `
                <div class="cookie-modal-overlay"></div>
                <div class="cookie-modal-content">
                    <h3 id="cookie-settings-title">Configuración de cookies y almacenamiento</h3>

                    <div class="cookie-category">
                        <div class="cookie-category-header">
                            <div class="cookie-category-info">
                                <h4>Esenciales y funcionales</h4>
                                <p>Necesarias para el funcionamiento del sitio: preferencias de cookies,
                                   sesión de usuario (si inicias sesión con Google), y estado de banners.
                                   No se pueden desactivar.</p>
                            </div>
                            <label class="cookie-toggle cookie-toggle-disabled">
                                <input type="checkbox" checked disabled>
                                <span class="cookie-toggle-slider"></span>
                            </label>
                        </div>
                    </div>

                    <div class="cookie-category">
                        <div class="cookie-category-header">
                            <div class="cookie-category-info">
                                <h4>Cookies de análisis</h4>
                                <p>Nos permiten medir el tráfico y analizar cómo se usa el sitio para mejorarlo.
                                   Utilizamos Google Analytics con IP anonimizada.</p>
                            </div>
                            <label class="cookie-toggle">
                                <input type="checkbox" id="cookie-analytics-toggle" ${analyticsChecked ? 'checked' : ''}>
                                <span class="cookie-toggle-slider"></span>
                            </label>
                        </div>
                    </div>

                    <div class="cookie-modal-actions">
                        <button id="cookie-save-settings" class="cookie-btn cookie-btn-primary">
                            Guardar preferencias
                        </button>
                        <button id="cookie-close-settings" class="cookie-btn cookie-btn-secondary">
                            Cancelar
                        </button>
                    </div>
                </div>
            `;
            
            document.body.appendChild(modal);
            this.bindModalEvents(modal);
            
            // Mostrar con animación
            requestAnimationFrame(function() {
                modal.classList.add('cookie-modal-visible');
            });
            
            // Focus trap
            modal.querySelector('#cookie-analytics-toggle').focus();
            
            return modal;
        },

        // Vincular eventos del banner
        bindEvents: function(banner) {
            const self = this;
            
            banner.querySelector('#cookie-accept-all').addEventListener('click', function() {
                ConsentManager.saveConsent(true, true);
                Analytics.load();
                self.hideBanner();
            });
            
            banner.querySelector('#cookie-reject-all').addEventListener('click', function() {
                ConsentManager.saveConsent(false, false);
                Analytics.disable();
                self.hideBanner();
            });
            
            banner.querySelector('#cookie-customize').addEventListener('click', function() {
                self.createSettingsModal();
            });
        },

        // Vincular eventos del modal
        bindModalEvents: function(modal) {
            const self = this;
            
            modal.querySelector('#cookie-save-settings').addEventListener('click', function() {
                const analyticsEnabled = modal.querySelector('#cookie-analytics-toggle').checked;
                ConsentManager.saveConsent(analyticsEnabled, true);
                
                if (analyticsEnabled) {
                    Analytics.load();
                } else {
                    Analytics.disable();
                    ConsentManager.deleteGACookies();
                }
                
                self.hideModal();
                self.hideBanner();
            });
            
            modal.querySelector('#cookie-close-settings').addEventListener('click', function() {
                self.hideModal();
            });
            
            modal.querySelector('.cookie-modal-overlay').addEventListener('click', function() {
                self.hideModal();
            });
            
            // Cerrar con Escape
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape' && modal.classList.contains('cookie-modal-visible')) {
                    self.hideModal();
                }
            });
        },

        // Ocultar banner
        hideBanner: function() {
            const banner = document.getElementById('cookie-consent-banner');
            if (banner) {
                banner.classList.remove('cookie-banner-visible');
                setTimeout(function() {
                    banner.remove();
                }, 300);
            }
        },

        // Ocultar modal
        hideModal: function() {
            const modal = document.getElementById('cookie-settings-modal');
            if (modal) {
                modal.classList.remove('cookie-modal-visible');
                setTimeout(function() {
                    modal.remove();
                }, 300);
            }
        }
    };

    // Botón flotante para cambiar preferencias (opcional)
    const FloatingButton = {
        create: function() {
            const button = document.createElement('button');
            button.id = 'cookie-settings-button';
            button.className = 'cookie-settings-floating';
            button.setAttribute('aria-label', 'Configurar cookies');
            button.innerHTML = '🍪';
            button.title = 'Configurar cookies';
            
            button.addEventListener('click', function() {
                BannerUI.createSettingsModal();
            });
            
            document.body.appendChild(button);
        }
    };

    // Inicialización
    function init() {
        const consent = ConsentManager.getConsent();
        
        if (consent === null) {
            // No hay consentimiento: mostrar banner
            BannerUI.create();
        } else {
            // Hay consentimiento guardado
            if (consent.analytics) {
                Analytics.load();
            } else {
                Analytics.disable();
            }
            // Mostrar botón flotante para cambiar preferencias
            FloatingButton.create();
        }
    }

    // Exponer API pública para poder gestionar cookies desde otros scripts
    window.CookieConsent = {
        showSettings: function() {
            BannerUI.createSettingsModal();
        },
        revokeConsent: function() {
            ConsentManager.revokeConsent();
            BannerUI.create();
            const floatingBtn = document.getElementById('cookie-settings-button');
            if (floatingBtn) floatingBtn.remove();
        },
        getConsent: function() {
            return ConsentManager.getConsent();
        }
    };

    // Iniciar cuando el DOM esté listo
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }

})();
