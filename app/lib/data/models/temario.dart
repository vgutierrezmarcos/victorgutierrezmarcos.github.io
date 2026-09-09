/// temario.json (generado por build-app-data.js en la web).
class Tema {
  const Tema({
    required this.codigo,
    required this.titulo,
    required this.disponible,
    required this.temarioAnterior,
    this.url,
  });
  final String codigo; // 3.A.1
  final String titulo;
  final bool disponible;
  final bool temarioAnterior;
  final String? url;

  int get ejercicio => int.tryParse(codigo.split('.').first) ?? 0;
  String get parte => codigo.split('.').length > 1 ? codigo.split('.')[1] : '';
  int get numero => int.tryParse(codigo.split('.').last) ?? 0;

  /// Nombre de fichero local para la descarga offline.
  String get nombreFichero => '${codigo.replaceAll('.', '')}.pdf';

  factory Tema.fromJson(Map<String, dynamic> j) => Tema(
        codigo: j['codigo'] as String,
        titulo: j['titulo'] as String? ?? '',
        disponible: j['disponible'] as bool? ?? false,
        temarioAnterior: j['temarioAnterior'] as bool? ?? false,
        url: j['url'] as String?,
      );
}

class Parte {
  const Parte({required this.letra, required this.nombre, required this.temas, this.url, this.disponible = true});
  final String letra;
  final String nombre;
  final List<Tema> temas;
  /// Solo quinto ejercicio: PDF de la parte completa.
  final String? url;
  final bool disponible;

  factory Parte.fromJson(Map<String, dynamic> j) => Parte(
        letra: j['letra'] as String? ?? '',
        nombre: j['nombre'] as String? ?? '',
        temas: (j['temas'] as List? ?? []).map((e) => Tema.fromJson(e as Map<String, dynamic>)).toList(),
        url: j['url'] as String?,
        disponible: j['disponible'] as bool? ?? true,
      );
}

class Recurso {
  const Recurso({required this.id, required this.titulo, required this.tipo, required this.url, this.descripcion = ''});
  final String id;
  final String titulo;
  final String tipo; // pdf | app | xlsm | dotx
  final String url;
  final String descripcion;

  factory Recurso.fromJson(Map<String, dynamic> j) => Recurso(
        id: j['id'] as String,
        titulo: j['titulo'] as String,
        tipo: j['tipo'] as String? ?? 'pdf',
        url: j['url'] as String,
        descripcion: j['descripcion'] as String? ?? '',
      );
}

class Ejercicio {
  const Ejercicio({
    required this.id,
    required this.slug,
    required this.nombre,
    required this.descripcion,
    required this.urlPagina,
    required this.partes,
    this.recursos = const [],
  });
  final int id;
  final String slug;
  final String nombre;
  final String descripcion;
  final String urlPagina;
  final List<Parte> partes;
  final List<Recurso> recursos;

  List<Tema> get temas => partes.expand((p) => p.temas).toList();

  factory Ejercicio.fromJson(Map<String, dynamic> j) => Ejercicio(
        id: (j['id'] as num).toInt(),
        slug: j['slug'] as String,
        nombre: j['nombre'] as String,
        descripcion: j['descripcion'] as String? ?? '',
        urlPagina: j['urlPagina'] as String? ?? '',
        partes: (j['partes'] as List? ?? []).map((e) => Parte.fromJson(e as Map<String, dynamic>)).toList(),
        recursos: (j['recursos'] as List? ?? []).map((e) => Recurso.fromJson(e as Map<String, dynamic>)).toList(),
      );
}

class Temario {
  const Temario({required this.ejercicios, required this.organizacion});
  final List<Ejercicio> ejercicios;
  final List<Recurso> organizacion;

  List<Tema> get todosLosTemas => ejercicios.expand((e) => e.temas).toList();

  Tema? tema(String codigo) {
    for (final t in todosLosTemas) {
      if (t.codigo == codigo) return t;
    }
    return null;
  }

  factory Temario.fromJson(Map<String, dynamic> j) => Temario(
        ejercicios: (j['ejercicios'] as List).map((e) => Ejercicio.fromJson(e as Map<String, dynamic>)).toList(),
        organizacion: (j['organizacion'] as List? ?? []).map((e) => Recurso.fromJson(e as Map<String, dynamic>)).toList(),
      );
}

/// enlaces.json
class Enlace {
  const Enlace({required this.titulo, required this.url});
  final String titulo;
  final String url;
}

class CategoriaEnlaces {
  const CategoriaEnlaces({required this.nombre, required this.enlaces});
  final String nombre;
  final List<Enlace> enlaces;

  static List<CategoriaEnlaces> listaFromJson(Map<String, dynamic> j) =>
      (j['categorias'] as List)
          .map((c) => CategoriaEnlaces(
                nombre: c['nombre'] as String,
                enlaces: (c['enlaces'] as List)
                    .map((e) => Enlace(titulo: e['titulo'] as String, url: e['url'] as String))
                    .toList(),
              ))
          .toList();
}

/// app-config.json (configuración remota editable sin republicar la app).
class AppConfig {
  const AppConfig({
    this.versionMinima = '1.0.0',
    this.urlPlayStore,
    this.urlAppStore,
    this.nombreConvocatoria = '',
    this.fechaPrimerEjercicio,
    this.urlBoe,
    this.urlDiscord,
    this.urlTelegram,
    this.urlNewsletter,
    this.email = 'contacto@victorgutierrezmarcos.es',
    this.linkedin,
    this.github,
    this.listaX,
    this.avisos = const [],
  });

  final String versionMinima;
  final String? urlPlayStore;
  final String? urlAppStore;
  final String nombreConvocatoria;
  final DateTime? fechaPrimerEjercicio;
  final String? urlBoe;
  final String? urlDiscord;
  final String? urlTelegram;
  final String? urlNewsletter;
  final String email;
  final String? linkedin;
  final String? github;
  final String? listaX;
  final List<String> avisos;

  factory AppConfig.fromJson(Map<String, dynamic> j) {
    final app = j['app'] as Map<String, dynamic>? ?? {};
    final conv = j['convocatoria'] as Map<String, dynamic>? ?? {};
    final com = j['comunidad'] as Map<String, dynamic>? ?? {};
    final con = j['contacto'] as Map<String, dynamic>? ?? {};
    final f = conv['fechaPrimerEjercicio'] as String?;
    return AppConfig(
      versionMinima: app['versionMinima'] as String? ?? '1.0.0',
      urlPlayStore: app['urlPlayStore'] as String?,
      urlAppStore: app['urlAppStore'] as String?,
      nombreConvocatoria: conv['nombre'] as String? ?? '',
      fechaPrimerEjercicio: f == null ? null : DateTime.tryParse(f),
      urlBoe: conv['urlBoe'] as String?,
      urlDiscord: com['urlDiscord'] as String?,
      urlTelegram: com['urlTelegram'] as String?,
      urlNewsletter: com['urlNewsletter'] as String?,
      email: con['email'] as String? ?? 'contacto@victorgutierrezmarcos.es',
      linkedin: con['linkedin'] as String?,
      github: con['github'] as String?,
      listaX: con['listaX'] as String?,
      avisos: (j['avisos'] as List? ?? []).map((e) => e.toString()).toList(),
    );
  }

  static const porDefecto = AppConfig();
}
