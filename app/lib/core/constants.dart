import 'package:flutter/foundation.dart';

/// URLs y constantes compartidas con la web victorgutierrezmarcos.es.
/// Todo el contenido se descarga de la web para no tener que republicar la app
/// cuando cambian preguntas, temas o artículos.
class Urls {
  Urls._();

  /// La web. En la versión para el navegador, su mismo origen: así las
  /// descargas no son peticiones entre dominios (y en pruebas locales se lee
  /// el repositorio servido en localhost).
  static final String base = kIsWeb ? Uri.base.origin : 'https://www.victorgutierrezmarcos.es';
  static final String test = '$base/oposicion/temario/primer-ejercicio/test';

  static final String preguntas = '$test/preguntas.json';
  static final String bloques = '$test/bloques.json';
  static final String imagenesTest = '$test/img';
  static final String temario = '$base/oposicion/temario/temario.json';
  static final String enlaces = '$base/oposicion/enlaces.json';
  static final String estructura = '$base/oposicion/organizacion/estructura_temario.json';
  static final String appConfig = '$base/oposicion/app-config.json';
  static final String comoCantarUnTema =
      '$base/oposicion/organizacion/como_cantar_un_tema.pdf';
  static final String politicaPrivacidad = '$base/politica-cookies.html';
  static final String sobreMi = '$base/sobre-mi.html';
  static final String simuladorWeb = '$test/simulador.html';
  static final String paginaApp = '$base/app/';
  /// La misma app, compilada para el navegador.
  static final String appWeb = '$base/app/abrir/';
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

  static const String cacheHttp = 'cache_http';
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
