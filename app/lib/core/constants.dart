/// URLs y constantes compartidas con la web victorgutierrezmarcos.es.
/// Todo el contenido se descarga de la web para no tener que republicar la app
/// cuando cambian preguntas, temas o artículos.
class Urls {
  Urls._();

  static const String base = 'https://www.victorgutierrezmarcos.es';
  static const String test = '$base/oposicion/temario/primer-ejercicio/test';

  static const String preguntas = '$test/preguntas.json';
  static const String bloques = '$test/bloques.json';
  static const String imagenesTest = '$test/img';
  static const String temario = '$base/oposicion/temario/temario.json';
  static const String enlaces = '$base/oposicion/enlaces.json';
  static const String appConfig = '$base/oposicion/app-config.json';
  static const String rss = '$base/blog/newsletter/rss.xml';
  static const String comoCantarUnTema =
      '$base/oposicion/organizacion/como_cantar_un_tema.pdf';
  static const String politicaPrivacidad = '$base/politica-cookies.html';
  static const String sobreMi = '$base/sobre-mi.html';
  static const String simuladorWeb = '$test/simulador.html';
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
  static const String favoritosBlog = 'favoritos_blog';
}
