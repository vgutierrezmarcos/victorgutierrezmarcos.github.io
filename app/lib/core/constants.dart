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
  static final String sobreMi = '$base/sobre-mi.html';
  static final String paginaApp = '$base/app/';
  /// La misma app, compilada para el navegador.
  static final String appWeb = '$base/app/abrir/';
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
