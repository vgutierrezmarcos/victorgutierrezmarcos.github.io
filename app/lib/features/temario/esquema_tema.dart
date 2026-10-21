import 'package:flutter/material.dart';

import '../../data/models/esquema.dart';
import '../../theme/app_theme.dart';

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
