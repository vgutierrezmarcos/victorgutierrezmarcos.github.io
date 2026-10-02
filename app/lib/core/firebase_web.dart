import 'package:firebase_core/firebase_core.dart';

/// Configuración de Firebase para la versión web: la misma app web del
/// proyecto web-vgm que usa victorgutierrezmarcos.es (firebase-config.js).
/// Estos valores son públicos; lo que protege los datos son las reglas de
/// firestore.rules.
const opcionesFirebaseWeb = FirebaseOptions(
  apiKey: 'AIzaSyCcNHY3IkriyV1lUejtL3qDn8luklhRo3o',
  authDomain: 'web-vgm.firebaseapp.com',
  projectId: 'web-vgm',
  storageBucket: 'web-vgm.firebasestorage.app',
  messagingSenderId: '1092815793613',
  appId: '1:1092815793613:web:e9cb4a3d669bede8696884',
);
