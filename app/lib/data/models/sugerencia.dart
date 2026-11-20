/// Una sugerencia de mejora de un tema o de su ficha que el usuario manda al
/// autor, desde la app («Sugerir una mejora») o desde su IA (conector,
/// `sugerir_mejora`). Vive en los datos del propio usuario
/// (`sugerencias/{id}` bajo su raíz en la oposición), sin correo ni nombre:
/// el autor la lee en una bandeja anónima (scripts/sugerencias.py) y, al
/// resolverla, una Action escribe aquí en qué ha quedado.
class Sugerencia {
  const Sugerencia({
    required this.id,
    required this.recurso,
    required this.tema,
    required this.apartado,
    required this.tipo,
    required this.propuesta,
    required this.estado,
    required this.respuesta,
    required this.vista,
    required this.origen,
    this.creado,
  });

  final String id;

  /// `tema` o `ficha`.
  final String recurso;
  final String tema;
  final String apartado;
  final String tipo;
  final String propuesta;

  /// `recibida`, `aceptada`, `descartada` o `duplicada`.
  final String estado;
  final String respuesta;

  /// El usuario ya ha visto en qué ha quedado.
  final bool vista;

  /// «app 1.26.0» o «conector (Claude)».
  final String origen;
  final DateTime? creado;

  /// Qué le pasa al material (las mismas claves que el conector).
  static const tipos = {
    'no_explica': 'No lo explica',
    'poco_claro': 'Está poco claro',
    'error': 'Hay un error',
    'desactualizado': 'Está desactualizado',
    'falta': 'Falta algo',
    'errata': 'Errata',
    'otro': 'Otra cosa',
  };

  static const _estados = {'recibida': 'Recibida', 'aceptada': 'Aceptada', 'descartada': 'Descartada', 'duplicada': 'Ya estaba avisado'};

  factory Sugerencia.fromJson(String id, Map<String, dynamic> j, {DateTime? creado}) {
    String texto(String k) => j[k] is String ? j[k] as String : '';
    final estado = texto('estado');
    return Sugerencia(
      id: id,
      recurso: texto('recurso') == 'ficha' ? 'ficha' : 'tema',
      tema: texto('tema'),
      apartado: texto('apartado'),
      tipo: texto('tipo'),
      propuesta: texto('propuesta'),
      estado: _estados.containsKey(estado) ? estado : 'recibida',
      respuesta: texto('respuesta'),
      vista: j['vista'] == true,
      origen: texto('origen'),
      creado: creado,
    );
  }

  bool get resuelta => estado != 'recibida';
  bool get aceptada => estado == 'aceptada';

  /// Resuelta y aún sin ver: lo que se avisa en Inicio.
  bool get novedad => resuelta && !vista;
  bool get desdeIa => origen.startsWith('conector');
  String get nombreTipo => tipos[tipo] ?? 'Otra cosa';
  String get nombreEstado => _estados[estado]!;
  String get titulo => '${recurso == 'ficha' ? 'Ficha del ' : 'Tema '}$tema';

  /// De la más reciente a la más antigua (las que aún no tienen fecha del
  /// servidor, recién enviadas, primero).
  static List<Sugerencia> ordenar(Iterable<Sugerencia> lista) => [...lista]..sort((a, b) {
      if (a.creado == null || b.creado == null) return a.creado == b.creado ? b.id.compareTo(a.id) : (a.creado == null ? -1 : 1);
      return b.creado!.compareTo(a.creado!);
    });

  /// Materiales distintos (tema o ficha) que el usuario ha ayudado a mejorar.
  static int materialesMejorados(Iterable<Sugerencia> lista) => {for (final s in lista) if (s.aceptada) '${s.recurso}:${s.tema}'}.length;

  /// El tema y el recurso a los que se refiere la página de un tema:
  /// «3.A.8» → tema; «3.A.8-repaso» → ficha; lo demás (un recurso suelto), nada.
  static ({String tema, String recurso})? destinoDe(String codigo) {
    final m = RegExp(r'^(\d\.[A-Z]\.\d{1,2})(-repaso)?$').firstMatch(codigo);
    return m == null ? null : (tema: m.group(1)!, recurso: m.group(2) == null ? 'tema' : 'ficha');
  }
}
