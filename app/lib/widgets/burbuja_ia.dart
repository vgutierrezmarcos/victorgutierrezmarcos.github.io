import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/avisos_breves.dart';
import '../core/ia.dart';
import '../core/ia_mensajes.dart';
import '../core/providers.dart';
import '../theme/app_theme.dart';
import 'configurar_ia.dart';

/// La burbuja de EconomIA: pequeña, en una esquina de abajo, salvo que el
/// usuario la haya ocultado (activada por defecto; el interruptor está en
/// Más → EconomIA). Con EconomIA configurada (IA elegida y conectada), al
/// tocarla salen los accesos de esta pantalla ([acciones]) y cada uno abre la
/// IA con su mensaje ya escrito; sin configurar, abre la hoja para
/// configurarla y, al terminar, el menú.
///
/// Va en el `floatingActionButton` de las pantallas de estudio que la
/// declaran, con [ubicacionBurbujaIa] y [sinAnimacionBurbujaIa]; no en toda la
/// app: así no aparece en un test en curso, en la pizarra ni en un formulario,
/// y cada pantalla dice qué se le puede pedir a la IA desde ella. Se quita
/// sola con el teclado abierto.
class BurbujaIa extends ConsumerWidget {
  const BurbujaIa({super.key, required this.acciones});

  final List<AccionIa> Function(MensajesIa m) acciones;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(iaProvider.select((e) => e.burbuja))) return const SizedBox.shrink();
    final ia = ref.watch(iaConfiguradaProvider);
    final mensajes = MensajesIa(ref.watch(oposicionProvider));
    return _Burbuja(ia: ia, mensajes: mensajes, acciones: acciones(mensajes), derecha: ref.watch(iaProvider.select((e) => e.derecha)));
  }
}

/// Dónde va la burbuja: abajo a la izquierda (los botones flotantes de la app
/// van a la derecha) o, si el usuario la ha arrastrado, a la derecha. [subir]
/// la levanta sobre lo que la pantalla tenga abajo (la barra de páginas del
/// visor de un tema).
FloatingActionButtonLocation ubicacionBurbujaIa(WidgetRef ref, {double subir = 0}) {
  final derecha = ref.watch(iaProvider.select((e) => e.derecha));
  final base = derecha ? FloatingActionButtonLocation.endFloat : FloatingActionButtonLocation.startFloat;
  return subir == 0 ? base : _Subida(base, subir);
}

class _Subida extends FloatingActionButtonLocation {
  const _Subida(this.base, this.subir);

  final FloatingActionButtonLocation base;
  final double subir;

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry g) => base.getOffset(g).translate(0, -subir);

  @override
  bool operator ==(Object other) => other is _Subida && other.base == base && other.subir == subir;

  @override
  int get hashCode => Object.hash(base, subir);
}

/// Sin el salto de escala con el que entran los botones flotantes.
const sinAnimacionBurbujaIa = FloatingActionButtonAnimator.noAnimation;

class _Burbuja extends ConsumerStatefulWidget {
  const _Burbuja({required this.ia, required this.mensajes, required this.acciones, required this.derecha});

  /// La IA configurada (null: falta configurar EconomIA).
  final Ia? ia;
  final MensajesIa mensajes;
  final List<AccionIa> acciones;
  final bool derecha;

  @override
  ConsumerState<_Burbuja> createState() => _BurbujaState();
}

class _BurbujaState extends ConsumerState<_Burbuja> with WidgetsBindingObserver {
  static const double _lado = 44;
  final _menu = MenuController();
  double _arrastre = 0;
  bool _teclado = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _teclado = View.of(context).viewInsets.bottom > 0;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final teclado = View.of(context).viewInsets.bottom > 0;
    if (teclado != _teclado && mounted) setState(() => _teclado = teclado);
  }

  void _abrir(AccionIa a) => abrirIa(context, widget.ia!, a.mensaje, acceso: a.id);

  /// Sin configurar: la hoja; si queda configurada, el menú de esta pantalla.
  Future<void> _configurar() async {
    final ok = await mostrarHojaConfigurarIa(context);
    if (ok && mounted) WidgetsBinding.instance.addPostFrameCallback((_) => mounted && widget.ia != null ? _menu.open() : null);
  }

  void _ocultar() {
    final messenger = ScaffoldMessenger.of(context);
    ref.read(iaProvider.notifier).mostrarBurbuja(false);
    messenger.mostrar(SnackBar(
      content: const Text('Burbuja oculta. La recuperas en Más → EconomIA.'),
      action: SnackBarAction(label: 'Deshacer', onPressed: () => ref.read(iaProvider.notifier).mostrarBurbuja(true)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (_teclado) return const SizedBox.shrink();
    final ia = widget.ia;
    final colores = context.colores;
    final esquema = context.esquema;
    final item = context.textos.bodyMedium;
    return MenuAnchor(
      controller: _menu,
      alignmentOffset: const Offset(0, Espacio.e2),
      menuChildren: ia == null
          ? const []
          : [
        Padding(
          padding: const EdgeInsets.fromLTRB(Espacio.e4, Espacio.e2, Espacio.e4, Espacio.e1),
          child: Text('Con ${ia.nombre}', style: context.textos.labelSmall?.copyWith(color: colores.textoClaro)),
        ),
        for (final a in widget.acciones) MenuItemButton(leadingIcon: Icon(a.icono, size: 20, color: esquema.primary), onPressed: () => _abrir(a), child: Text(a.titulo, style: item)),
        MenuItemButton(
          leadingIcon: Icon(Icons.edit_outlined, size: 20, color: esquema.primary),
          onPressed: () => _abrir(AccionIa('libre', Icons.edit_outlined, '', widget.mensajes.libre)),
          child: Text('Escribir a ${ia.nombre}', style: item),
        ),
        const Divider(height: 1),
        MenuItemButton(
          leadingIcon: Icon(Icons.visibility_off_outlined, size: 20, color: colores.textoClaro),
          onPressed: _ocultar,
          child: Text('Ocultar la burbuja', style: item?.copyWith(color: colores.textoSuave)),
        ),
      ],
      builder: (context, menu, _) => Semantics(
        button: true,
        label: ia == null ? 'Configurar EconomIA' : 'Abrir ${ia.nombre} con EconomIA',
        child: Tooltip(
          message: ia == null ? 'Configura EconomIA' : 'Tu IA: ${ia.nombre}',
          child: GestureDetector(
            // Arrastrarla de lado la cambia de esquina (se recuerda en el dispositivo).
            onHorizontalDragUpdate: (d) => _arrastre += d.delta.dx,
            onHorizontalDragEnd: (_) {
              final aLaDerecha = Directionality.of(context) == TextDirection.ltr ? _arrastre > 0 : _arrastre < 0;
              if (_arrastre.abs() > 24 && aLaDerecha != widget.derecha) ref.read(iaProvider.notifier).lado(derecha: aLaDerecha);
              _arrastre = 0;
            },
            child: Opacity(
              opacity: menu.isOpen ? 1 : (ia == null ? 0.7 : 0.88),
              child: Material(
                color: esquema.surface,
                shape: CircleBorder(side: BorderSide(color: colores.dorado, width: 1.5)),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => ia == null ? _configurar() : (menu.isOpen ? menu.close() : menu.open()),
                  child: SizedBox(width: _lado, height: _lado, child: Icon(Icons.auto_awesome_outlined, size: 22, color: esquema.primary)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
