/// Temario revisado, exclusivo de la app.
///
/// Los temas que Víctor revisa no son públicos (26/11/2026): los sirve el
/// conector (mcp/worker/src/temarioPrivado.ts) desde su almacén privado a quien
/// ha iniciado sesión con Google. El manifiesto (títulos, tamaños, huellas y
/// esquemas; sin contenido) es público en /temario/manifiesto; los ficheros se
/// bajan de una dirección firmada que caduca (AccesoTemario), en la que el HTML
/// resuelve también sus gráficos.
library;

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'esquema.dart';

const _servidor = 'https://mcp.victorgutierrezmarcos.es';

/// Dónde lee la app el manifiesto (caché del conector: 5 minutos).
const urlManifiestoRevisados = '$_servidor/temario/manifiesto';

/// La dirección firmada del almacén privado del temario (…/t/<caducidad>.<firma>/),
/// que da el conector con el token de Firebase del usuario y vale unas horas.
class AccesoTemario {
  AccesoTemario._();

  static String _base = '';
  static int _expira = 0;
  static Future<bool>? _enCurso;

  /// La base vigente ('' si no hay sesión o aún no se ha pedido).
  static String get base => vigente ? _base : '';

  static bool get vigente => _base.isNotEmpty && _expira - 300 > DateTime.now().millisecondsSinceEpoch ~/ 1000;

  /// Pide una base nueva si no hay o va a caducar; false sin sesión o sin red.
  static Future<bool> asegurar({Dio? dio, User? usuario}) {
    if (vigente) return Future.value(true);
    return _enCurso ??= _pedir(dio: dio, usuario: usuario).whenComplete(() => _enCurso = null);
  }

  static Future<bool> _pedir({Dio? dio, User? usuario}) async {
    try {
      final u = usuario ?? FirebaseAuth.instance.currentUser;
      if (u == null) return false;
      final token = await u.getIdToken();
      final r = await (dio ?? Dio()).get<Map<String, dynamic>>(
        '$_servidor/temario/acceso',
        options: Options(headers: {'Authorization': 'Bearer $token'}, responseType: ResponseType.json, receiveTimeout: const Duration(seconds: 20)),
      );
      final base = r.data?['base'];
      final expira = r.data?['expira'];
      if (base is! String || !base.startsWith('$_servidor/t/') || expira is! num) return false;
      _base = base.endsWith('/') ? base : '$base/';
      _expira = expira.toInt();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Al cerrar la sesión.
  static void olvidar() {
    _base = '';
    _expira = 0;
  }

  /// Para las pruebas.
  static void fijarParaPruebas(String base, int expira) {
    _base = base;
    _expira = expira;
  }
}

/// Un fichero del tema revisado: ruta desde la raíz del repositorio, tamaño en
/// bytes y hash corto de su contenido (cambia si cambia el fichero).
class FicheroRevisado {
  const FicheroRevisado({required this.ruta, this.tamano = 0, this.sha = ''});
  final String ruta;
  final int tamano;
  final String sha;

  String get extension {
    final nombre = ruta.split('/').last;
    final i = nombre.lastIndexOf('.');
    return i < 0 ? '' : nombre.substring(i + 1).toLowerCase();
  }

  /// null si falta la ruta o no es un texto.
  static FicheroRevisado? fromJson(Object? j) {
    if (j is! Map) return null;
    final ruta = j['ruta'];
    if (ruta is! String || ruta.trim().isEmpty) return null;
    final t = j['tamano'];
    final sha = j['sha'];
    // El sha entra en el nombre del fichero descargado: solo letras y cifras.
    return FicheroRevisado(
      ruta: ruta.trim().replaceFirst(RegExp(r'^/+'), ''),
      tamano: t is num ? t.toInt() : 0,
      sha: sha is String ? sha.replaceAll(RegExp(r'[^0-9A-Za-z]'), '') : '',
    );
  }
}

/// Qué fichero del tema revisado.
enum ClaseFichero { pdf, docx, html, repaso }

class TemaRevisado {
  const TemaRevisado({
    required this.codigo,
    required this.archivo,
    required this.pdf,
    this.titulo = '',
    this.aprobado,
    this.version = '',
    this.docx,
    this.html,
    this.repaso,
    this.esquema = const [],
    this.exclusivo = true,
  });

  /// Materiales publicados o revisados desde el 1 de octubre de 2026: de uso
  /// personal (sin licencia CC), solo lectura dentro de la app (sin compartir,
  /// sin Word y sin descargar el PDF anotado). Lo dice el manifiesto
  /// (`exclusivo`); si no lo trae, por la fecha de aprobación.
  final bool exclusivo;

  /// Marcadores del PDF revisado (`esquema` en el manifiesto: [nivel, título,
  /// página]); vacío si el manifiesto aún no los trae.
  final List<EntradaEsquema> esquema;

  /// 3.A.12
  final String codigo;
  /// 3A12
  final String archivo;
  final String titulo;
  /// Día en que Víctor aprobó el tema.
  final DateTime? aprobado;
  /// Hash corto del último commit que tocó sus ficheros.
  final String version;
  final FicheroRevisado pdf;
  final FicheroRevisado? docx;
  final FicheroRevisado? html;
  /// Ficha de repaso (solo si está aprobada).
  final FicheroRevisado? repaso;

  FicheroRevisado? fichero(ClaseFichero c) => switch (c) {
        ClaseFichero.pdf => pdf,
        ClaseFichero.docx => docx,
        ClaseFichero.html => html,
        ClaseFichero.repaso => repaso,
      };

  /// URL de descarga: la dirección firmada del almacén privado (AccesoTemario);
  /// sin ella, solo la ruta (no se descarga nada: hay que llamar antes a
  /// AccesoTemario.asegurar()). El nombre local va por la huella, no por la URL.
  String url(FicheroRevisado f) => '${AccesoTemario.base}${f.ruta}';

  /// URL del HTML: contra ella se resuelven sus gráficos (SVG), en el mismo almacén.
  String? get urlDocumentoHtml => html == null ? null : '${AccesoTemario.base}${html!.ruta}';

  /// Nombre del fichero en la carpeta de descargas del móvil. Lleva el hash
  /// del contenido: si el tema cambia, el nombre cambia y se vuelve a bajar.
  String nombreLocal(ClaseFichero c) {
    final f = fichero(c)!;
    final sha = f.sha.isEmpty ? version.replaceAll(RegExp(r'[^0-9A-Za-z]'), '') : f.sha;
    return '${prefijoLocal(c)}${sha.isEmpty ? '0' : sha}.${f.extension.isEmpty ? 'bin' : f.extension}';
  }

  /// Lo que comparten todas las versiones de ese fichero (para borrar las viejas).
  String prefijoLocal(ClaseFichero c) => '$archivo-revisado-${c.name}-';

  /// Nombre con el que se comparte o guarda el fichero.
  bool get esDictamen => codigo == codigoDictamen;

  String nombreVisible(ClaseFichero c) => esDictamen
      ? switch (c) {
          ClaseFichero.pdf => 'Guía del dictamen (revisada).pdf',
          ClaseFichero.docx => 'Guía del dictamen (revisada).docx',
          ClaseFichero.html => 'Guía del dictamen (revisada).html',
          ClaseFichero.repaso => 'Guía del dictamen - resumen de repaso.pdf',
        }
      : switch (c) {
        ClaseFichero.pdf => 'Tema $codigo (revisado).pdf',
        ClaseFichero.docx => 'Tema $codigo (revisado).docx',
        ClaseFichero.html => 'Tema $codigo (revisado).html',
        ClaseFichero.repaso => 'Tema $codigo - ficha de repaso.pdf',
      };

  /// null si falta lo imprescindible (código y PDF).
  static TemaRevisado? fromJson(Object? j) {
    if (j is! Map) return null;
    final codigo = j['codigo'];
    // «Dictamen» es la guía del dictamen de coyuntura (clave `dictamen` del manifiesto).
    if (codigo is! String || !(RegExp(r'^\d\.[A-Z]\.\d{1,2}$').hasMatch(codigo.trim()) || codigo.trim() == codigoDictamen)) return null;
    final pdf = FicheroRevisado.fromJson(j['pdf']);
    if (pdf == null) return null;
    final c = codigo.trim();
    final partes = c.split('.');
    final archivo = j['archivo'] is String && (j['archivo'] as String).isNotEmpty
        ? (j['archivo'] as String).replaceAll(RegExp(r'[^0-9A-Za-z]'), '')
        : (c == codigoDictamen ? '1D01' : '${partes[0]}${partes[1]}${partes[2].padLeft(2, '0')}');
    return TemaRevisado(
      codigo: c,
      archivo: archivo,
      titulo: j['titulo'] is String ? j['titulo'] as String : '',
      aprobado: j['aprobado'] is String ? DateTime.tryParse(j['aprobado'] as String) : null,
      version: j['version'] is String ? j['version'] as String : '',
      pdf: pdf,
      docx: FicheroRevisado.fromJson(j['docx']),
      html: FicheroRevisado.fromJson(j['html']),
      repaso: FicheroRevisado.fromJson(j['repaso']),
      esquema: EntradaEsquema.listaDeJson(j['esquema']),
      exclusivo: j['exclusivo'] is bool ? j['exclusivo'] as bool : !(j['aprobado'] is String && DateTime.tryParse(j['aprobado'] as String) != null && DateTime.parse(j['aprobado'] as String).isBefore(corteExclusivo)),
    );
  }
}

/// Código con el que la app trata la guía del dictamen de coyuntura (1D01).
const codigoDictamen = 'Dictamen';

/// Desde cuándo lo revisado es exclusivo (uso personal).
final corteExclusivo = DateTime(2026, 10, 1);

/// Aviso de los materiales exclusivos (el mismo que llevan los ficheros).
const avisoExclusivo = 'Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. Puedes usarlo libremente para tu estudio personal. No se autoriza su incorporación a otras plataformas, aplicaciones o servicios.';
const urlCondicionesMateriales = 'https://www.victorgutierrezmarcos.es/condiciones-materiales.html';

/// revisados.json
class ManifiestoRevisados {
  const ManifiestoRevisados({this.temas = const {}, this.commit = '', this.condiciones = urlCondicionesMateriales, this.dictamen});
  final Map<String, TemaRevisado> temas;
  /// La guía del dictamen de coyuntura revisada (clave `dictamen`), si está aprobada.
  final TemaRevisado? dictamen;
  final String commit;
  /// Página de condiciones de uso de los materiales (la trae el manifiesto).
  final String condiciones;

  /// Los temas exclusivos (uso personal).
  Iterable<TemaRevisado> get exclusivos => [...temas.values, if (dictamen != null) dictamen!].where((t) => t.exclusivo);

  static const vacio = ManifiestoRevisados();

  bool get isEmpty => temas.isEmpty && dictamen == null;

  TemaRevisado? de(String codigo) => codigo == codigoDictamen ? dictamen : temas[codigo];

  /// Tolerante: lo que no se entiende se ignora (una entrada mal escrita no
  /// tumba las demás) y, si el JSON entero no vale, queda vacío.
  factory ManifiestoRevisados.fromJson(Object? j) {
    if (j is! Map) return vacio;
    final temas = <String, TemaRevisado>{};
    final lista = j['temas'];
    if (lista is List) {
      for (final e in lista) {
        final t = TemaRevisado.fromJson(e);
        if (t != null) temas[t.codigo] = t;
      }
    }
    final condiciones = j['condiciones'];
    final d = j['dictamen'];
    final dictamen = d is Map ? TemaRevisado.fromJson({...d, 'codigo': codigoDictamen}) : null;
    return ManifiestoRevisados(temas: temas, dictamen: dictamen, commit: j['commit'] is String ? j['commit'] as String : '', condiciones: condiciones is String && condiciones.startsWith('https://') ? condiciones : urlCondicionesMateriales);
  }
}

/// Qué versión de un tema se enseña.
enum VersionTema {
  /// La de la web (la única si el tema no está revisado).
  anterior,
  /// La revisada, exclusiva de la app.
  revisada,
  /// Ninguna todavía: hay revisada pero no hay sesión; se pide entrar con
  /// Google y, si el tema tenía versión anterior, se ofrece seguir con ella.
  sinSesion,
}

class EleccionVersion {
  const EleccionVersion({required this.version, this.hayRevisada = false, this.invitarASesion = false, this.hayAnterior = true});
  final VersionTema version;
  /// El tema tiene versión revisada (se pone el distintivo).
  final bool hayRevisada;
  /// Hay versión revisada pero no hay sesión: se pide entrar (con el aviso o,
  /// si ha elegido seguir con la anterior, desde la barra de encima).
  final bool invitarASesion;
  /// El tema tenía versión anterior (si no, no se ofrece «Ver versión anterior»).
  final bool hayAnterior;

  bool get esRevisada => version == VersionTema.revisada;
  /// Se puede pasar a la otra versión (solo con sesión y versión revisada).
  bool get puedeCambiar => hayRevisada && hayAnterior && !invitarASesion;

  @override
  bool operator ==(Object other) =>
      other is EleccionVersion && other.version == version && other.hayRevisada == hayRevisada && other.invitarASesion == invitarASesion && other.hayAnterior == hayAnterior;

  @override
  int get hashCode => Object.hash(version, hayRevisada, invitarASesion, hayAnterior);

  @override
  String toString() => 'EleccionVersion($version, hayRevisada: $hayRevisada, invitar: $invitarASesion, anterior: $hayAnterior)';
}

/// La revisada se abre por defecto, pero solo con sesión iniciada. Sin sesión,
/// primero el aviso «Inicia sesión para ver el tema nuevo» y, si el tema tenía
/// versión anterior, «Seguir con el tema antiguo» (Víctor, 24 nov. 2026; antes,
/// el 20 nov., sin sesión no se enseñaba ninguna). [pideAnterior]: el usuario
/// ha tocado «Ver versión anterior» o «Seguir con el tema antiguo»; sin
/// [hayAnterior] (el tema no tenía PDF) no se ofrece.
EleccionVersion elegirVersion({required TemaRevisado? revisado, required bool conSesion, bool pideAnterior = false, bool hayAnterior = true}) {
  if (revisado == null) return const EleccionVersion(version: VersionTema.anterior);
  if (!conSesion) {
    return EleccionVersion(version: pideAnterior && hayAnterior ? VersionTema.anterior : VersionTema.sinSesion, hayRevisada: true, invitarASesion: true, hayAnterior: hayAnterior);
  }
  return EleccionVersion(version: pideAnterior && hayAnterior ? VersionTema.anterior : VersionTema.revisada, hayRevisada: true, hayAnterior: hayAnterior);
}
