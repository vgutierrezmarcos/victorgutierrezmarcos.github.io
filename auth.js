// Lógica de Autenticación y Gestión de Usuarios con Firebase

// Referencias al DOM
let loginButton;
let userProfileSection;

// Función para inicializar la autenticación
function initAuth() {
    // Verificar si firebase está cargado
    if (typeof firebase === 'undefined') {
        console.error('Firebase SDK no cargado');
        return;
    }

    // Inicializar Firebase si no está inicializado
    if (!firebase.apps.length) {
        firebase.initializeApp(firebaseConfig);
    }

    // Referencia a Auth
    const auth = firebase.auth();
    const provider = new firebase.auth.GoogleAuthProvider();

    // Configurar persistencia (aunque por defecto es local)
    auth.setPersistence(firebase.auth.Auth.Persistence.LOCAL);

    // Observador de estado de autenticación
    auth.onAuthStateChanged((user) => {
        if (user) {
            console.log('Usuario conectado:', user.displayName);
            updateUIForLogin(user);
            // Si estamos en el simulador, cargar historial (si existe la función)
            if (typeof loadUserHistory === 'function') {
                loadUserHistory(user.uid);
            }
        } else {
            console.log('Usuario desconectado');
            updateUIForLogout();
        }
    });

    // Inyectar botón de login en el menú
    injectLoginButton(auth, provider);
}

// Función para inyectar el botón en la navegación
function injectLoginButton(auth, provider) {
    // Crear botón de login
    function createAuthButton() {
        const btn = document.createElement('button');
        btn.className = 'auth-btn';
        btn.innerHTML = `
            <span class="auth-icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg></span>
            <span class="auth-text">Acceder</span>
        `;

        btn.addEventListener('click', () => {
            const currentUser = auth.currentUser;
            if (currentUser) {
                showProfileModal(currentUser, auth);
            } else {
                auth.signInWithPopup(provider).then((result) => {
                    // Login exitoso
                }).catch((error) => {
                    console.error('Error en login:', error);
                    alert('Error al iniciar sesión: ' + error.message);
                });
            }
        });
        return btn;
    }

    // Try standard nav-list first
    const navList = document.querySelector('.nav-list');
    if (navList) {
        const li = document.createElement('li');
        li.id = 'auth-nav-item';
        li.className = 'nav-right-item';
        const btn = createAuthButton();
        li.appendChild(btn);
        // «Acceder» va antes que «Buscar», aunque el buscador se haya puesto antes
        const buscar = document.getElementById('open-search');
        navList.insertBefore(li, buscar ? buscar.closest('li') : null);
        loginButton = btn;
        return;
    }

    // Try blog auth container
    const blogAuthContainer = document.getElementById('blog-auth-container');
    if (blogAuthContainer) {
        const btn = createAuthButton();
        blogAuthContainer.appendChild(btn);
        loginButton = btn;
        return;
    }
}

// Actualizar UI cuando hay login
function updateUIForLogin(user) {
    if (loginButton) {
        const authText = loginButton.querySelector('.auth-text');
        const authIcon = loginButton.querySelector('.auth-icon');
        if (authText) authText.textContent = user.displayName.split(' ')[0]; // Primer nombre
        if (user.photoURL) {
            authIcon.innerHTML = `<img src="${user.photoURL}" alt="Perfil" style="width:20px;height:20px;border-radius:50%;">`;
            authIcon.textContent = '';
        }
        loginButton.classList.add('logged-in');
    }
}

// Actualizar UI cuando hay logout
function updateUIForLogout() {
    if (loginButton) {
        const authText = loginButton.querySelector('.auth-text');
        const authIcon = loginButton.querySelector('.auth-icon');
        if (authText) authText.textContent = 'Acceder';
        if (authIcon) authIcon.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>';
        loginButton.classList.remove('logged-in');
    }
}

// Mostrar modal de perfil
function showProfileModal(user, auth) {
    // Crear modal si no existe
    let modal = document.getElementById('profile-modal');
    if (!modal) {
        modal = document.createElement('div');
        modal.id = 'profile-modal';
        modal.className = 'profile-modal';
        document.body.appendChild(modal);
    }

    // Verificar si el usuario ya está suscrito a la newsletter
    function isEmailSubscribed(email) {
        if (!email) return false;
        try {
            const emails = localStorage.getItem('newsletter_subscribed_emails');
            const subscribedEmails = emails ? JSON.parse(emails) : [];
            return subscribedEmails.includes(email.toLowerCase().trim());
        } catch (e) {
            return false;
        }
    }
    const isSubscribed = localStorage.getItem('newsletter_subscribed') === 'true' || isEmailSubscribed(user.email);

    modal.innerHTML = `
        <div class="profile-content profile-content-extended">
            <span class="close-profile">&times;</span>
            <div class="profile-header">
                <img src="${user.photoURL || 'https://via.placeholder.com/50'}" alt="Perfil">
                <h3>${user.displayName}</h3>
                <p>${user.email}</p>
            </div>
            <div class="profile-actions">
                <button id="btn-show-history" class="profile-action-btn">
                    <span class="btn-icon"><svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 20h16"/><path d="M7 16v-4"/><path d="M12 16V7"/><path d="M17 16v-7"/></svg></span>
                    <span class="btn-text">Historial de exámenes</span>
                </button>
                <a href="/oposicion/temario/primer-ejercicio/test/simulador.html" class="profile-action-btn">
                    <span class="btn-icon"><svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="5" y="3.5" width="14" height="17" rx="2"/><path d="m8.5 9.5 1.5 1.5 3-3"/><path d="M8.5 15.5h7"/></svg></span>
                    <span class="btn-text">Ir al simulador</span>
                </a>
                <div class="profile-divider"></div>
                <div id="newsletter-section" class="newsletter-profile-section">
                    ${isSubscribed ? `
                        <div class="newsletter-subscribed">
                            <span class="subscribed-icon"><svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="9"/><path d="m8.5 12.2 2.4 2.4 4.6-5"/></svg></span>
                            <div class="subscribed-info">
                                <span class="subscribed-text">Suscrito a la newsletter</span>
                                <span class="subscribed-thanks">¡Gracias por tu apoyo!</span>
                            </div>
                        </div>
                    ` : `
                        <button id="btn-subscribe-newsletter" class="profile-action-btn newsletter-btn">
                            <span class="btn-icon"><svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="3" y="5.5" width="18" height="13" rx="2"/><path d="m3.5 7 8.5 6 8.5-6"/></svg></span>
                            <span class="btn-text">Suscribirse a la newsletter</span>
                        </button>
                    `}
                </div>
                <div class="profile-divider"></div>
                <button id="btn-logout" class="profile-action-btn logout">Cerrar sesión</button>
            </div>
        </div>
    `;

    modal.style.display = 'block';

    // Event listeners del modal
    modal.querySelector('.close-profile').onclick = () => modal.style.display = 'none';

    // Cerrar al hacer clic fuera
    window.onclick = (event) => {
        if (event.target == modal) {
            modal.style.display = 'none';
        }
    };

    modal.querySelector('#btn-logout').onclick = () => {
        auth.signOut();
        modal.style.display = 'none';
    };

    // Historial de exámenes - siempre disponible
    const btnHistory = modal.querySelector('#btn-show-history');
    if (btnHistory) {
        btnHistory.onclick = () => {
            modal.style.display = 'none';
            showUserHistoryFromProfile();
        };
    }

    // Suscripción a newsletter
    const btnNewsletter = modal.querySelector('#btn-subscribe-newsletter');
    if (btnNewsletter) {
        btnNewsletter.onclick = () => {
            showNewsletterSubscriptionModal(user, modal);
        };
    }
}

// Mostrar historial de exámenes desde el perfil (carga Firebase Firestore si es necesario)
// Firestore (unos 300 KB) solo hace falta para el historial: se carga al
// abrirlo, no en cada página. El simulador sí lo trae desde el principio.
function cargarFirestore() {
    if (firebase.firestore) return Promise.resolve();
    if (!cargarFirestore.promesa) {
        cargarFirestore.promesa = new Promise((resolve, reject) => {
            const script = document.createElement('script');
            script.src = 'https://www.gstatic.com/firebasejs/8.10.1/firebase-firestore.js';
            script.onload = resolve;
            script.onerror = () => { cargarFirestore.promesa = null; reject(new Error('No se pudo cargar Firestore')); };
            document.head.appendChild(script);
        });
    }
    return cargarFirestore.promesa;
}

async function showUserHistoryFromProfile() {
    const user = firebase.auth().currentUser;
    if (!user) {
        alert('Debes iniciar sesión para ver tu historial.');
        return;
    }

    // Crear modal de historial
    let modal = document.getElementById('history-modal');
    if (!modal) {
        modal = document.createElement('div');
        modal.id = 'history-modal';
        modal.className = 'profile-modal';
        document.body.appendChild(modal);
    }

    modal.style.display = 'block';
    modal.innerHTML = `
        <div class="profile-content history-content">
            <span class="close-profile" onclick="document.getElementById('history-modal').style.display='none'">&times;</span>
            <h3 class="history-title">Tu historial de exámenes</h3>
            <div id="history-loading" class="history-loading">
                <div class="loading-spinner"></div>
                <p>Cargando datos...</p>
            </div>
            <div id="history-list" class="history-list"></div>
        </div>
    `;

    // Cerrar al hacer clic fuera
    modal.onclick = (event) => {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    };

    try {
        await cargarFirestore();
        const db = firebase.firestore();
        const snapshot = await docUsuario(db, user.uid).collection('exam_results')
            .orderBy('timestamp', 'desc')
            .limit(20)
            .get();

        const listContainer = document.getElementById('history-list');
        const loadingEl = document.getElementById('history-loading');
        if (loadingEl) loadingEl.style.display = 'none';

        if (snapshot.empty) {
            listContainer.innerHTML = `
                <div class="history-empty">
                    <span class="empty-icon"><svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="5" y="4.5" width="14" height="16" rx="2"/><path d="M9 4.5V3.5h6v1"/><path d="M8.5 10h7M8.5 14h5"/></svg></span>
                    <p>Aún no has realizado ningún examen.</p>
                    <a href="/oposicion/temario/primer-ejercicio/test/simulador.html" class="profile-action-btn">Realizar mi primer examen</a>
                </div>
            `;
            return;
        }

        let html = `
            <div class="history-table-wrapper">
                <table class="history-table">
                    <thead>
                        <tr>
                            <th>Fecha</th>
                            <th>Nota</th>
                            <th>Aciertos</th>
                            <th>Tiempo</th>
                        </tr>
                    </thead>
                    <tbody>
        `;

        snapshot.forEach(doc => {
            const data = doc.data();
            const date = data.timestamp
                ? data.timestamp.toDate().toLocaleDateString('es-ES', { day: '2-digit', month: 'short', year: 'numeric' })
                : 'Sin fecha';
            const time = data.timestamp
                ? data.timestamp.toDate().toLocaleTimeString('es-ES', { hour: '2-digit', minute: '2-digit' })
                : '';
            const scoreClass = data.notaSobre10 >= 5 ? 'score-pass' : 'score-fail';
            const minutes = Math.floor((data.tiempoSeconds || 0) / 60);
            const seconds = (data.tiempoSeconds || 0) % 60;

            // Format score with comma as decimal separator
            const scoreFormatted = data.notaSobre10.toFixed(2).replace('.', ',');

            html += `
                <tr>
                    <td>
                        <span class="date-main">${date}</span>
                        <span class="date-time">${time}</span>
                    </td>
                    <td class="${scoreClass}">${scoreFormatted}</td>
                    <td>${data.correctas}/${data.totalPreguntas}</td>
                    <td>${minutes}m ${seconds}s</td>
                </tr>
            `;
        });

        html += '</tbody></table></div>';

        // Botón de borrar historial
        html += `
            <div style="margin-top: 2rem; text-align: center; padding-top: 1rem; border-top: 1px solid var(--color-border-light);">
                <button id="btn-delete-history" class="profile-action-btn logout" style="background: #ffebee; color: #d32f2f; border: 1px solid #ffcdd2; width: auto; padding: 0.5rem 1rem; font-size: 0.9rem;">
                    <svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4.5 7h15"/><path d="M9.5 7V4.5h5V7"/><path d="M6.5 7l.8 12.5h9.4l.8-12.5"/><path d="M10 11v5M14 11v5"/></svg> Borrar todo el historial
                </button>
            </div>
        `;
        
        listContainer.innerHTML = html;

        // Event listener para borrar
        const btnDelete = document.getElementById('btn-delete-history');
        if (btnDelete) {
            btnDelete.onclick = () => deleteUserHistory(user.uid);
        }

    } catch (error) {
        console.error('Error cargando historial:', error);
        const loadingEl = document.getElementById('history-loading');
        if (loadingEl) {
            loadingEl.innerHTML = '<p class="history-error">Error al cargar el historial. Inténtalo de nuevo.</p>';
        }
    }
}

// Mostrar modal de suscripción a newsletter
function showNewsletterSubscriptionModal(user, parentModal) {
    // Ocultar el modal de perfil
    if (parentModal) parentModal.style.display = 'none';

    let modal = document.getElementById('newsletter-modal');
    if (!modal) {
        modal = document.createElement('div');
        modal.id = 'newsletter-modal';
        modal.className = 'profile-modal';
        document.body.appendChild(modal);
    }

    modal.innerHTML = `
        <div class="profile-content newsletter-modal-content">
            <span class="close-profile" onclick="document.getElementById('newsletter-modal').style.display='none'">&times;</span>
            <div class="newsletter-header">
                <span class="newsletter-icon"><svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="3" y="5.5" width="18" height="13" rx="2"/><path d="m3.5 7 8.5 6 8.5-6"/></svg></span>
                <h3>Suscríbete a la Newsletter</h3>
                <p>Recibe los nuevos artículos directamente en tu correo.</p>
            </div>
            <form id="profile-newsletter-form" class="newsletter-form">
                <div class="form-group">
                    <label for="newsletter-email">Correo electrónico</label>
                    <input type="email" id="newsletter-email" value="${user.email}" required readonly>
                </div>
                <button type="submit" class="newsletter-submit-btn">
                    <span class="btn-text">Suscribirse</span>
                    <span class="btn-loading" style="display: none;">Procesando...</span>
                </button>
                <p class="newsletter-privacy">Al suscribirte, aceptas recibir correos electrónicos con novedades del blog.</p>
            </form>
            <div id="newsletter-success" class="newsletter-success" style="display: none;">
                <span class="success-icon"><svg class="icono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="9"/><path d="m8.5 12.2 2.4 2.4 4.6-5"/></svg></span>
                <h4>¡Suscripción completada!</h4>
                <p>Revisa tu correo para confirmar la suscripción.</p>
                <button onclick="document.getElementById('newsletter-modal').style.display='none'" class="profile-action-btn">Cerrar</button>
            </div>
        </div>
    `;

    modal.style.display = 'block';

    // Cerrar al hacer clic fuera
    modal.onclick = (event) => {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    };

    // Manejar el envío del formulario
    const form = document.getElementById('profile-newsletter-form');
    form.onsubmit = async (e) => {
        e.preventDefault();
        const email = document.getElementById('newsletter-email').value;
        const submitBtn = form.querySelector('.newsletter-submit-btn');
        const btnText = submitBtn.querySelector('.btn-text');
        const btnLoading = submitBtn.querySelector('.btn-loading');

        btnText.style.display = 'none';
        btnLoading.style.display = 'inline';
        submitBtn.disabled = true;

        try {
            // Enviar a Brevo usando su API de formulario
            const formData = new FormData();
            formData.append('EMAIL', email);
            formData.append('locale', 'es');

            const response = await fetch('https://6de5a6a5.sibforms.com/serve/MUIFAHXAnoppQR8yHbmoRtq33MhK50ZI1iOJ-8sBBF8_WXTDC59dhFe2-PVOSw3Hr7WQ0oy3ln_lnCztp1v6uuv0v4YY9WzHdtrRAd-sXrbsadRIFPHVPi06HwxZafAqdvWdtLKM6R80la-Ftjc6CGc56jbrcyzdn4iqrUY-qjSU8q5RF6JD46GYRng3vYmHFi54OZvl_Xw0_udNcg==', {
                method: 'POST',
                body: formData
            });

            // Marcar como suscrito en localStorage
            localStorage.setItem('newsletter_subscribed', 'true');

            // Mostrar mensaje de éxito
            form.style.display = 'none';
            document.getElementById('newsletter-success').style.display = 'block';

        } catch (error) {
            console.error('Error al suscribirse:', error);
            alert('Hubo un error al procesar tu suscripción. Inténtalo de nuevo.');
            btnText.style.display = 'inline';
            btnLoading.style.display = 'none';
            submitBtn.disabled = false;
        }
    };
}

// Esperar a que el DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
    // Esperar un poco para asegurar que las librerías de Firebase se carguen si se inyectan dinámicamente
    // O si están en el head, initAuth se puede llamar directamente.
    // Para seguridad, comprobamos cada poco tiempo si firebase está listo
    const checkFirebase = setInterval(() => {
        if (typeof firebase !== 'undefined' && typeof firebaseConfig !== 'undefined') {
            clearInterval(checkFirebase);
            initAuth();
        }
    }, 100);
});

// Borrar todo el historial del usuario
async function deleteUserHistory(uid) {
    if (!confirm('¿Estás seguro de que quieres borrar TODO tu historial de exámenes?\n\nEsta acción eliminará permanentemente todos tus resultados guardados y no se puede deshacer.')) {
        return;
    }

    const listContainer = document.getElementById('history-list');
    const loadingEl = document.getElementById('history-loading');
    
    // Mostrar loading
    if (listContainer) listContainer.style.display = 'none';
    if (loadingEl) {
        loadingEl.style.display = 'block';
        loadingEl.innerHTML = '<div class="loading-spinner"></div><p>Borrando historial...</p>';
    }

    try {
        await cargarFirestore();
        const db = firebase.firestore();
        // Obtener todos los resultados (sin límite)
        const snapshot = await docUsuario(db, uid).collection('exam_results').get();
        
        if (snapshot.empty) {
            showUserHistoryFromProfile();
            return;
        }

        // Borrar en lotes (batches) de 500 (límite de Firestore)
        const batchSize = 500;
        const docs = snapshot.docs;
        const chunks = [];

        for (let i = 0; i < docs.length; i += batchSize) {
            const chunk = docs.slice(i, i + batchSize);
            const batch = db.batch();
            chunk.forEach(doc => batch.delete(doc.ref));
            chunks.push(batch.commit());
        }

        await Promise.all(chunks);
        
        // Recargar vista
        showUserHistoryFromProfile();
        alert('Historial borrado correctamente.');

    } catch (error) {
        console.error('Error al borrar historial:', error);
        alert('Hubo un error al intentar borrar el historial: ' + error.message);
        
        // Restaurar vista recargándola
        showUserHistoryFromProfile();
    }
}
