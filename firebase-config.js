// Configuración de Firebase
// IMPORTANTE: Reemplaza estos valores con los de tu proyecto de Firebase
// 1. Ve a https://console.firebase.google.com/
// 2. Crea un nuevo proyecto
// 3. Añade una app web
// 4. Copia la configuración (firebaseConfig) y pégala aquí

const firebaseConfig = {
  apiKey: "AIzaSyCcNHY3IkriyV1lUejtL3qDn8luklhRo3o",
  authDomain: "web-vgm.firebaseapp.com",
  projectId: "web-vgm",
  storageBucket: "web-vgm.firebasestorage.app",
  messagingSenderId: "1092815793613",
  appId: "1:1092815793613:web:e9cb4a3d669bede8696884"
};

// Inicializar Firebase (se cargará desde los scripts en el HTML)
// Las librerías de Firebase se cargarán vía CDN en los archivos HTML

// Oposición de esta web. Decide dónde se guardan los datos de cada usuario en
// Firestore (el mismo proyecto lo comparten la app y las webs de TCEE y DCE):
// TCEE, en la raíz users/{uid}; cualquier otra, en users/{uid}/oposiciones/{id}.
// La web de DCE pone aquí 'dce'.
const OPOSICION_WEB = 'tcee';

// Documento raíz de los datos del usuario en la oposición de esta web.
function docUsuario(db, uid) {
  const usuario = db.collection('users').doc(uid);
  return OPOSICION_WEB === 'tcee' ? usuario : usuario.collection('oposiciones').doc(OPOSICION_WEB);
}
