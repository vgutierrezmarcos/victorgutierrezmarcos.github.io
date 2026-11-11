import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/esquema.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';

/// Los apartados del tema [tema] (los marcadores de su PDF: los del manifiesto
/// si está revisado, si no los de esquemas.json), o null si no hay.
List<EntradaEsquema>? esquemaDelTema(WidgetRef ref, Tema tema) {
  final rv = ref.watch(revisadosProvider).valueOrNull?.de(tema.codigo);
  if (rv != null && rv.esquema.isNotEmpty) return rv.esquema;
  return ref.watch(esquemasProvider).valueOrNull?.de(tema.url);
}

/// Los esquemas de varios temas (por código), solo los que tienen bastantes
/// apartados para una lista de control.
Map<String, List<EntradaEsquema>> esquemasDe(WidgetRef ref, Iterable<Tema?> temas) {
  final out = <String, List<EntradaEsquema>>{};
  for (final t in temas) {
    if (t == null) continue;
    final e = esquemaDelTema(ref, t);
    if (listaControlDisponible(e)) out[t.codigo] = e!;
  }
  return out;
}

/// Con menos de cuatro apartados la lista de control no aporta nada.
bool listaControlDisponible(List<EntradaEsquema>? esquema) => esquema != null && esquema.length >= 4;

/// El esquema del tema (los marcadores de su PDF) para leerlo al lado y
/// saltar de bloque: en el ordenador, un panel a la izquierda del PDF; en el
/// móvil, una hoja que se abre desde la barra de páginas.
class PanelEsquema extends StatefulWidget {
  const PanelEsquema({super.key, required this.esquema, required this.pagina, required this.alIr, this.titulo = 'Esquema'});

  final List<EntradaEsquema> esquema;

  /// Página que se está leyendo (para marcar dónde se va).
  final int pagina;
  final ValueChanged<int> alIr;
  final String titulo;

  @override
  State<PanelEsquema> createState() => _PanelEsquemaState();
}

class _PanelEsquemaState extends State<PanelEsquema> {
  final _control = ScrollController();
  final Map<int, GlobalKey> _claves = {};
  int _actual = -1;

  @override
  void initState() {
    super.initState();
    _actual = entradaEnPagina(widget.esquema, widget.pagina);
    WidgetsBinding.instance.addPostFrameCallback((_) => _ensenar(saltar: true));
  }

  @override
  void didUpdateWidget(PanelEsquema old) {
    super.didUpdateWidget(old);
    final n = entradaEnPagina(widget.esquema, widget.pagina);
    if (n != _actual) {
      _actual = n;
      WidgetsBinding.instance.addPostFrameCallback((_) => _ensenar());
    }
  }

  @override
  void dispose() {
    _control.dispose();
    super.dispose();
  }

  /// Que la entrada actual quede a la vista (sin molestar: solo si se sale).
  void _ensenar({bool saltar = false}) {
    final ctx = _claves[_actual]?.currentContext;
    if (ctx == null || !mounted) return;
    Scrollable.ensureVisible(ctx, alignment: 0.3, duration: saltar ? Duration.zero : const Duration(milliseconds: 250));
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
        child: Text(widget.titulo, style: TextStyle(fontFamily: Fuentes.serif, fontSize: 15, fontFeatures: versalitas, letterSpacing: 0.6, color: colores.textoSuave)),
      ),
      Expanded(
        child: ListView.builder(
          controller: _control,
          padding: const EdgeInsets.only(bottom: 16),
          itemCount: widget.esquema.length,
          itemBuilder: (context, i) {
            final e = widget.esquema[i];
            final actual = i == _actual;
            final clave = _claves[i] ??= GlobalKey();
            return InkWell(
              key: clave,
              onTap: () => widget.alIr(e.pagina),
              child: Container(
                color: actual ? colores.primarioPalido : null,
                padding: EdgeInsets.fromLTRB(16.0 + 12.0 * e.nivel.clamp(0, 4), e.nivel == 0 ? 7 : 4, 10, e.nivel == 0 ? 7 : 4),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                    child: Text(
                      e.titulo,
                      style: TextStyle(
                        fontFamily: Fuentes.sans,
                        fontSize: e.nivel == 0 ? 13.5 : 12.5,
                        height: 1.3,
                        fontWeight: e.nivel == 0 || actual ? FontWeight.w600 : FontWeight.w400,
                        color: actual ? context.esquema.primary : (e.nivel == 0 ? context.esquema.onSurface : colores.textoSuave),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('${e.pagina}', style: TextStyle(fontFamily: Fuentes.sans, fontSize: 11.5, color: colores.textoClaro)),
                ]),
              ),
            );
          },
        ),
      ),
    ]);
  }
}

/// El esquema en una hoja (móvil): tocar una entrada salta a su página.
Future<void> abrirEsquema(BuildContext context, {required List<EntradaEsquema> esquema, required int pagina, required ValueChanged<int> alIr}) => showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (d) => FractionallySizedBox(
        heightFactor: 0.85,
        child: PanelEsquema(
          esquema: esquema,
          pagina: pagina,
          titulo: 'Esquema del tema',
          alIr: (p) {
            Navigator.pop(d);
            alIr(p);
          },
        ),
      ),
    );

/// Un epígrafe encontrado por el buscador del temario.
typedef EpigrafeEncontrado = ({Tema tema, EntradaEsquema entrada});

/// Busca [consulta] en los epígrafes de los temas ([esquemas], por tema), sin
/// tildes ni mayúsculas y con todas las palabras (en cualquier orden): «¿en
/// qué tema está Feldstein-Horioka?». Como mucho [maximo] resultados, los
/// apartados más generales primero dentro de cada tema.
List<EpigrafeEncontrado> buscarEpigrafes(Map<Tema, List<EntradaEsquema>> esquemas, String consulta, {int maximo = 40}) {
  final palabras = normalizarBusqueda(consulta).split(RegExp(r'\s+')).where((p) => p.length >= 2).toList();
  if (palabras.isEmpty || palabras.join().length < 3) return const [];
  final out = <EpigrafeEncontrado>[];
  for (final e in esquemas.entries) {
    for (final entrada in e.value) {
      final t = normalizarBusqueda(entrada.titulo);
      if (palabras.every(t.contains)) out.add((tema: e.key, entrada: entrada));
      if (out.length >= maximo) return out;
    }
  }
  return out;
}

/// Sin tildes, en minúsculas y con guiones como espacios (para buscar).
String normalizarBusqueda(String s) => s
    .toLowerCase()
    .replaceAll(RegExp('[áàäâ]'), 'a')
    .replaceAll(RegExp('[éèëê]'), 'e')
    .replaceAll(RegExp('[íìïî]'), 'i')
    .replaceAll(RegExp('[óòöô]'), 'o')
    .replaceAll(RegExp('[úùüû]'), 'u')
    .replaceAll(RegExp(r'[-–—/]'), ' ');
