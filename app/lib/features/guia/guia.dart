import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants.dart';
import '../../core/providers.dart';
import '../../data/models/preparador.dart';
import '../../theme/app_theme.dart';
import '../mas/ayuda_videos.dart';

/// Guía de la app: unos globos sobre las pestañas que dicen dónde está lo
/// esencial. Sale una vez por oposición y papel (quien es preparador en una
/// oposición y opositor en otra ve las dos), se puede saltar y se vuelve a
/// abrir desde Más → Guía de la app.

/// Un paso: la pestaña que se señala (0 Hoy … 4 Más), la subpestaña que se
/// abre y, si hay, los vídeos de ayuda de lo que explica.
class PasoGuia {
  const PasoGuia({required this.pestana, required this.titulo, required this.texto, this.estudiar, this.cantes, this.videos = const []});
  final int pestana;
  final String titulo;
  final String texto;
  /// Subpestaña de Estudiar (0 temas, 1 test) o de Cantes que se deja abierta.
  final int? estudiar;
  final int? cantes;
  /// Ids de [videosAyuda].
  final List<String> videos;
}

List<PasoGuia> pasosGuia(Papel papel) => papel == Papel.opositor
    ? const [
        PasoGuia(pestana: 0, titulo: 'Hoy', texto: 'Tu día de un vistazo: los días que quedan para el examen, el test diario, lo que te toca estudiar esta semana y tus próximos cantes. Arriba, «Para empezar» te propone los primeros pasos.'),
        PasoGuia(pestana: 1, estudiar: 0, titulo: 'Estudiar › Temas', texto: 'El temario completo con los apuntes de cada tema. En el móvil puedes descargarlos para leerlos sin conexión.'),
        PasoGuia(pestana: 1, estudiar: 1, titulo: 'Estudiar › Test', texto: 'El simulador con las preguntas de los exámenes oficiales: por temas o por exámenes, con tus estadísticas y repaso de los fallos.'),
        PasoGuia(pestana: 2, cantes: 0, titulo: 'Cantes', texto: 'Tu agenda de clases con el preparador (pide clase en sus huecos libres) y «Cantar», para cantar un tema con cronómetro y grabarte.', videos: ['reservar-clase', 'clase']),
        PasoGuia(pestana: 3, titulo: 'Organización', texto: 'Tu cronograma de estudio y el proceso selectivo: lo que publica el Ministerio, con avisos cuando sale algo nuevo. En «Más herramientas», probabilidades, horario y mapas del temario.', videos: ['cronograma']),
        PasoGuia(pestana: 4, titulo: 'Más', texto: 'Tu cuenta, buscar preparador o conectar con el tuyo con su código, los ajustes, los vídeos de ayuda y esta guía, por si quieres volver a verla.', videos: ['buscar-preparador', 'conectar-preparador']),
      ]
    : const [
        PasoGuia(pestana: 0, titulo: 'Hoy', texto: 'Tus clases de hoy y lo que espera respuesta: reservas de tus alumnos y clases sueltas. Arriba, «Para empezar» te propone los primeros pasos.'),
        PasoGuia(pestana: 2, cantes: 0, titulo: 'Cantes › Clases', texto: 'Programa las clases con tus alumnos. En la ficha de cada una: la reunión de Meet o Teams, los temas que le mandas, la pizarra y el cronómetro compartidos.', videos: ['programar-clase']),
        PasoGuia(pestana: 4, titulo: 'Más › Preparador', texto: 'Tu alta y verificación, el código para tus alumnos, los huecos semanales que pueden reservar y los materiales que compartes con ellos.', videos: ['empezar-preparador', 'huecos-reservas', 'materiales']),
        PasoGuia(pestana: 4, titulo: 'Tablón de clases sueltas', texto: 'En Más › Preparador: las clases que piden otros alumnos cuando su preparador no puede. Si te viene bien, la coges.', videos: ['coger-clase']),
        PasoGuia(pestana: 1, titulo: 'Estudiar', texto: 'El mismo temario y test que ven tus alumnos, para consultarlo cuando quieras.'),
        PasoGuia(pestana: 4, titulo: 'Más', texto: 'Tu cuenta, los ajustes, los vídeos de ayuda y esta guía, por si quieres volver a verla.'),
      ];

/// Clave de [Cajas.app] con la guía ya vista en una oposición y un papel.
String claveGuiaVista(String oposicion, Papel papel) => 'guia_vista_${oposicion}_${papel.name}';

class EstadoGuia {
  const EstadoGuia(this.pasos, this.indice);
  final List<PasoGuia> pasos;
  final int indice;
  PasoGuia get paso => pasos[indice];
  bool get ultimo => indice == pasos.length - 1;
}

class GuiaNotifier extends Notifier<EstadoGuia?> {
  Completer<void>? _fin;

  @override
  EstadoGuia? build() => null;

  /// Empieza la guía del papel actual; termina al acabarla o saltarla.
  Future<void> empezar() {
    _fin?.complete();
    _fin = Completer<void>();
    state = EstadoGuia(pasosGuia(ref.read(papelProvider)), 0);
    return _fin!.future;
  }

  void siguiente() {
    final e = state;
    if (e == null) return;
    e.ultimo ? terminar() : state = EstadoGuia(e.pasos, e.indice + 1);
  }

  void anterior() {
    final e = state;
    if (e != null && e.indice > 0) state = EstadoGuia(e.pasos, e.indice - 1);
  }

  /// Al acabarla o saltarla: queda vista en esta oposición y papel.
  void terminar() {
    if (Hive.isBoxOpen(Cajas.app)) Hive.box(Cajas.app).put(claveGuiaVista(ref.read(oposicionProvider).id, ref.read(papelProvider)), true);
    state = null;
    _fin?.complete();
    _fin = null;
  }
}

final guiaProvider = NotifierProvider<GuiaNotifier, EstadoGuia?>(GuiaNotifier.new);

/// La primera vez en esta oposición y papel, la guía. Devuelve cuando acaba.
Future<void> empezarGuiaSiToca(WidgetRef ref) async {
  if (!Hive.isBoxOpen(Cajas.app)) return;
  if (Hive.box(Cajas.app).get(claveGuiaVista(ref.read(oposicionProvider).id, ref.read(papelProvider))) == true) return;
  await ref.read(guiaProvider.notifier).empezar();
}

/// Las pestañas de la barra de abajo (o del menú lateral) se apuntan aquí
/// para que la guía sepa dónde están.
class AnclasGuia {
  AnclasGuia._();
  static final Map<int, BuildContext> pestanas = {};

  static Rect? rectDe(int pestana) {
    final c = pestanas[pestana];
    if (c == null || !c.mounted) return null;
    final caja = c.findRenderObject();
    if (caja is! RenderBox || !caja.hasSize || !caja.attached) return null;
    return caja.localToGlobal(Offset.zero) & caja.size;
  }
}

/// Envuelve el icono de una pestaña para que la guía la encuentre.
class AnclaGuia extends StatefulWidget {
  const AnclaGuia({super.key, required this.pestana, required this.child});
  final int pestana;
  final Widget child;

  @override
  State<AnclaGuia> createState() => _AnclaGuiaState();
}

class _AnclaGuiaState extends State<AnclaGuia> {
  @override
  Widget build(BuildContext context) {
    AnclasGuia.pestanas[widget.pestana] = context;
    return widget.child;
  }

  @override
  void dispose() {
    if (AnclasGuia.pestanas[widget.pestana] == context) AnclasGuia.pestanas.remove(widget.pestana);
    super.dispose();
  }
}

/// La capa de la guía: oscurece la pantalla salvo la pestaña del paso y
/// muestra el globo con la explicación.
class CapaGuia extends ConsumerStatefulWidget {
  const CapaGuia({super.key, required this.estado});
  final EstadoGuia estado;

  @override
  ConsumerState<CapaGuia> createState() => _CapaGuiaState();
}

class _CapaGuiaState extends ConsumerState<CapaGuia> {
  Rect? _destino;

  @override
  void initState() {
    super.initState();
    _medir();
  }

  @override
  void didUpdateWidget(CapaGuia antes) {
    super.didUpdateWidget(antes);
    _medir();
  }

  /// La pestaña se mide después de dibujarse (y otra vez si cambia de sitio).
  void _medir() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final r = AnclasGuia.rectDe(widget.estado.paso.pestana);
      final caja = context.findRenderObject();
      final local = r == null || caja is! RenderBox ? null : caja.globalToLocal(r.topLeft) & r.size;
      if (local != _destino) setState(() => _destino = local);
    });
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.estado;
    final notifier = ref.read(guiaProvider.notifier);
    return LayoutBuilder(builder: (context, limites) {
      final pantalla = Size(limites.maxWidth, limites.maxHeight);
      // Hueco alrededor del icono y la etiqueta de la pestaña.
      final d = _destino;
      final hueco = d == null ? null : Rect.fromCenter(center: d.center.translate(0, 9), width: d.width + 44, height: d.height + 40);
      final ancho = (pantalla.width - 32).clamp(0.0, 360.0);
      final lateral = hueco != null && hueco.center.dx < pantalla.width * 0.25 && hueco.center.dy < pantalla.height * 0.8;
      Widget globo = _Globo(estado: e, notifier: notifier, ancho: ancho);
      Widget colocado;
      if (hueco == null) {
        colocado = Center(child: globo);
      } else if (lateral) {
        // Menú lateral (pantalla ancha): el globo a la derecha de la pestaña.
        final arriba = (hueco.center.dy - 120).clamp(16.0, pantalla.height - 300);
        colocado = Positioned(left: hueco.right + 16, top: arriba, child: globo);
      } else if (hueco.center.dy > pantalla.height / 2) {
        final izquierda = (hueco.center.dx - ancho / 2).clamp(16.0, pantalla.width - ancho - 16);
        colocado = Positioned(left: izquierda, bottom: pantalla.height - hueco.top + 14, child: globo);
      } else {
        final izquierda = (hueco.center.dx - ancho / 2).clamp(16.0, pantalla.width - ancho - 16);
        colocado = Positioned(left: izquierda, top: hueco.bottom + 14, child: globo);
      }
      return Stack(children: [
        // Bloquea los toques: durante la guía no se navega por debajo.
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: CustomPaint(painter: _Sombra(hueco, Theme.of(context).colorScheme.primary)),
          ),
        ),
        colocado,
      ]);
    });
  }
}

class _Globo extends StatelessWidget {
  const _Globo({required this.estado, required this.notifier, required this.ancho});
  final EstadoGuia estado;
  final GuiaNotifier notifier;
  final double ancho;

  @override
  Widget build(BuildContext context) {
    final p = estado.paso;
    final videos = [for (final id in p.videos) ...videosAyuda.where((v) => v.id == id)];
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(14),
      color: context.esquema.surface,
      child: Container(
        width: ancho,
        padding: const EdgeInsets.fromLTRB(18, 14, 12, 8),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text(p.titulo, style: context.textos.titleMedium?.copyWith(color: context.esquema.primary, fontWeight: FontWeight.w700))),
            Text('${estado.indice + 1} de ${estado.pasos.length}', style: context.textos.labelSmall),
          ]),
          const SizedBox(height: 6),
          Text(p.texto, style: context.textos.bodyMedium?.copyWith(height: 1.4)),
          if (videos.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(spacing: 6, runSpacing: 4, children: [
              for (final v in videos)
                ActionChip(
                  avatar: const Icon(Icons.play_circle_outline, size: 18),
                  label: Text(v.titulo, style: context.textos.labelSmall),
                  visualDensity: VisualDensity.compact,
                  onPressed: () => verVideoAyuda(context, v.id),
                ),
            ]),
          ],
          const SizedBox(height: 4),
          // Si no caben en una línea (letra grande), los botones bajan a otra.
          SizedBox(
            width: double.infinity,
            child: Wrap(alignment: WrapAlignment.spaceBetween, crossAxisAlignment: WrapCrossAlignment.center, children: [
              TextButton(onPressed: notifier.terminar, child: Text(estado.ultimo ? 'Cerrar' : 'Saltar la guía')),
              Row(mainAxisSize: MainAxisSize.min, children: [
                if (estado.indice > 0) IconButton(tooltip: 'Anterior', onPressed: notifier.anterior, icon: const Icon(Icons.arrow_back)),
                FilledButton(onPressed: notifier.siguiente, child: Text(estado.ultimo ? 'Terminar' : 'Siguiente')),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}

/// Oscurece todo menos [hueco], con un filete del color de la oposición.
class _Sombra extends CustomPainter {
  _Sombra(this.hueco, this.color);
  final Rect? hueco;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final fondo = Path()..addRect(Offset.zero & size);
    final h = hueco;
    if (h == null) {
      canvas.drawPath(fondo, Paint()..color = Colors.black.withValues(alpha: 0.55));
      return;
    }
    final redondo = RRect.fromRectAndRadius(h, const Radius.circular(16));
    canvas.drawPath(Path.combine(PathOperation.difference, fondo, Path()..addRRect(redondo)), Paint()..color = Colors.black.withValues(alpha: 0.55));
    canvas.drawRRect(redondo, Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5);
  }

  @override
  bool shouldRepaint(_Sombra antes) => antes.hueco != hueco || antes.color != color;
}
