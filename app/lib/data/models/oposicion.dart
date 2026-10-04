import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'temario.dart';

/// Qué se hace en un cante de un ejercicio.
enum TipoCante {
  /// No se canta (escrito, idiomas…).
  ninguno,

  /// Se canta un dictamen o supuesto sin temas del temario (1.º de TCEE).
  dictamen,

  /// Se cantan temas sorteados del temario.
  temas,
}

/// Un ejercicio del examen de una oposición.
@immutable
class EjercicioDef {
  const EjercicioDef({
    required this.numero,
    required this.descripcion,
    this.cante = TipoCante.ninguno,
    this.sorteo = false,
    this.bolasPorParte = 2,
    this.partesARedactar,
    this.pdfPorParte = false,
    this.queSeCanta,
    this.etiquetaCante,
    this.categoriaIntercalable,
    this.intercalar,
    bool? enCronograma,
  }) : _enCronograma = enCronograma;

  final int numero;

  /// Materia o forma del ejercicio («Economía general e internacional (oral)»).
  final String descripcion;
  final TipoCante cante;

  /// Sus temas se sortean: cuenta para las probabilidades.
  final bool sorteo;

  /// Temas que salen de cada parte. Se puede cambiar sin republicar la app en
  /// `app-config.json` → `sorteo` de la web de la oposición.
  final int bolasPorParte;

  /// Si basta con desarrollar algunas partes (5.º de TCEE: 2 de 3), cuántas.
  final int? partesARedactar;

  /// El temario de este ejercicio se publica en un PDF por parte, no por tema.
  final bool pdfPorParte;

  /// En un cante sin temas, qué se canta («dictamen de coyuntura»).
  final String? queSeCanta;

  /// Nombre corto de ese cante («Coyuntura»).
  final String? etiquetaCante;

  /// Categoría de bloques cuyos temas el cronograma intercala entre los demás
  /// (los más memorísticos; en el 3.º de TCEE, «Mixto»). Sin ella, se alternan
  /// las partes.
  final String? categoriaIntercalable;

  final bool? _enCronograma;

  /// Se estudia tema a tema con un cronograma de vueltas. Por defecto, los de
  /// temas cantados; los escritos de DCE, también.
  bool get enCronograma => _enCronograma ?? cante == TipoCante.temas;

  /// Título y explicación de la opción de intercalar en el cronograma.
  final (String, String)? intercalar;

  bool get seCanta => cante != TipoCante.ninguno;

  /// «Tercer ejercicio».
  String get nombre => '${ordinalLargo(numero)} ejercicio';

  /// «3.º».
  String get corto => '$numero.º';

  /// «3.er ejercicio».
  String get abreviado => '${ordinalAbreviado(numero)} ejercicio';

  static String ordinalAbreviado(int n) => n == 1 || n == 3 ? '$n.er' : '$n.º';

  /// «1.º (coyuntura)» o «3.º».
  String get cortoConCante => etiquetaCante == null ? corto : '$corto (${etiquetaCante!.toLowerCase()})';

  static String ordinalLargo(int n) => switch (n) {
        1 => 'Primer',
        2 => 'Segundo',
        3 => 'Tercer',
        4 => 'Cuarto',
        5 => 'Quinto',
        6 => 'Sexto',
        _ => '$n.º',
      };
}

/// Una oposición que la app sabe preparar: su web, su temario y su examen.
/// Cada oposición es independiente (contenido, datos del opositor y red de
/// preparadores).
@immutable
class Oposicion {
  const Oposicion({
    required this.id,
    required this.siglas,
    required this.nombre,
    required this.web,
    required this.ejercicios,
    this.rutaContenido = '/oposicion',
    this.mismoOrigenEnNavegador = false,
    this.rutaTest = 'temario/primer-ejercicio/test',
    this.notaProbabilidad,
    this.testDe,
    this.autor,
    this.lanzada = true,
  });

  /// Identificador estable ('tcee', 'dce'): va en Firestore y en Hive.
  final String id;
  final String siglas;
  final String nombre;

  /// Web que publica el contenido (sin barra final).
  final String web;

  /// Carpeta de la web con el contenido para la app.
  final String rutaContenido;

  /// En la versión web de la app, pedir el contenido al mismo origen (la app
  /// se sirve desde la web de esta oposición).
  final bool mismoOrigenEnNavegador;

  /// Carpeta del simulador de test dentro de [rutaContenido].
  final String rutaTest;

  final List<EjercicioDef> ejercicios;

  /// Lo que la probabilidad de aprobar da por hecho (los ejercicios sin sorteo).
  final String? notaProbabilidad;

  /// Si su examen no tiene test, la oposición cuyo banco de preguntas puede
  /// practicar de forma voluntaria (DCE usa el de TCEE). null = el suyo.
  final String? testDe;

  /// La pueden elegir todos. Si no, solo sus administradores (y el general),
  /// para probarla antes de lanzarla.
  final bool lanzada;

  /// Quién publica su contenido: (nombre, presentación, página «Sobre mí»).
  final (String, String, String?)? autor;

  /// Dominio de su web, para el pie de Más («victorgutierrezmarcos.es»).
  String get dominio => Uri.parse(web).host.replaceFirst('www.', '');

  /// El test no es parte de su examen: se ofrece como práctica voluntaria.
  bool get testVoluntario => testDe != null;

  /// La oposición que publica el banco de preguntas que se practica.
  Oposicion get _oposicionTest => testDe == null ? this : Oposiciones.todas.firstWhere((o) => o.id == testDe, orElse: () => Oposiciones.tcee);

  /// La de siempre: sus datos viven en la raíz de la cuenta (users/{uid}/…) y
  /// en las cajas Hive sin sufijo, como antes de que hubiera varias.
  bool get esPrincipal => id == Oposiciones.tcee.id;

  EjercicioDef? ejercicio(int n) {
    for (final e in ejercicios) {
      if (e.numero == n) return e;
    }
    return null;
  }

  /// Ejercicios que se cantan (con temas o dictamen), en orden.
  List<EjercicioDef> get conCante => ejercicios.where((e) => e.seCanta).toList();

  /// Ejercicios en los que se cantan temas del temario.
  List<EjercicioDef> get conTemasCantados => ejercicios.where((e) => e.cante == TipoCante.temas).toList();

  /// Ejercicios que se estudian con cronograma.
  List<EjercicioDef> get conCronograma => ejercicios.where((e) => e.enCronograma).toList();

  /// Ejercicios con sorteo de temas (probabilidades).
  List<EjercicioDef> get conSorteo => ejercicios.where((e) => e.sorteo).toList();

  /// El cante de este ejercicio no lleva temas (dictamen).
  bool esDictamen(int n) => ejercicio(n)?.cante == TipoCante.dictamen;

  /// Ejercicios de una bolsa de temas: 0 significa «todos los de temas
  /// cantados» (3.º y 4.º en TCEE).
  Set<int> ejerciciosDeBolsa(int n) => n == 0 ? {for (final e in conTemasCantados) e.numero} : {n};

  /// «Tercer ejercicio», o «3.º y 4.º ejercicio» para el 0.
  String nombreEjercicio(int n) =>
      n == 0 ? '${conTemasCantados.map((e) => e.corto).join(' y ')} ejercicio' : (ejercicio(n)?.nombre ?? '${EjercicioDef.ordinalLargo(n)} ejercicio');

  /// «3.º», o «3.º y 4.º» para el 0.
  String cortoEjercicio(int n) => n == 0 ? conTemasCantados.map((e) => e.corto).join(' y ') : '$n.º';

  /// Primer ejercicio con temas cantados (el que se elige por defecto).
  int get primerConTemas => conTemasCantados.first.numero;

  /// «Primer ejercicio: dictamen de coyuntura.»
  String avisoDictamen(int n) {
    final e = ejercicio(n);
    return '${e?.nombre ?? nombreEjercicio(n)}: ${e?.queSeCanta ?? 'sin temas'}.';
  }

  /// Temas que salen de cada parte en [n]: los de app-config.json si los trae
  /// y, si no, los del examen.
  int bolasPorParte(int n, AppConfig config) => config.bolasPorParte[n] ?? ejercicio(n)?.bolasPorParte ?? 1;

  /// Partes que hay que desarrollar en [n] (null = todas).
  int? partesARedactar(int n, AppConfig config) => config.partesARedactar[n] ?? ejercicio(n)?.partesARedactar;

  // ------------------------------------------------------------------ URLs

  String get _base {
    final origen = kIsWeb && mismoOrigenEnNavegador ? Uri.base.origin : web;
    return '$origen$rutaContenido';
  }

  String get urlTest => identical(_oposicionTest, this) ? '$_base/$rutaTest' : _oposicionTest.urlTest;
  String get urlPreguntas => '$urlTest/preguntas.json';
  String get urlBloques => '$urlTest/bloques.json';
  String get urlImagenesTest => '$urlTest/img';
  String get urlSimuladorWeb => '$urlTest/simulador.html';
  String get urlTemario => '$_base/temario/temario.json';
  String get urlEnlaces => '$_base/enlaces.json';
  String get urlEstructura => '$_base/organizacion/estructura_temario.json';
  String get urlAppConfig => '$_base/app-config.json';
  String get urlComoCantarUnTema => '$_base/organizacion/como_cantar_un_tema.pdf';

  // ------------------------------------------------------------ Persistencia

  /// Nombre de una caja Hive de esta oposición.
  String caja(String nombre) => esPrincipal ? nombre : '${nombre}_$id';

  /// Colección de la red de preparadores de esta oposición (verificados,
  /// sustituciones, códigos…): las de TCEE en la raíz, como antes; las demás,
  /// en oposiciones/{id}/. Cada una tiene sus administradores y su directorio.
  CollectionReference<Map<String, dynamic>> red(FirebaseFirestore db, String nombre) =>
      esPrincipal ? db.collection(nombre) : db.collection('oposiciones').doc(id).collection(nombre);

  /// Documento raíz de los datos de [uid] en esta oposición.
  DocumentReference<Map<String, dynamic>> raizUsuario(FirebaseFirestore db, String uid) {
    final usuario = db.collection('users').doc(uid);
    return esPrincipal ? usuario : usuario.collection('oposiciones').doc(id);
  }
}

/// Las oposiciones de la app.
class Oposiciones {
  Oposiciones._();

  static const tcee = Oposicion(
    id: 'tcee',
    siglas: 'TCEE',
    nombre: 'Técnico Comercial y Economista del Estado',
    web: 'https://www.victorgutierrezmarcos.es',
    mismoOrigenEnNavegador: true,
    notaProbabilidad: 'Supone pasar el test, la coyuntura y los idiomas.',
    autor: ('Víctor Gutiérrez Marcos', 'TCEE, promoción LXXIII', 'https://www.victorgutierrezmarcos.es/sobre-mi.html'),
    ejercicios: [
      EjercicioDef(numero: 1, descripcion: 'Test y dictamen de coyuntura', cante: TipoCante.dictamen, queSeCanta: 'dictamen de coyuntura', etiquetaCante: 'Coyuntura'),
      EjercicioDef(numero: 2, descripcion: 'Idiomas'),
      EjercicioDef(
        numero: 3,
        descripcion: 'Economía general e internacional (oral)',
        cante: TipoCante.temas,
        sorteo: true,
        bolasPorParte: 2,
        categoriaIntercalable: 'Mixto',
        intercalar: ('Intercalar los temas de Mixto', 'Historia, pensamiento económico, organismos internacionales y UE son más memorísticos: repartidos entre los demás para no pasar semanas solo con ellos.'),
      ),
      EjercicioDef(
        numero: 4,
        descripcion: 'Economía española y sector público (oral)',
        cante: TipoCante.temas,
        sorteo: true,
        bolasPorParte: 2,
        intercalar: ('Intercalar las dos partes', 'Economía española y sector público, alternados para no pasar semanas seguidas con una sola parte.'),
      ),
      EjercicioDef(numero: 5, descripcion: 'Marketing, econometría y derecho (escrito)', sorteo: true, bolasPorParte: 1, partesARedactar: 2, pdfPorParte: true),
    ],
  );

  /// Diplomado Comercial del Estado. Examen según la convocatoria de la OEP
  /// 2025 (BOE-A-2025-26896, de 22 de diciembre de 2025):
  ///  1.º escrito: dos temas, uno de cada par extraído de cada parte
  ///      (Economía española, 18 temas; Economía pública, políticas
  ///      comunitarias e instituciones multilaterales, 18).
  ///  2.º idiomas (inglés y otro obligatorios; voluntarios aparte).
  ///  3.º oral: dos temas, uno de cada par extraído de cada parte
  ///      (Microeconomía y economía del sector público, 22; Macroeconomía y
  ///      economía internacional, 22); 30 min de preparación y 40 de exposición.
  ///  4.º escrito: dos temas, uno de cada par extraído de cada parte (Técnicas
  ///      comerciales y marketing internacional, 10; Organización del Estado,
  ///      9), y ocho preguntas prácticas.
  /// No tiene test: se puede practicar, voluntario, con el de TCEE.
  static const dce = Oposicion(
    id: 'dce',
    siglas: 'DCE',
    nombre: 'Diplomado Comercial del Estado',
    web: 'https://manuelcabadogarcia.es',
    testDe: 'tcee',
    notaProbabilidad: 'Supone pasar los idiomas y las preguntas prácticas del 4.º.',
    autor: ('Manuel Cabado García', 'DCE', 'https://manuelcabadogarcia.es'),
    ejercicios: [
      EjercicioDef(numero: 1, descripcion: 'Economía española, economía pública y UE (escrito)', sorteo: true, bolasPorParte: 2, enCronograma: true),
      EjercicioDef(numero: 2, descripcion: 'Idiomas'),
      EjercicioDef(numero: 3, descripcion: 'Micro, sector público, macro e internacional (oral)', cante: TipoCante.temas, sorteo: true, bolasPorParte: 2),
      EjercicioDef(numero: 4, descripcion: 'Técnicas comerciales y organización del Estado (escrito)', sorteo: true, bolasPorParte: 2, enCronograma: true),
    ],
  );

  /// Las que se pueden elegir. La primera es la de por defecto.
  static const todas = [tcee, dce];

  /// La que prepara el usuario. La fija main() al arrancar y no cambia con la
  /// app abierta (al cambiarla se vuelven a crear los servicios), así que las
  /// funciones de texto («Tercer ejercicio») pueden leerla sin `ref`. En los
  /// widgets, mejor `oposicionProvider`.
  static Oposicion actual = tcee;

  /// Las que puede elegir cualquiera.
  static List<Oposicion> get disponibles => todas.where((o) => o.lanzada).toList();

  /// Las que aún no se han lanzado (solo para sus administradores).
  static List<Oposicion> get sinLanzar => todas.where((o) => !o.lanzada).toList();

  static Oposicion porId(String? id) => todas.firstWhere((o) => o.id == id, orElse: () => todas.first);

  /// Hay más de una para elegir.
  static bool get variasDisponibles => disponibles.length > 1;
}
