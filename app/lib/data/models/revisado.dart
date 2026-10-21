/// Temario revisado, exclusivo de la app.
///
/// Los temas que Víctor revisa (rama `revision-temario` del repositorio de la
/// web) no se publican en la web: la app los ofrece, con sesión iniciada, a
/// partir del manifiesto `oposicion/temario/app/revisados.json` de esa rama
/// (lo genera `scripts/temario/manifiesto-app.py`). Sin Firebase Storage: los
/// ficheros se bajan de raw.githubusercontent.com, fijados al commit del
/// manifiesto, y los gráficos del HTML, de jsDelivr (que los sirve con su tipo).
library;

const _repo = 'vgutierrezmarcos/victorgutierrezmarcos.github.io';
const _rama = 'revision-temario';

/// Dónde lee la app el manifiesto (caché de GitHub: 5 minutos).
const urlManifiestoRevisados = 'https://raw.githubusercontent.com/$_repo/$_rama/oposicion/temario/app/revisados.json';

/// Bases por defecto si el manifiesto no trae las suyas (la rama, sin fijar).
const _rawPorDefecto = 'https://raw.githubusercontent.com/$_repo/$_rama/';
const _cdnPorDefecto = 'https://cdn.jsdelivr.net/gh/$_repo@$_rama/';

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
    this.raw = _rawPorDefecto,
    this.cdn = _cdnPorDefecto,
  });

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
  /// Bases de descarga (con barra final), fijadas al commit del manifiesto.
  final String raw;
  final String cdn;

  FicheroRevisado? fichero(ClaseFichero c) => switch (c) {
        ClaseFichero.pdf => pdf,
        ClaseFichero.docx => docx,
        ClaseFichero.html => html,
        ClaseFichero.repaso => repaso,
      };

  /// URL de descarga (raw.githubusercontent.com).
  String url(FicheroRevisado f) => '$raw${f.ruta}';

  /// URL del HTML en jsDelivr: contra ella se resuelven sus gráficos (SVG) y
  /// estilos, que raw.githubusercontent.com serviría como texto.
  String? get urlDocumentoHtml => html == null ? null : '$cdn${html!.ruta}';

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
  String nombreVisible(ClaseFichero c) => switch (c) {
        ClaseFichero.pdf => 'Tema $codigo (revisado).pdf',
        ClaseFichero.docx => 'Tema $codigo (revisado).docx',
        ClaseFichero.html => 'Tema $codigo (revisado).html',
        ClaseFichero.repaso => 'Tema $codigo - ficha de repaso.pdf',
      };

  /// null si falta lo imprescindible (código y PDF).
  static TemaRevisado? fromJson(Object? j, {String raw = _rawPorDefecto, String cdn = _cdnPorDefecto}) {
    if (j is! Map) return null;
    final codigo = j['codigo'];
    if (codigo is! String || !RegExp(r'^\d\.[A-Z]\.\d{1,2}$').hasMatch(codigo.trim())) return null;
    final pdf = FicheroRevisado.fromJson(j['pdf']);
    if (pdf == null) return null;
    final c = codigo.trim();
    final partes = c.split('.');
    final archivo = j['archivo'] is String && (j['archivo'] as String).isNotEmpty
        ? (j['archivo'] as String).replaceAll(RegExp(r'[^0-9A-Za-z]'), '')
        : '${partes[0]}${partes[1]}${partes[2].padLeft(2, '0')}';
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
      raw: raw,
      cdn: cdn,
    );
  }
}

/// revisados.json
class ManifiestoRevisados {
  const ManifiestoRevisados({this.temas = const {}, this.commit = ''});
  final Map<String, TemaRevisado> temas;
  final String commit;

  static const vacio = ManifiestoRevisados();

  bool get isEmpty => temas.isEmpty;

  TemaRevisado? de(String codigo) => temas[codigo];

  /// Tolerante: lo que no se entiende se ignora (una entrada mal escrita no
  /// tumba las demás) y, si el JSON entero no vale, queda vacío.
  factory ManifiestoRevisados.fromJson(Object? j) {
    if (j is! Map) return vacio;
    String base(Object? v, String porDefecto) {
      if (v is! String) return porDefecto;
      final u = Uri.tryParse(v.trim());
      if (u == null || u.scheme != 'https' || u.host.isEmpty) return porDefecto;
      return v.trim().endsWith('/') ? v.trim() : '${v.trim()}/';
    }

    final raw = base(j['raw'], _rawPorDefecto);
    final cdn = base(j['cdn'], _cdnPorDefecto);
    final temas = <String, TemaRevisado>{};
    final lista = j['temas'];
    if (lista is List) {
      for (final e in lista) {
        final t = TemaRevisado.fromJson(e, raw: raw, cdn: cdn);
        if (t != null) temas[t.codigo] = t;
      }
    }
    return ManifiestoRevisados(temas: temas, commit: j['commit'] is String ? j['commit'] as String : '');
  }
}

/// Qué versión de un tema se enseña.
enum VersionTema {
  /// La de la web (la única si el tema no está revisado).
  anterior,
  /// La revisada, exclusiva de la app.
  revisada,
}

class EleccionVersion {
  const EleccionVersion({required this.version, this.hayRevisada = false, this.invitarASesion = false, this.hayAnterior = true});
  final VersionTema version;
  /// El tema tiene versión revisada (se pone el distintivo).
  final bool hayRevisada;
  /// Hay versión revisada pero no hay sesión: se invita a entrar.
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

/// La revisada se abre por defecto, pero solo con sesión iniciada; sin sesión
/// se ve la anterior con la invitación a entrar. [pideAnterior]: el usuario ha
/// tocado «Ver versión anterior»; sin [hayAnterior] (el tema no tenía PDF) no
/// se ofrece.
EleccionVersion elegirVersion({required TemaRevisado? revisado, required bool conSesion, bool pideAnterior = false, bool hayAnterior = true}) {
  if (revisado == null) return const EleccionVersion(version: VersionTema.anterior);
  if (!conSesion) return EleccionVersion(version: VersionTema.anterior, hayRevisada: true, invitarASesion: true, hayAnterior: hayAnterior);
  return EleccionVersion(version: pideAnterior && hayAnterior ? VersionTema.anterior : VersionTema.revisada, hayRevisada: true, hayAnterior: hayAnterior);
}
