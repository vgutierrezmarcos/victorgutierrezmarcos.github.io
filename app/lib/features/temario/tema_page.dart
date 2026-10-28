import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/analitica.dart';
import '../../core/avisos_breves.dart';
import '../../core/plataforma.dart';
import '../../core/providers.dart';
import '../../data/models/esquema.dart';
import '../../data/models/preparador.dart';
import '../../data/models/revisado.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../test/preguntas_por_tema_page.dart';
import '../../core/red_providers.dart';
import '../../data/models/frecuencia_test.dart';
import '../cantar/pizarra_compartida.dart';
import '../preparador/materiales_widgets.dart';
import 'agenda_tema_page.dart';
import 'anotaciones.dart';
import 'esquema_tema.dart';
import '../cantar/esquema_ciegas_page.dart';
import 'html_revisado.dart';
import 'visor_html.dart';
import 'visor_tema.dart';

/// Visor de un tema: PDF (descargado para offline) con las anotaciones del
/// usuario (bolígrafo y fosforito, guardadas en su cuenta), estado de estudio
/// y agenda del tema (apuntes para la próxima vuelta, vueltas y nota libre).
/// Si el tema no tiene PDF se muestra directamente la agenda.
///
/// Si el tema está en el temario revisado (exclusivo de la app, ver
/// `data/models/revisado.dart`), con sesión se abre la versión revisada (PDF
/// con anotaciones propias, HTML, ficha de repaso y Word) y la anterior queda
/// a un toque; sin sesión, la anterior con la invitación a entrar.
class TemaPage extends ConsumerStatefulWidget {
  const TemaPage({super.key, required this.tema, this.esRecurso = false, this.nombreDescarga, this.reemplazaDescarga});
  final Tema tema;
  final bool esRecurso;
  /// Nombre del fichero descargado (y prefijo de sus versiones viejas), si no
  /// vale el de la URL: la ficha de repaso revisada.
  final String? nombreDescarga;
  final String? reemplazaDescarga;
  @override
  ConsumerState<TemaPage> createState() => _TemaPageState();
}

/// El PDF que toca abrir: su URL y, en el temario revisado, el nombre local
/// (con el hash del contenido) y el prefijo de sus versiones viejas.
typedef _FuentePdf = ({String url, String? nombre, String? reemplaza});

class _TemaPageState extends ConsumerState<TemaPage> {
  String? _ruta; // fichero descargado (solo en el móvil)
  PdfDocument? _pdf;
  double _progreso = 0;
  Object? _error;
  int _pagina = 1, _paginas = 0;
  final _visor = ControladorVisor();
  bool _anotando = false;

  /// Lo que hay cargado (o cargándose) en el visor: URL|nombre.
  String? _claveCargada;
  /// «Ver versión anterior» de un tema revisado.
  bool _pideAnterior = false;
  /// Leer el tema revisado como página web (HTML) en vez de en PDF.
  bool _verHtml = false;
  /// El esquema al lado del PDF (en pantallas anchas; se puede plegar).
  bool _verEsquema = true;
  /// El HTML del tema revisado tal como se bajó; se prepara para el visor
  /// según el modo (claro u oscuro) al pintarlo.
  String? _htmlCrudo, _shaHtml;
  String? _htmlPreparado, _clavePreparado;
  Object? _errorHtml;

  /// Dónde se guardan las anotaciones de cada versión del tema (null sin
  /// cuenta). La revisada tiene las suyas: sus páginas no son las de la anterior.
  final _fuentesAnotaciones = <String, FuentePizarra?>{};
  FuentePizarra? _anotacionesDe(String codigo) => _fuentesAnotaciones.putIfAbsent(codigo, () {
        final yo = ref.read(usuarioActualProvider);
        if (widget.esRecurso || codigo.isEmpty || yo == null || !ref.read(serviciosProvider).firebaseDisponible) return null;
        return fuenteAnotaciones(ref.read(firestoreAnotacionesProvider), ref.read(oposicionProvider), uid: yo.uid, codigo: codigo);
      });

  @override
  void initState() {
    super.initState();
    if (!widget.esRecurso) {
      Analitica.instancia.pantalla('/tema');
      Analitica.instancia.evento('tema_abierto', parametros: {'ejercicio': int.tryParse(widget.tema.codigo.split('.').first) ?? 0, 'formato': 'pdf'});
    }
    // Al abrir el tema se recuerdan los apuntes que se dejaron para esta vuelta.
    if (!widget.esRecurso && widget.tema.url != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final n = ref.read(agendasProvider.notifier).de(widget.tema.codigo).pendientes.length;
        if (n == 0) return;
        ScaffoldMessenger.of(context).mostrar(SnackBar(
          content: Text(n == 1 ? 'Tienes 1 apunte pendiente para esta vuelta' : 'Tienes $n apuntes pendientes para esta vuelta'),
          action: SnackBarAction(label: 'Ver', textColor: Colors.white, onPressed: _abrirAgenda),
        ));
      });
    }
  }

  void _abrirAgenda() => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AgendaTemaPage(tema: widget.tema)));

  /// Abre en el visor [fuente] (y cierra lo que hubiera).
  Future<void> _cargar(_FuentePdf fuente) async {
    final clave = _claveCargada;
    final anterior = _pdf;
    setState(() {
      _pdf = null;
      _ruta = null;
      _error = null;
      _progreso = 0;
      _paginas = 0;
      _pagina = 1;
      _anotando = false;
    });
    await anterior?.close();
    try {
      final descargas = ref.read(descargasProvider);
      void progreso(int r, int t) {
        if (t > 0 && mounted && _claveCargada == clave) setState(() => _progreso = r / t);
      }

      var pdf = await descargas.abrir(fuente.url, nombre: fuente.nombre, reemplaza: fuente.reemplaza, progreso: progreso);
      PdfDocument documento;
      try {
        // En la web, pdf.js se queda con el búfer que se le pasa (lo
        // transfiere a su worker y lo deja «detached»): siempre una copia,
        // para poder volver a abrir el tema y exportarlo anotado.
        documento = await (pdf.ruta != null ? PdfDocument.openFile(pdf.ruta!) : PdfDocument.openData(Uint8List.fromList(pdf.bytes!)));
      } catch (_) {
        // Un fichero ya descargado que no se abre (a medias o dañado): se
        // borra y se descarga otra vez antes de dar el error.
        if (pdf.ruta == null || !descargas.guardaSinConexion) rethrow;
        await descargas.borrar(fuente.url, nombre: fuente.nombre);
        pdf = await descargas.abrir(fuente.url, nombre: fuente.nombre, reemplaza: fuente.reemplaza, progreso: progreso);
        documento = await PdfDocument.openFile(pdf.ruta!);
      }
      // Si mientras tanto se ha pedido otra versión (o se ha cerrado), esta sobra.
      if (!mounted || _claveCargada != clave) {
        await documento.close();
        return;
      }
      setState(() {
        _ruta = pdf.ruta;
        _pdf = documento;
      });
    } catch (e) {
      if (mounted && _claveCargada == clave) setState(() => _error = e);
    }
  }

  /// El HTML del tema revisado, preparado para leerlo en la app (en el móvil
  /// queda guardado para leerlo sin red; los gráficos necesitan red la primera vez).
  Future<void> _cargarHtml(TemaRevisado rev) async {
    final f = rev.html;
    // Ya cargado, cargándose o con error (se reintenta con «Reintentar»).
    if (f == null || _shaHtml == f.sha) return;
    setState(() {
      _shaHtml = f.sha;
      _htmlCrudo = null;
      _errorHtml = null;
    });
    try {
      final bytes = await ref.read(descargasProvider).bytes(rev.url(f), nombre: rev.nombreLocal(ClaseFichero.html), reemplaza: rev.prefijoLocal(ClaseFichero.html));
      final html = utf8.decode(bytes, allowMalformed: true);
      if (mounted && _shaHtml == f.sha) setState(() => _htmlCrudo = html);
    } catch (e) {
      if (mounted && _shaHtml == f.sha) setState(() => _errorHtml = e);
    }
  }

  /// La ficha de repaso o el Word del tema revisado: la ficha se abre en el
  /// visor; el Word se comparte (móvil) o se descarga (navegador).
  Future<void> _abrirFichero(TemaRevisado rev, ClaseFichero clase) async {
    final f = rev.fichero(clase);
    if (f == null) return;
    if (clase == ClaseFichero.repaso) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => TemaPage(
          tema: Tema(codigo: '${rev.codigo}-repaso', titulo: rev.esDictamen ? 'Resumen de repaso de la guía del dictamen' : 'Ficha de repaso del tema ${rev.codigo}', disponible: true, temarioAnterior: false, url: rev.url(f)),
          esRecurso: true,
          nombreDescarga: rev.nombreLocal(clase),
          reemplazaDescarga: rev.prefijoLocal(clase),
        ),
      ));
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    messenger.mostrar(SnackBar(content: Text(kIsWeb ? 'Descargando el Word…' : 'Preparando el Word…'), duration: const Duration(seconds: 2)));
    try {
      final bytes = await ref.read(descargasProvider).bytes(rev.url(f), nombre: rev.nombreLocal(clase), reemplaza: rev.prefijoLocal(clase));
      await guardarBytes(
        nombre: rev.nombreVisible(clase),
        bytes: bytes,
        mime: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        asunto: '${rev.codigo} ${widget.tema.titulo}',
      );
    } catch (e) {
      messenger.mostrar(SnackBar(content: Text('No se ha podido descargar el Word: ${e is Exception ? 'comprueba la conexión' : e}')));
    }
  }

  /// Sin PDF que enseñar (la versión anterior de un tema que no lo tenía).
  Future<void> _vaciar() async {
    final anterior = _pdf;
    setState(() {
      _pdf = null;
      _ruta = null;
      _error = null;
      _paginas = 0;
      _anotando = false;
    });
    await anterior?.close();
  }

  void _entrar() => GoRouter.of(context).go('/mas/cuenta');

  @override
  void dispose() {
    _claveCargada = null;
    _pdf?.close();
    super.dispose();
  }

  void _alternarAnotar(FuentePizarra? anotaciones) {
    if (anotaciones == null) {
      ScaffoldMessenger.of(context).mostrar(SnackBar(
        content: const Text('Para pintar y subrayar el tema, entra con tu cuenta: tus anotaciones se guardan en ella.'),
        action: SnackBarAction(label: 'Entrar', textColor: Colors.white, onPressed: () => GoRouter.of(context).go('/mas/cuenta')),
      ));
      return;
    }
    setState(() => _anotando = !_anotando);
  }

  /// El HTML preparado para el visor en el modo actual (se guarda hasta que
  /// cambie el tema, el modo o el HTML).
  String _htmlDelVisor(TemaRevisado rv) {
    final oscuro = context.temaOscuro;
    final clave = '$_shaHtml|$oscuro';
    if (_clavePreparado != clave || _htmlPreparado == null) {
      _htmlPreparado = prepararHtmlRevisado(_htmlCrudo!, urlDocumento: rv.urlDocumentoHtml!, oscuro: oscuro);
      _clavePreparado = clave;
    }
    return _htmlPreparado!;
  }

  /// El visor con el esquema a su izquierda (en pantallas anchas).
  Widget _conEsquema(List<EntradaEsquema>? esquema, Widget visor) {
    if (esquema == null) return visor;
    return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(
        width: 290,
        child: Material(
          color: context.colores.superficie,
          child: PanelEsquema(esquema: esquema, pagina: _pagina, alIr: _visor.irAPagina),
        ),
      ),
      VerticalDivider(width: 1, thickness: 1, color: context.colores.borde),
      Expanded(child: visor),
    ]);
  }

  /// El tema con las anotaciones, en un PDF nuevo (para imprimirlo o compartirlo).
  Future<void> _descargarAnotado(bool revisada) async {
    final pdf = _pdf;
    if (pdf == null) return;
    final progreso = ValueNotifier<double>(0);
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (d) => AlertDialog(
        title: const Text('Preparando el PDF'),
        content: ValueListenableBuilder<double>(valueListenable: progreso, builder: (_, v, __) => LinearProgressIndicator(value: v == 0 ? null : v)),
      ),
    );
    final nav = Navigator.of(context, rootNavigator: true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final bytes = await pdfAnotado(pdf, _visor.anotaciones, progreso: (h, t) => progreso.value = h / t);
      nav.pop();
      await guardarBytes(nombre: 'Tema ${widget.tema.codigo}${revisada ? ' (revisado)' : ''} anotado.pdf', bytes: bytes, mime: 'application/pdf', asunto: '${widget.tema.codigo} ${widget.tema.titulo}');
    } catch (e) {
      nav.pop();
      messenger.mostrar(SnackBar(content: Text('No se ha podido preparar el PDF: $e')));
    } finally {
      progreso.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ajustes = ref.watch(ajustesProvider);
    final estudiado = ajustes.temasEstudiados.contains(widget.tema.codigo);
    final repaso = ajustes.temasEnRepaso.contains(widget.tema.codigo);
    final pendientes = (ref.watch(agendasProvider)[widget.tema.codigo]?.pendientes ?? const []).length;
    final conNota = ref.read(usuarioRepoProvider).nota(widget.tema.codigo).isNotEmpty;
    // El preparador consulta el tema: sin marcar estudiado ni repaso.
    final preparador = ref.watch(papelProvider) == Papel.preparador;

    // Temario revisado: qué versión se enseña.
    final conSesion = ref.watch(usuarioActualProvider) != null && ref.read(serviciosProvider).firebaseDisponible;
    final estadoRevisados = widget.esRecurso ? null : ref.watch(revisadosProvider);
    final rev = estadoRevisados?.valueOrNull?.de(widget.tema.codigo);
    final eleccion = elegirVersion(revisado: rev, conSesion: conSesion, pideAnterior: _pideAnterior, hayAnterior: widget.tema.url != null);
    // La revisada, si es la que se enseña.
    final TemaRevisado? rv = eleccion.esRevisada ? rev : null;
    final revisada = rv != null;
    // Exclusivo (uso personal): se lee dentro de la app; sin compartir, sin Word y sin descargar anotado.
    final exclusivo = rv?.exclusivo ?? false;
    // Con sesión, se espera al manifiesto antes de abrir nada (para no bajar
    // la versión anterior y luego la revisada).
    final listo = estadoRevisados == null || !conSesion || estadoRevisados.hasValue || estadoRevisados.hasError;

    final sinPdf = !revisada && widget.tema.url == null;
    final web = !revisada && widget.tema.esPaginaWeb;
    final verHtml = rv != null && _verHtml && rv.html != null;
    final _FuentePdf? fuente = rv != null
        ? (url: rv.url(rv.pdf), nombre: rv.nombreLocal(ClaseFichero.pdf), reemplaza: rv.prefijoLocal(ClaseFichero.pdf))
        : (widget.tema.url == null || web ? null : (url: widget.tema.url!, nombre: widget.nombreDescarga, reemplaza: widget.reemplazaDescarga));
    final clave = fuente == null ? null : '${fuente.url}|${fuente.nombre}';
    if (listo && clave != _claveCargada) {
      _claveCargada = clave;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _claveCargada != clave) return;
        fuente == null ? _vaciar() : _cargar(fuente);
      });
    }
    if (verHtml) WidgetsBinding.instance.addPostFrameCallback((_) => mounted ? _cargarHtml(rv) : null);
    // Solo con el PDF abierto (Firestore no hace falta hasta entonces).
    final anotaciones = _pdf == null ? null : _anotacionesDe(revisada ? '${widget.tema.codigo}-revisado' : widget.tema.codigo);
    // El esquema del PDF que se lee: el del manifiesto en el revisado, el de
    // esquemas.json en el de la web. Al lado en pantallas anchas; en el móvil,
    // en una hoja desde la barra de páginas.
    final List<EntradaEsquema>? esquema = _pdf == null || verHtml || sinPdf || web
        ? null
        : revisada
            ? (rv.esquema.isEmpty ? null : rv.esquema)
            : ref.watch(esquemasProvider).valueOrNull?.de(widget.tema.url);
    final pantallaAncha = MediaQuery.sizeOf(context).width >= 900;
    final esquemaAlLado = esquema != null && pantallaAncha && _verEsquema && !_anotando;

    return Scaffold(
      appBar: BarraWeb(
        title: Text(widget.esRecurso ? widget.tema.titulo : (widget.tema.codigo == codigoDictamen ? 'Guía del dictamen' : 'Tema ${widget.tema.codigo}'), overflow: TextOverflow.ellipsis),
        actions: [
          if (!widget.esRecurso && !sinPdf)
            IconButton(
              tooltip: preparador ? 'Notas y test del tema' : 'Agenda del tema: apuntes para la próxima vuelta y notas',
              icon: Badge(
                isLabelVisible: pendientes > 0,
                label: Text('$pendientes'),
                child: Icon(pendientes > 0 || conNota ? Icons.sticky_note_2 : Icons.sticky_note_2_outlined, color: pendientes > 0 || conNota ? context.colores.dorado : null),
              ),
              onPressed: _abrirAgenda,
            ),
          if (rv?.html != null && !_anotando)
            IconButton(
              tooltip: verHtml ? 'Leer en PDF' : 'Leer como página web',
              icon: Icon(verHtml ? Icons.picture_as_pdf_outlined : Icons.article_outlined),
              onPressed: () => setState(() => _verHtml = !_verHtml),
            ),
          if (_pdf != null && !widget.esRecurso && !verHtml)
            IconButton(
              tooltip: _anotando ? 'Dejar de anotar' : 'Pintar y subrayar',
              isSelected: _anotando,
              icon: const Icon(Icons.draw_outlined),
              selectedIcon: const Icon(Icons.draw),
              onPressed: () => _alternarAnotar(anotaciones),
            ),
          if (_ruta != null && !verHtml && !exclusivo)
            IconButton(
              tooltip: 'Compartir PDF',
              icon: const Icon(Icons.share_outlined),
              onPressed: () => SharePlus.instance.share(ShareParams(files: [XFile(_ruta!)], text: '${widget.tema.codigo} ${widget.tema.titulo}${revisada ? ' (revisado)' : ''}')),
            ),
          if (fuente != null && !verHtml) PopupMenuButton<String>(
            onSelected: (v) async {
              if (v == 'web') {
                abrirUrl(context, widget.tema.url);
                return;
              }
              if (v == 'anotado') {
                await _descargarAnotado(revisada);
                return;
              }
              if (v == 'borrar') {
                final nav = Navigator.of(context);
                await ref.read(descargasProvider).borrar(fuente.url, nombre: fuente.nombre);
                nav.pop();
              }
            },
            itemBuilder: (_) => [
              // El revisado no tiene página pública: no se abre fuera de la app.
              if (!revisada && widget.nombreDescarga == null) PopupMenuItem(value: 'web', child: Text(kIsWeb ? 'Abrir en otra pestaña' : 'Abrir en el navegador')),
              if (_pdf != null && anotaciones != null && !exclusivo) const PopupMenuItem(value: 'anotado', child: Text('Descargar con mis anotaciones')),
              if (ref.read(descargasProvider).guardaSinConexion) const PopupMenuItem(value: 'borrar', child: Text('Eliminar descarga')),
            ],
          ),
        ],
      ),
      body: Column(children: [
        if (!widget.esRecurso && !_anotando) _FilaMateriales(codigo: widget.tema.codigo),
        if (rev != null && !_anotando)
          _BarraRevisado(
            revisado: rev,
            eleccion: eleccion,
            entrar: _entrar,
            cambiar: () => setState(() {
              _pideAnterior = !_pideAnterior;
              _verHtml = false;
            }),
            abrir: (c) => _abrirFichero(rev, c),
          ),
        if (!widget.esRecurso && !_anotando)
          Material(
            color: context.colores.superficie,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: Row(children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                    Text(widget.tema.titulo, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
                    // Cuánto cae en el test del primer ejercicio (solo los temas que entran en él).
                    if (ref.watch(frecuenciaTestProvider).valueOrNull case final f? when f.temas.containsKey(widget.tema.codigo))
                      InkWell(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PreguntasPorTemaPage())),
                        child: Text('En el test: ${textoFrecuencia(f, widget.tema.codigo)} · ver por tema', style: context.textos.labelSmall?.copyWith(decoration: TextDecoration.underline)),
                      ),
                  ]),
                ),
                if (!preparador && listaControlDisponible(esquemaDelTema(ref, widget.tema)))
                  IconButton(
                    tooltip: 'Esquema a ciegas',
                    icon: Icon(Icons.psychology_outlined, color: context.esquema.primary),
                    onPressed: () => abrirEsquemaCiegas(context, widget.tema.codigo),
                  ),
                if (!preparador) IconButton(
                  tooltip: 'En repaso',
                  icon: Icon(Icons.replay, color: repaso ? context.esquema.primary : context.colores.textoClaro),
                  onPressed: () => ref.read(ajustesProvider.notifier).alternarRepaso(widget.tema.codigo),
                ),
                if (!preparador) FilterChip(
                  label: Text(estudiado ? 'Estudiado' : 'Marcar estudiado'),
                  selected: estudiado,
                  avatar: estudiado ? const Icon(Icons.check, size: 16) : null,
                  onSelected: (_) => ref.read(ajustesProvider.notifier).alternarEstudiado(widget.tema.codigo),
                ),
              ]),
            ),
          ),
        Expanded(
          child: !listo
              ? const Cargando()
              : verHtml
              ? (_errorHtml != null
                  ? ErrorVista(error: _errorHtml!, reintentar: () => setState(() { _errorHtml = null; _shaHtml = null; }))
                  : _htmlCrudo == null
                      ? Cargando(texto: kIsWeb ? 'Cargando el tema…' : 'Descargando el tema…')
                      : VisorHtml(key: ValueKey('$_shaHtml|${context.temaOscuro}'), html: _htmlDelVisor(rv), urlDocumento: rv.urlDocumentoHtml!))
              : sinPdf
              ? AgendaTemaVista(tema: widget.tema)
              : web
              ? Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
                    child: Tarjeta(
                      color: context.colores.primarioPalido,
                      onTap: () => abrirUrl(context, widget.tema.url, enApp: true),
                      child: Row(children: [
                        Icon(Icons.menu_book_outlined, color: context.esquema.primary),
                        const SizedBox(width: 12),
                        Expanded(child: Text('Los apuntes de este tema están en la web.', style: context.textos.bodySmall)),
                        FilledButton(onPressed: () => abrirUrl(context, widget.tema.url, enApp: true), child: const Text('Leer el tema')),
                      ]),
                    ),
                  ),
                  Expanded(child: AgendaTemaVista(tema: widget.tema)),
                ])
              : _error != null
              ? ErrorVista(error: _error!, detalle: true, reintentar: () => setState(() { _error = null; _claveCargada = null; }))
              : _pdf == null
                  ? Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(width: 160, child: LinearProgressIndicator(value: _progreso == 0 ? null : _progreso)),
                        const SizedBox(height: 12),
                        Text(_progreso == 0 ? (kIsWeb ? 'Cargando PDF…' : 'Descargando PDF…') : 'Descargando ${(100 * _progreso).round()} %', style: context.textos.bodySmall),
                      ]),
                    )
                  : _conEsquema(
                      esquemaAlLado ? esquema : null,
                      VisorTema(
                        key: ValueKey(_claveCargada),
                        documento: _pdf!,
                        fuente: anotaciones,
                        miUid: ref.read(usuarioActualProvider)?.uid ?? '',
                        controlador: _visor,
                        anotando: _anotando,
                        alCargar: (n) => setState(() => _paginas = n),
                        alCambiarPagina: (p) => setState(() => _pagina = p),
                        alAcabar: () => setState(() => _anotando = false),
                      ),
                    ),
        ),
        if (_paginas > 0 && !_anotando && !verHtml)
          SafeArea(
            top: false,
            child: Container(
              color: context.colores.superficie,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(children: [
                if (esquema != null)
                  IconButton(
                    tooltip: pantallaAncha ? (_verEsquema ? 'Ocultar el esquema' : 'Ver el esquema al lado') : 'Esquema del tema: saltar de bloque',
                    visualDensity: VisualDensity.compact,
                    isSelected: pantallaAncha && _verEsquema,
                    icon: const Icon(Icons.toc),
                    onPressed: pantallaAncha ? () => setState(() => _verEsquema = !_verEsquema) : () => abrirEsquema(context, esquema: esquema, pagina: _pagina, alIr: _visor.irAPagina),
                  ),
                Text('Página $_pagina de $_paginas', style: context.textos.labelSmall),
                Expanded(
                  child: Slider(
                    value: _pagina.toDouble().clamp(1, _paginas.toDouble()),
                    min: 1,
                    max: _paginas.toDouble(),
                    onChanged: (v) => _visor.irAPagina(v.round()),
                  ),
                ),
              ]),
            ),
          ),
      ]),
    );
  }
}

/// Materiales que el preparador ha compartido para este tema (sobre el PDF,
/// sin robarle sitio): uno se abre directamente; varios, en una hoja.
class _FilaMateriales extends ConsumerWidget {
  const _FilaMateriales({required this.codigo});
  final String codigo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materiales = ref.watch(materialesDeTemaProvider(codigo));
    if (materiales.isEmpty) return const SizedBox.shrink();
    final uno = materiales.length == 1 ? materiales.first : null;
    return Material(
      color: context.colores.primarioPalido,
      child: ListTile(
        dense: true,
        leading: Icon(uno == null ? Icons.folder_shared_outlined : iconoMaterial(uno.tipo), color: context.esquema.primary),
        title: Text(uno == null ? '${materiales.length} materiales de tu preparador' : uno.titulo, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.titleSmall),
        subtitle: Text(uno == null ? 'Toca para verlos' : 'De ${uno.preparadorNombre.isEmpty ? 'tu preparador' : uno.preparadorNombre} · ${uno.dominio}', style: context.textos.labelSmall),
        trailing: Icon(uno == null ? Icons.chevron_right : Icons.open_in_new, size: 18),
        onTap: () => uno == null ? mostrarMaterialesDeTema(context, materiales) : abrirUrl(context, uno.url),
      ),
    );
  }
}

/// Distintivo del temario revisado sobre el tema: con sesión, «Revisado ·
/// exclusivo de la app», la ficha de repaso, el Word y el paso a la versión
/// anterior (y vuelta); sin sesión, la invitación a entrar.
class _BarraRevisado extends StatelessWidget {
  const _BarraRevisado({required this.revisado, required this.eleccion, required this.entrar, required this.cambiar, required this.abrir});
  final TemaRevisado revisado;
  final EleccionVersion eleccion;
  final VoidCallback entrar;
  final VoidCallback cambiar;
  final ValueChanged<ClaseFichero> abrir;

  @override
  Widget build(BuildContext context) {
    final compacto = TextButton.styleFrom(visualDensity: VisualDensity.compact, padding: const EdgeInsets.symmetric(horizontal: 8));
    final textoPequeno = context.textos.bodySmall?.copyWith(color: context.esquema.onSurface);
    final Widget contenido;
    if (eleccion.invitarASesion) {
      contenido = Row(children: [
        Icon(Icons.verified_outlined, color: context.esquema.primary),
        const SizedBox(width: 10),
        Expanded(child: Text('Versión revisada disponible: inicia sesión para leerla', style: textoPequeno)),
        const SizedBox(width: 8),
        FilledButton(onPressed: entrar, child: const Text('Entrar')),
      ]);
    } else if (eleccion.esRevisada) {
      final aprobado = revisado.aprobado;
      contenido = Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Wrap(spacing: 8, runSpacing: 4, crossAxisAlignment: WrapCrossAlignment.center, children: [
          Etiqueta(revisado.exclusivo ? 'Exclusivo · uso personal' : 'Revisado · exclusivo de la app'),
          if (aprobado != null) Text('Versión del ${_fecha(aprobado)}', style: context.textos.labelSmall),
          if (revisado.exclusivo)
            Tooltip(
              message: avisoExclusivo,
              child: InkWell(onTap: () => abrirUrl(context, urlCondicionesMateriales, enApp: true), child: Text('Solo lectura en la app · condiciones', style: context.textos.labelSmall?.copyWith(decoration: TextDecoration.underline))),
            ),
        ]),
        const SizedBox(height: 2),
        Wrap(spacing: 4, crossAxisAlignment: WrapCrossAlignment.center, children: [
          if (revisado.repaso != null)
            TextButton.icon(style: compacto, onPressed: () => abrir(ClaseFichero.repaso), icon: const Icon(Icons.summarize_outlined, size: 18), label: Text(revisado.esDictamen ? 'Resumen de repaso' : 'Ficha de repaso')),
          if (revisado.docx != null && !revisado.exclusivo)
            TextButton.icon(style: compacto, onPressed: () => abrir(ClaseFichero.docx), icon: const Icon(Icons.description_outlined, size: 18), label: const Text('Word')),
          if (eleccion.puedeCambiar)
            TextButton.icon(style: compacto, onPressed: cambiar, icon: const Icon(Icons.history, size: 18), label: const Text('Ver versión anterior')),
        ]),
      ]);
    } else {
      contenido = Row(children: [
        Icon(Icons.history, color: context.colores.textoClaro),
        const SizedBox(width: 10),
        Expanded(child: Text('Estás viendo la versión anterior del tema.', style: textoPequeno)),
        TextButton(style: compacto, onPressed: cambiar, child: const Text('Ver versión revisada')),
      ]);
    }
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: context.colores.primarioPalido,
        child: Padding(padding: const EdgeInsets.fromLTRB(16, 8, 8, 6), child: contenido),
      ),
    );
  }

  static String _fecha(DateTime d) => '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}
