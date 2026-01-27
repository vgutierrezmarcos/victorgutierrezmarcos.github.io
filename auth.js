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
        <span class="auth-icon">👤</span>
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
        if (authIcon) authIcon.textContent = '👤';
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

    modal.innerHTML = `
        <div class="profile-content">
            <span class="close-profile">&times;</span>
            <div class="profile-header">
                <img src="${user.photoURL || 'https://via.placeholder.com/50'}" alt="Perfil">
                <h3>${user.displayName}</h3>
                <p>${user.email}</p>
            </div>
            <div class="profile-actions">
                ${window.location.href.includes('simulador') ? 
                    '<button id="btn-show-history" class="profile-action-btn">📊 Ver mi historial de exámenes</button>' : 
                    '<a href="/oposicion/temario/primer-ejercicio/test/simulador.html" class="profile-action-btn">📝 Ir al simulador</a>'
                }
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

    const btnHistory = modal.querySelector('#btn-show-history');
    if (btnHistory) {
        btnHistory.onclick = () => {
            modal.style.display = 'none';
            // Disparar evento o llamar función para mostrar historial en el simulador
            if (typeof showUserHistoryUI === 'function') {
                showUserHistoryUI();
            }
        };
    }
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
