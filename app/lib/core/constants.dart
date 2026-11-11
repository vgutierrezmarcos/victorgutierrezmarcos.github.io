import 'package:flutter/foundation.dart';

/// URLs de la web victorgutierrezmarcos.es que no dependen de la oposición.
/// Las del contenido (preguntas, temario…) son de cada oposición: ver
/// `Oposicion` en data/models/oposicion.dart.
class Urls {
  Urls._();

  /// La web. En la versión para el navegador, su mismo origen: así las
  /// descargas no son peticiones entre dominios (y en pruebas locales se lee
  /// el repositorio servido en localhost).
  static final String base = kIsWeb ? Uri.base.origin : 'https://www.victorgutierrezmarcos.es';
  static final String politicaPrivacidad = '$base/politica-cookies.html';
  static final String condiciones = '$base/app/condiciones.html';
  static final String sobreMi = '$base/sobre-mi.html';
  static final String paginaApp = '$base/app/';
  /// Un vídeo de ayuda (sección «Cómo se usa» de la página de la app).
  static String videoAyuda(String id) => '$paginaApp#ayuda-$id';
  /// Registro de los vídeos de YouTube: clave → vídeo vigente (scripts/youtube.py).
  static final String videos = '$base/videos.json';
  /// La misma app, compilada para el navegador.
  static final String appWeb = '$base/app/abrir/';

  /// EconomIA: la página del equipo de preparación con IA y la dirección del
  /// conector «Oposición TCEE · DCE» (Claude, Le Chat, ChatGPT y Gemini).
  static final String economia = '$base/oposicion/economia.html';
  static const String conectorIa = 'https://mcp.victorgutierrezmarcos.es/mcp';

  /// Enlace de invitación de un preparador: en Android abre la app si está
  /// instalada (App Links) y, si no, la página de la app lleva a Google Play
  /// con el código como `referrer`; en iPhone y ordenador, a la app web. La
  /// app lee `codigo` y `op` (core/invitacion.dart).
  static String invitacion(String codigo, String oposicion) => '$paginaApp?codigo=$codigo&op=$oposicion';
}

/// Nombre de la app y quién la ha hecho (pie de Más).
class Creditos {
  Creditos._();

  static const String nombreApp = 'Oposición TCEE · DCE';

  static const String desarrolladores = 'Víctor Gutiérrez Marcos y Manuel Cabado García';
}

/// Valores por defecto del simulador (idénticos a simulador.html).
class DefaultsTest {
  DefaultsTest._();

  static const int numPreguntas = 50;
  static const int minutos = 120;
  static const double puntosAcierto = 1.0;
  static const double puntosFallo = -0.33;
  static const double puntosBlanco = 0.0;
  static const int preguntasTestDiario = 10;
}

/// Nombres de cajas Hive.
/// En la caja [Cajas.app]: la oposición en la que se acaba de elegir el papel
/// de preparador; al arrancar, la app abre el alta para pedir la verificación.
const claveAbrirAlta = 'abrir_alta';

/// En la caja [Cajas.app]: ya se ha mostrado la bienvenida con la entrada con
/// Google (se muestra una vez, en la instalación nueva).
const claveBienvenidaVista = 'bienvenida_vista';
/// Veces que la sesión de Firebase se perdió y se recuperó sola al arrancar
/// con la cuenta de Google del móvil (`recuperarSesion`).
const claveSesionesRecuperadas = 'sesiones_recuperadas';
/// Periodo de cada indicador del cuadro de coyuntura ya visto (id → periodo).
const claveCoyunturaVista = 'coyuntura_vista';
/// Índice local de las grabaciones de los cantes (ruta, fecha y cante).
const claveGrabaciones = 'grabaciones';
/// Leitner de la autoevaluación de cada tema revisado (prefijo + código).
const prefijoAutoevaluacion = 'autoeval_';

/// En la caja [Cajas.app]: invitación de un preparador pendiente de conectar
/// (su código y la oposición), llegada por el enlace de invitación o por el
/// `referrer` de Google Play (core/invitacion.dart).
const claveInvitacionCodigo = 'invitacion_codigo';
const claveInvitacionOposicion = 'invitacion_oposicion';

/// En la caja [Cajas.app]: ya se ha leído el `referrer` de Google Play (se
/// lee una sola vez, en el primer arranque).
const claveReferrerLeido = 'referrer_leido';

class Cajas {
  Cajas._();

  /// Comunes a todas las oposiciones (caché de descargas y la oposición elegida).
  static const String cacheHttp = 'cache_http';
  static const String app = 'app';

  // Las demás son de cada oposición: se abren con `Oposicion.caja`, que añade
  // el sufijo de la oposición salvo en TCEE.
  static const String resultados = 'resultados_locales';
  static const String leitner = 'leitner';
  static const String ajustes = 'ajustes';
  static const String notas = 'notas';
  static const String descargas = 'descargas';
  static const String cantes = 'cantes';
  static const String plan = 'plan';
  static const String agendaTemas = 'agenda_temas';
  static const String alumnos = 'alumnos';
  static const String sesiones = 'sesiones';
  static const String preparador = 'preparador';
  static const String cronogramas = 'cronogramas';
}
