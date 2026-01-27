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
    const navList = document.querySelector('.nav-list');
    if (!navList) return;

    // Crear elemento de lista para el login
    const li = document.createElement('li');
    li.id = 'auth-nav-item';
    li.className = 'nav-right-item'; // Clase para alineación a la derecha
    
    // Botón de login
    const btn = document.createElement('button');
    btn.className = 'auth-btn';
    btn.innerHTML = `
        <span class="auth-icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg></span>
        <span class="auth-text">Acceder</span>
    `;
    
    btn.addEventListener('click', () => {
        const currentUser = auth.currentUser;
        if (currentUser) {
            // Si ya está logueado, mostrar menú de perfil (o cerrar sesión por simplicidad inicial)
            // Aquí podríamos abrir un modal con historial y botón de logout
            showProfileModal(currentUser, auth);
        } else {
            // Iniciar sesión
            auth.signInWithPopup(provider).then((result) => {
                // Login exitoso
            }).catch((error) => {
                console.error('Error en login:', error);
                alert('Error al iniciar sesión: ' + error.message);
            });
        }
    });

    li.appendChild(btn);
    navList.appendChild(li);
    loginButton = btn;
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

    // Verificar si el usuario ya está suscrito a la newsletter (guardado en localStorage)
    const isSubscribed = localStorage.getItem('newsletter_subscribed') === 'true';

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
                    <span class="btn-icon">📊</span>
                    <span class="btn-text">Historial de exámenes</span>
                </button>
                <a href="/oposicion/temario/primer-ejercicio/test/simulador.html" class="profile-action-btn">
                    <span class="btn-icon">📝</span>
                    <span class="btn-text">Ir al simulador</span>
                </a>
                <div class="profile-divider"></div>
                <div id="newsletter-section" class="newsletter-profile-section">
                    ${isSubscribed ? `
                        <div class="newsletter-subscribed">
                            <span class="subscribed-icon">✅</span>
                            <span class="subscribed-text">Suscrito a la newsletter</span>
                        </div>
                    ` : `
                        <button id="btn-subscribe-newsletter" class="profile-action-btn newsletter-btn">
                            <span class="btn-icon">📬</span>
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
            <h3 class="history-title">📊 Tu historial de exámenes</h3>
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
        const db = firebase.firestore();
        const snapshot = await db.collection('users').doc(user.uid).collection('exam_results')
            .orderBy('timestamp', 'desc')
            .limit(20)
            .get();

        const listContainer = document.getElementById('history-list');
        const loadingEl = document.getElementById('history-loading');
        if (loadingEl) loadingEl.style.display = 'none';

        if (snapshot.empty) {
            listContainer.innerHTML = `
                <div class="history-empty">
                    <span class="empty-icon">📋</span>
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

            html += `
                <tr>
                    <td>
                        <span class="date-main">${date}</span>
                        <span class="date-time">${time}</span>
                    </td>
                    <td class="${scoreClass}">${data.notaSobre10.toFixed(2)}</td>
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
                    🗑️ Borrar todo el historial
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
                <span class="newsletter-icon">📬</span>
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
                <span class="success-icon">✅</span>
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
        const db = firebase.firestore();
        // Obtener todos los resultados (sin límite)
        const snapshot = await db.collection('users').doc(uid).collection('exam_results').get();
        
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
