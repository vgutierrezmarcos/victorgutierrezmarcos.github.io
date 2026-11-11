import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';
import '../../data/models/esquema.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../data/models/revisado.dart';
import '../../data/models/temario.dart';
import '../../data/repos/descargas_repo.dart';
import '../../data/repos/usuario_repo.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/sincronizar.dart';
import '../test/config_test_page.dart';
import '../test/motor_test.dart';
import '../../data/models/coyuntura.dart';
import '../organizacion/coyuntura_page.dart';
import 'esquema_tema.dart';
import 'tema_page.dart';

/// Temario: ejercicios → partes → temas, con estado de estudio y descarga offline.
/// Es la subpestaña TEMAS de Estudiar; [pestanas] (los botones) va bajo el buscador, ya en el cuerpo.
class TemarioPage extends ConsumerStatefulWidget {
  const TemarioPage({super.key, this.pestanas});
  final Widget? pestanas;
  @override
  ConsumerState<TemarioPage> createState() => _TemarioPageState();
}

class _TemarioPageState extends ConsumerState<TemarioPage> with _FilasTemario {
  /// El preparador consulta el temario: sin marcar estudiados, repaso ni apuntes de vuelta.
  @override
  bool _preparador = false;

  String _busqueda = '';
  @override
  Color? Function(String) _colorDe = (_) => null;

  /// Temas revisados, exclusivos de la app (vacío hasta que se descarga).
  @override
  ManifiestoRevisados _revisados = ManifiestoRevisados.vacio;

  @override
  Widget build(BuildContext context) {
    _preparador = ref.watch(papelProvider) == Papel.preparador;
    final temario = ref.watch(temarioProvider);
    final ajustes = ref.watch(ajustesProvider);
    final descargas = ref.watch(descargasProvider);
    final notas = ref.read(usuarioRepoProvider).todasLasNotas();
    final agendas = ref.watch(agendasProvider);
    // Código de colores de la organización del temario (vacío hasta que se descarga).
    final estructura = ref.watch(estructuraProvider).valueOrNull;
    _colorDe = (codigo) => estructura?.colorDe(codigo);
    _revisados = ref.watch(revisadosProvider).valueOrNull ?? ManifiestoRevisados.vacio;
    int apuntes(String codigo) => agendas[codigo]?.pendientes.length ?? 0;

    return Scaffold(
      appBar: BarraWeb(
        conOposicion: widget.pestanas != null,
        title: Text(widget.pestanas == null ? 'Temario' : 'Estudiar'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar tema o epígrafe (3A7, Keynes, Mundell)…',
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                suffixIcon: _busqueda.isEmpty ? null : IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() => _busqueda = '')),
              ),
              onChanged: (v) => setState(() => _busqueda = v),
            ),
          ),
        ),
      ),
      body: Column(children: [
        if (widget.pestanas != null) widget.pestanas!,
        Expanded(child: _cuerpo(temario, ajustes, descargas, notas, agendas, apuntes)),
      ]),
    );
  }

  Widget _cuerpo(AsyncValue<Temario> temario, Ajustes ajustes, DescargasRepo descargas, Map<String, String> notas, Map<String, AgendaTema> agendas, int Function(String) apuntes) {
    return temario.when(
      loading: () => const Cargando(),
      error: (e, _) => ErrorVista(error: e, reintentar: () => ref.invalidate(temarioProvider)),
      data: (t) {
        if (_soloExclusivos && _busqueda.trim().isEmpty) {
          // Materiales exclusivos (uso personal): los temas revisados desde el 1 oct. 2026.
          final res = t.todosLosTemas.where((x) => _revisados.de(x.codigo)?.exclusivo == true).toList();
          return Refrescable(
              child: ListaAdaptable(padding: const EdgeInsets.all(16), children: [
            _filtroExclusivos(res.length),
            const SizedBox(height: 6),
            Text(res.isEmpty ? 'Aún no hay materiales exclusivos descargados: inicia sesión y sincroniza.' : 'Temas revisados a fondo, con datos al día y gráficos nuevos, en PDF, Word y página web, con ficha de repaso. Son de uso personal y se leen dentro de la app.', style: context.textos.bodySmall),
            const SizedBox(height: 6),
            for (final x in res) _filaTema(x, ajustes.temasEstudiados.contains(x.codigo), ajustes.temasEnRepaso.contains(x.codigo), _descargado(x), notas.containsKey(x.codigo), apuntes(x.codigo)),
          ]));
        }
        if (_busqueda.trim().isNotEmpty) {
          final q = _normalizar(_busqueda);
          final res = t.todosLosTemas.where((x) => _normalizar('${x.codigo} ${x.titulo}').contains(q) || _normalizar(x.codigo.replaceAll('.', '')).contains(q.replaceAll('.', '').replaceAll(' ', ''))).toList();
          // También dentro de los temas: los epígrafes de cada PDF, y se abre en su página.
          final esquemas = <Tema, List<EntradaEsquema>>{
            for (final x in t.todosLosTemas)
              if (x.disponible)
                if (esquemaDelTema(ref, x) case final e?) x: e,
          };
          final epigrafes = buscarEpigrafes(esquemas, _busqueda);
          return Refrescable(
              child: ListaAdaptable(padding: const EdgeInsets.all(16), children: [
            Text('${res.length} ${res.length == 1 ? 'tema' : 'temas'}${epigrafes.isEmpty ? '' : ' · ${epigrafes.length}${epigrafes.length >= 40 ? ' o más' : ''} epígrafes'}', style: context.textos.bodySmall),
            for (final x in res) _filaTema(x, ajustes.temasEstudiados.contains(x.codigo), ajustes.temasEnRepaso.contains(x.codigo), _descargado(x), notas.containsKey(x.codigo), apuntes(x.codigo)),
            if (epigrafes.isNotEmpty) ...[
              const TituloSeccion('Dentro de los temas'),
              Tarjeta(
                padding: EdgeInsets.zero,
                child: Column(children: [
                  for (final e in epigrafes)
                    ListTile(
                      dense: true,
                      leading: Icon(Icons.subdirectory_arrow_right, size: 18, color: context.esquema.primary),
                      title: Text(e.entrada.titulo, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
                      subtitle: Text('${e.tema.codigo} · ${e.tema.titulo} · pág. ${e.entrada.pagina}', maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.labelSmall),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => TemaPage(tema: e.tema, paginaInicial: e.entrada.pagina))),
                    ),
                ]),
              ),
            ],
          ]));
        }
        // En TCEE todos los temas tienen PDF; en una oposición que aún publica sus
        // apuntes, el progreso es sobre el programa entero.
        final total = Oposiciones.actual.esPrincipal ? t.todosLosTemas.where((x) => x.disponible).length : t.todosLosTemas.length;
        final estudiados = ajustes.temasEstudiados.length;
        return Refrescable(
            child: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            if (_revisados.exclusivos.isNotEmpty) _filtroExclusivos(_revisados.exclusivos.length),
            if (!_preparador)
              Tarjeta(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Text('Progreso: $estudiados temas marcados como estudiados', style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
                    Text('${total == 0 ? 0 : (100 * estudiados / total).round()} %', style: context.textos.titleMedium?.copyWith(color: context.esquema.primary)),
                  ]),
                  const SizedBox(height: 8),
                  ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: total == 0 ? 0 : estudiados / total, minHeight: 8, backgroundColor: context.colores.borde)),
                ]),
              ),
            const SizedBox(height: 6),
            // Un ejercicio, una tarjeta: dentro, sus recursos y sus partes (EjercicioPage).
            for (final ej in t.ejercicios) _tarjetaEjercicio(ej, ajustes),
          ],
        ));
      },
    );
  }

  bool _soloExclusivos = false;

  /// Tarjeta de un ejercicio: qué hay dentro y cómo va; abre su página.
  Widget _tarjetaEjercicio(Ejercicio ej, Ajustes ajustes) {
    final temas = [for (final p in ej.partes) ...p.temas];
    final estudiados = temas.where((x) => ajustes.temasEstudiados.contains(x.codigo)).length;
    final revisados = temas.where((x) => _revisados.de(x.codigo) != null).length;
    final principal = Oposiciones.actual.esPrincipal;
    final String resumen;
    if (temas.isEmpty && ej.id == 1 && principal) {
      resumen = 'Simulador de test, test diario, exámenes oficiales y la guía del dictamen';
    } else if (temas.isEmpty && ej.partes.isNotEmpty) {
      resumen = '${ej.partes.length} partes en PDF';
    } else if (temas.isEmpty) {
      resumen = ej.recursos.isEmpty ? 'Descripción de la prueba' : '${ej.recursos.length} recursos';
    } else {
      resumen = [
        '${temas.length} temas',
        if (!_preparador) '$estudiados estudiados',
        if (revisados > 0) '$revisados revisados',
        if (!principal) '${temas.where((x) => x.disponible).length} publicados',
      ].join(' · ');
    }
    final icono = switch (ej.id) { 1 => Icons.fact_check_outlined, 2 => Icons.translate, 5 => Icons.gavel_outlined, _ => Icons.menu_book_outlined };
    return Tarjeta(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => EjercicioPage(ejercicio: ej))),
      child: Row(children: [
        Icon(icono, color: context.esquema.primary),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(ej.nombre, style: context.textos.titleMedium),
            if (ej.descripcion.isNotEmpty) Text(ej.descripcion, style: TextStyle(fontFamily: Fuentes.serif, fontStyle: FontStyle.italic, fontSize: 14, color: context.colores.textoSuave)),
            const SizedBox(height: 2),
            Text(resumen, style: context.textos.labelSmall),
          ]),
        ),
        Icon(Icons.chevron_right, color: context.colores.textoClaro),
      ]),
    );
  }

  /// Chip «Solo exclusivos»: la sección de materiales exclusivos del temario.
  Widget _filtroExclusivos(int n) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Wrap(spacing: 8, crossAxisAlignment: WrapCrossAlignment.center, children: [
          FilterChip(
            avatar: _soloExclusivos ? null : const Icon(Icons.workspace_premium_outlined, size: 18),
            label: Text(_soloExclusivos ? 'Solo exclusivos · $n' : 'Materiales exclusivos · $n'),
            selected: _soloExclusivos,
            onSelected: (v) => setState(() => _soloExclusivos = v),
          ),
          if (_soloExclusivos) TextButton(onPressed: () => abrirUrl(context, urlCondicionesMateriales, enApp: true), child: const Text('Condiciones de uso')),
        ]),
      );

}

/// Lo que comparten la pestaña Temas y la página de cada ejercicio: las filas
/// de tema, parte y recurso, el test diario y lo descargado.
mixin _FilasTemario<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  bool get _preparador;
  Color? Function(String) get _colorDe;
  ManifiestoRevisados get _revisados;

  /// Al principio de Temas, el camino a la otra subpestaña: el test diario
  /// (se abre si aún no está hecho; si no, la pestaña Test).
  Widget _enlaceTest() {
    final hecho = ref.watch(testDiarioHechoProvider);
    return Aviso(
      icono: Icons.fact_check_outlined,
      titulo: 'Test diario',
      texto: hecho ? 'Hecho hoy. Más tests, en la pestaña Test' : '10 preguntas de exámenes oficiales',
      onTap: () {
        final banco = ref.read(preguntasProvider).valueOrNull;
        if (hecho || banco == null) {
          ref.read(subpestanaEstudiarProvider.notifier).state = 1;
          return;
        }
        context.push('/examen', extra: ConfigTest(idsFijos: MotorTest.testDiario(banco, DateTime.now()).map((p) => p.id).toList(), minutos: 15, tipo: 'diario'));
      },
    );
  }

  /// Descargado para leer sin red (la versión anterior o la revisada).
  bool _descargado(Tema x) {
    final descargas = ref.read(descargasProvider);
    if (x.url != null && descargas.descargado(x.url!)) return true;
    final rev = _revisados.de(x.codigo);
    return rev != null && descargas.descargado(rev.url(rev.pdf), nombre: rev.nombreLocal(ClaseFichero.pdf));
  }

  Widget _filaTema(Tema x, bool estudiado, bool repaso, bool offline, bool conNota, int apuntes) {
    final rev = _revisados.de(x.codigo);
    final revisado = rev != null;
    return ListTile(
      dense: true,
      leading: _preparador
          ? Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Icon(Icons.description_outlined, color: context.colores.textoClaro))
          : IconButton(
              icon: Icon(estudiado ? Icons.check_circle : Icons.circle_outlined, color: estudiado ? Paleta.acierto : context.colores.textoClaro),
              tooltip: 'Estudiado',
              onPressed: () => ref.read(ajustesProvider.notifier).alternarEstudiado(x.codigo),
            ),
      title: TextoTema(x.codigo, x.titulo, atenuado: !x.disponible && !revisado, color: _colorDe(x.codigo)),
      subtitle: Wrap(crossAxisAlignment: WrapCrossAlignment.center, runSpacing: 2, children: [
        if (revisado) Padding(padding: const EdgeInsets.only(right: 6), child: Etiqueta(rev.exclusivo ? 'Exclusivo · revisado' : 'Revisado · exclusivo de la app')),
        if (!x.disponible && !revisado) Padding(padding: const EdgeInsets.only(right: 6), child: Text(Oposiciones.actual.esPrincipal ? 'Sin PDF' : 'En preparación', style: context.textos.labelSmall)),
        if (x.temarioAnterior) Padding(padding: const EdgeInsets.only(right: 6), child: Etiqueta('Temario anterior', color: context.colores.dorado)),
        if (offline && !x.pdfDeParte) Icon(Icons.offline_pin, size: 14, color: context.colores.textoClaro),
        if (repaso && !_preparador) Padding(padding: const EdgeInsets.only(left: 4), child: Icon(Icons.replay, size: 14, color: context.esquema.primary)),
        if (!_preparador && ref.watch(ajustesProvider).noCantar.containsKey(x.codigo)) Padding(padding: const EdgeInsets.only(left: 4), child: Tooltip(message: 'Has pedido no cantarlo por ahora', child: Icon(Icons.mic_off_outlined, size: 14, color: context.colores.textoClaro))),
        if (conNota) Padding(padding: const EdgeInsets.only(left: 4), child: Icon(Icons.sticky_note_2_outlined, size: 14, color: context.colores.dorado)),
        if (apuntes > 0 && !_preparador) Padding(padding: const EdgeInsets.only(left: 6), child: Etiqueta(apuntes == 1 ? '1 apunte' : '$apuntes apuntes', color: context.colores.dorado)),
      ]),
      // Los temas sin PDF también se abren: muestran su agenda (apuntes, vueltas y nota).
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => TemaPage(tema: x.disponible ? x : Tema(codigo: x.codigo, titulo: x.titulo, disponible: false, temarioAnterior: x.temarioAnterior)))),
    );
  }

  Widget _filaParte(Parte p, bool offline) => Tarjeta(
        padding: EdgeInsets.zero,
        child: ListTile(
          enabled: p.disponible,
          leading: Icon(Icons.picture_as_pdf_outlined, color: p.disponible ? context.esquema.primary : context.colores.textoClaro),
          title: Text('Parte ${p.letra}: ${p.nombre}', style: context.textos.titleSmall),
          subtitle: Text(p.disponible ? (offline ? 'Descargado' : 'PDF completo de la parte') : 'No disponible', style: context.textos.labelSmall),
          onTap: p.disponible ? () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => TemaPage(tema: Tema(codigo: '5.${p.letra}', titulo: p.nombre, disponible: true, temarioAnterior: true, url: p.url)))) : null,
        ),
      );

  Widget _filaRecurso(Recurso r, bool offline) => Tarjeta(
        padding: EdgeInsets.zero,
        child: ListTile(
          leading: Icon(switch (r.tipo) { 'pdf' => Icons.picture_as_pdf_outlined, 'app' => Icons.web, 'xlsm' => Icons.table_chart_outlined, _ => Icons.description_outlined }, color: context.esquema.primary),
          title: Text(r.titulo, style: context.textos.titleSmall),
          subtitle: r.descripcion.isEmpty ? null : Text(r.descripcion, style: context.textos.labelSmall),
          trailing: r.tipo == 'pdf' ? null : const Icon(Icons.open_in_new, size: 18),
          onTap: () {
            if (r.tipo == 'pdf') {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => TemaPage(tema: Tema(codigo: r.id, titulo: r.titulo, disponible: true, temarioAnterior: false, url: r.url), esRecurso: true)));
            } else {
              abrirUrl(context, r.url);
            }
          },
        ),
      );
}

/// Un ejercicio del temario: sus recursos y sus partes con los temas. El primero
/// de TCEE lleva en cabeza el simulador y el test diario, y después el bloque
/// del dictamen de coyuntura con la guía (revisada, exclusiva de la app, con la
/// anterior como «versión anterior»), su resumen y los exámenes oficiales.
class EjercicioPage extends ConsumerStatefulWidget {
  const EjercicioPage({super.key, required this.ejercicio});
  final Ejercicio ejercicio;
  @override
  ConsumerState<EjercicioPage> createState() => _EjercicioPageState();
}

class _EjercicioPageState extends ConsumerState<EjercicioPage> with _FilasTemario {
  @override
  bool _preparador = false;
  @override
  Color? Function(String) _colorDe = (_) => null;
  @override
  ManifiestoRevisados _revisados = ManifiestoRevisados.vacio;

  @override
  Widget build(BuildContext context) {
    _preparador = ref.watch(papelProvider) == Papel.preparador;
    final ajustes = ref.watch(ajustesProvider);
    final descargas = ref.watch(descargasProvider);
    final notas = ref.read(usuarioRepoProvider).todasLasNotas();
    final agendas = ref.watch(agendasProvider);
    final estructura = ref.watch(estructuraProvider).valueOrNull;
    _colorDe = (codigo) => estructura?.colorDe(codigo);
    _revisados = ref.watch(revisadosProvider).valueOrNull ?? ManifiestoRevisados.vacio;
    int apuntes(String codigo) => agendas[codigo]?.pendientes.length ?? 0;
    final ej = widget.ejercicio;
    final principal = Oposiciones.actual.esPrincipal;
    final conTestYDictamen = ej.id == 1 && principal && ej.partes.isEmpty;
    bool deDictamen(Recurso r) => r.titulo.toLowerCase().contains('dictamen');
    // La guía antigua (el esquema en PDF): queda como «versión anterior» de la guía revisada.
    final guiaAnterior = ej.recursos.where((r) => deDictamen(r) && r.tipo == 'pdf' && r.titulo.toLowerCase().startsWith('esquema')).firstOrNull;
    final dictamen = _revisados.dictamen;

    return Scaffold(
      appBar: BarraWeb(title: Text(ej.nombre)),
      body: Refrescable(
        child: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            if (ej.descripcion.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
                child: Text(ej.descripcion, style: TextStyle(fontFamily: Fuentes.serif, fontStyle: FontStyle.italic, fontSize: 15, color: context.colores.textoSuave)),
              ),
            if (conTestYDictamen) ...[
              const TituloSeccion('Test'),
              Tarjeta(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ConfigTestPage())),
                child: Row(children: [
                  Icon(Icons.quiz_outlined, color: context.esquema.primary, size: 28),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Simulador de test', style: context.textos.titleMedium),
                      Text('Las ${_preguntas()} preguntas de los exámenes oficiales, por examen o por temas, con tu historial', style: context.textos.labelSmall),
                    ]),
                  ),
                  Icon(Icons.chevron_right, color: context.colores.textoClaro),
                ]),
              ),
              if (!_preparador) _enlaceTest(),
              for (final r in ej.recursos)
                if (!deDictamen(r) && r.tipo != 'app') _filaRecurso(r, descargas.descargado(r.url)),
              const SizedBox(height: 6),
              const TituloSeccion('Dictamen de coyuntura'),
              _filaGuiaDictamen(guiaAnterior, dictamen, descargas),
              Tarjeta(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CoyunturaPage())),
                child: Row(children: [
                  Icon(Icons.query_stats, color: context.esquema.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Cuadro de coyuntura', style: context.textos.titleSmall),
                      Text(resumenCoyuntura(ref.watch(coyunturaProvider).valueOrNull ?? Coyuntura.vacia), style: context.textos.labelSmall),
                    ]),
                  ),
                  const Icon(Icons.chevron_right),
                ]),
              ),
              for (final r in ej.recursos)
                if (deDictamen(r) && r != guiaAnterior) _filaRecurso(r, descargas.descargado(r.url)),
            ] else ...[
              if (ej.id == 2 && ej.partes.isEmpty && ej.recursos.isEmpty)
                Tarjeta(onTap: () => abrirUrl(context, ej.urlPagina, enApp: true), child: Row(children: [Expanded(child: Text('Descripción de la prueba de idiomas en la web', style: context.textos.titleSmall)), const Icon(Icons.open_in_new, size: 18)])),
              for (final r in ej.recursos) _filaRecurso(r, descargas.descargado(r.url)),
              for (final p in ej.partes)
                if (p.temas.isEmpty)
                  _filaParte(p, p.url != null && descargas.descargado(p.url!))
                else
                  GrupoDesplegable(
                    titulo: 'Parte ${p.letra}: ${p.nombre}',
                    subtitulo: [
                      if (!_preparador) '${p.temas.where((x) => ajustes.temasEstudiados.contains(x.codigo)).length} de ${p.temas.length} estudiados' else '${p.temas.length} temas',
                      '${p.temas.where((x) => x.disponible).length} ${principal ? 'con PDF' : 'publicados'}',
                    ].join(' · '),
                    children: [
                      // Quinto ejercicio: un único PDF con todos los temas de la parte.
                      if (p.url != null)
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.picture_as_pdf_outlined, color: context.esquema.primary),
                          title: Text('PDF completo de la parte', style: context.textos.titleSmall?.copyWith(color: context.esquema.primary)),
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => TemaPage(tema: Tema(codigo: '${ej.id}.${p.letra}', titulo: p.nombre, disponible: true, temarioAnterior: false, url: p.url, pdfDeParte: true)))),
                        ),
                      for (final x in p.temas) _filaTema(x, ajustes.temasEstudiados.contains(x.codigo), ajustes.temasEnRepaso.contains(x.codigo), _descargado(x), notas.containsKey(x.codigo), apuntes(x.codigo)),
                    ],
                  ),
            ],
          ],
        ),
      ),
    );
  }

  String _preguntas() {
    final n = ref.watch(preguntasProvider).valueOrNull?.preguntas.length;
    return n == null ? '' : '$n ';
  }

  /// La guía del dictamen: la revisada (exclusiva, con su resumen de repaso) si
  /// el manifiesto la trae; si no, el esquema antiguo. La ficha decide qué
  /// versión enseña (con sesión, la revisada; sin ella, la anterior y la invitación).
  Widget _filaGuiaDictamen(Recurso? anterior, TemaRevisado? dictamen, DescargasRepo descargas) {
    if (anterior == null && dictamen == null) return const SizedBox.shrink();
    final offline = (anterior != null && descargas.descargado(anterior.url)) || (dictamen != null && descargas.descargado(dictamen.url(dictamen.pdf), nombre: dictamen.nombreLocal(ClaseFichero.pdf)));
    return Tarjeta(
      padding: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(Icons.menu_book_outlined, color: context.esquema.primary),
        title: Text('Guía para el dictamen de coyuntura económica', style: context.textos.titleSmall),
        subtitle: Wrap(crossAxisAlignment: WrapCrossAlignment.center, spacing: 6, runSpacing: 2, children: [
          if (dictamen != null) Etiqueta(dictamen.exclusivo ? 'Exclusivo · revisado' : 'Revisado · exclusivo de la app'),
          Text(dictamen != null ? 'Guía completa, resumen de repaso, web y Word' : 'Esquema del dictamen económico (PDF)', style: context.textos.labelSmall),
          if (offline) Icon(Icons.offline_pin, size: 14, color: context.colores.textoClaro),
        ]),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => TemaPage(tema: Tema(codigo: codigoDictamen, titulo: 'Guía para el dictamen de coyuntura económica', disponible: true, temarioAnterior: false, url: anterior?.url)))),
      ),
    );
  }
}

String _normalizar(String s) => s.toLowerCase().replaceAll(RegExp('[áàä]'), 'a').replaceAll(RegExp('[éèë]'), 'e').replaceAll(RegExp('[íìï]'), 'i').replaceAll(RegExp('[óòö]'), 'o').replaceAll(RegExp('[úùü]'), 'u');
