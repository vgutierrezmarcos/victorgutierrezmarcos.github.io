// Enlaces con los que se abre la app (invitación de un preparador):
//   - Android: el enlace `https://www.victorgutierrezmarcos.es/app/…` que abrió
//     la app (App Links) y los que llegan con la app ya abierta, más el
//     `referrer` de Google Play de una instalación hecha desde la invitación.
//   - Navegador: la dirección con la que se ha abierto la app web.
export 'enlaces_io.dart' if (dart.library.js_interop) 'enlaces_web.dart';
