import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/models/oposicion.dart';
import '../core/providers.dart';
import '../theme/app_theme.dart';
import 'boton_oposicion.dart';

/// Pestañas internas de un bloque (Estudiar, Cantes): en blanco sobre la
/// cabecera morada, con el indicador dorado.
TabBar barraPestanas(BuildContext context, {required TabController controller, required List<String> textos, ValueChanged<int>? onTap}) => TabBar(
      controller: controller,
      onTap: onTap,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
      indicatorColor: context.colores.dorado,
      indicatorWeight: 3,
      dividerColor: Colors.transparent,
      labelStyle: TextStyle(fontFamily: Fuentes.sans, fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 0.8),
      unselectedLabelStyle: TextStyle(fontFamily: Fuentes.sans, fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.8),
      tabs: [for (final t in textos) Tab(text: t)],
    );

/// Cabecera de la web (.site-header): degradado morado, título centrado en
/// blanco y serif, y la línea dorada al pie. Sustituye a AppBar en toda la app.
class BarraWeb extends StatelessWidget implements PreferredSizeWidget {
  const BarraWeb({super.key, this.title, this.subtitulo, this.actions, this.leading, this.bottom, this.conTema = true, this.conOposicion = false});

  final Widget? title;
  /// Línea en cursiva bajo el título (.site-description).
  final String? subtitulo;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  /// Botón para cambiar entre modo claro y oscuro (en todas las pantallas salvo donde estorbe).
  final bool conTema;
  /// Botón para cambiar de oposición arriba a la izquierda (en las cinco
  /// pestañas; en las demás pantallas ahí va la flecha de volver).
  final bool conOposicion;

  static const _altoLinea = 4.0;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0) + _altoLinea);

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Theme(
      // Los botones de texto de la cabecera van en blanco sobre el morado.
      data: tema.copyWith(textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Colors.white, textStyle: tema.textTheme.labelLarge))),
      child: AppBar(
        leading: leading ?? (conOposicion ? const BotonOposicion() : null),
        actions: [...?actions, if (conTema) const BotonTema()],
        title: subtitulo == null
            ? title
            : Column(mainAxisSize: MainAxisSize.min, children: [
                if (title != null) title!,
                Text(subtitulo!, style: TextStyle(fontFamily: Fuentes.serif, fontStyle: FontStyle.italic, fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white.withValues(alpha: 0.9))),
              ]),
        flexibleSpace: DecoratedBox(decoration: BoxDecoration(gradient: context.degradadoPrimario)),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight((bottom?.preferredSize.height ?? 0) + _altoLinea),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            if (bottom != null) bottom!,
            Container(height: _altoLinea, decoration: BoxDecoration(gradient: context.degradadoDorado)),
          ]),
        ),
      ),
    );
  }
}

/// Tarjeta con el estilo de la web: degradado de blanco a crema, borde y
/// esquinas de 8 (.tema-card, .resource-item). Con [color] morado pálido se
/// pinta como la caja destacada de la web (.highlight-box), con su filete
/// morado a la izquierda.
class Tarjeta extends StatelessWidget {
  const Tarjeta({super.key, required this.child, this.onTap, this.padding = const EdgeInsets.all(16), this.color});
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = context.colores;
    final destacada = color != null && color == c.primarioPalido;
    final radio = destacada ? const BorderRadius.horizontal(right: Radius.circular(8)) : BorderRadius.circular(8);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color != null && !destacada ? Color.alphaBlend(color!, c.superficie) : null,
        gradient: color != null && !destacada
            ? null
            : LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: destacada ? [c.primarioPalido, c.crema] : [c.superficie, c.crema]),
        border: Border.all(color: c.borde),
        borderRadius: radio,
        boxShadow: context.sombraSuave,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: destacada ? BoxDecoration(border: Border(left: BorderSide(color: context.esquema.primary, width: 4))) : null,
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Título de sección como ".section-title" de la web: serif morado, subrayado
/// morado del ancho del texto y un rombo en el centro del subrayado.
class TituloSeccion extends StatelessWidget {
  const TituloSeccion(this.texto, {super.key, this.accion});
  final String texto;
  final Widget? accion;

  @override
  Widget build(BuildContext context) {
    final morado = context.esquema.primary;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 22, 4, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: IntrinsicWidth(
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
                  Text(texto.toUpperCase(), style: TextStyle(fontFamily: Fuentes.serif, fontSize: 16.5, fontWeight: FontWeight.w700, color: morado, letterSpacing: 0.4, height: 1.25)),
                  const SizedBox(height: 3),
                  SizedBox(
                    height: 12,
                    child: Stack(alignment: Alignment.center, children: [
                      Container(height: 2, color: morado),
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        // El rombo no existe en la serif: se toma de la sans.
                        child: Text('◆', style: TextStyle(fontFamily: Fuentes.sans, fontSize: 9, height: 1, color: morado)),
                      ),
                    ]),
                  ),
                ]),
              ),
            ),
          ),
          if (accion != null) Padding(padding: const EdgeInsets.only(left: 8), child: accion!),
        ],
      ),
    );
  }
}

/// Subtítulo dentro de una caja, como los h3 del simulador de la web: serif
/// con un subrayado dorado a todo el ancho.
class Subtitulo extends StatelessWidget {
  const Subtitulo(this.texto, {super.key, this.accion});
  final String texto;
  final Widget? accion;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: context.colores.dorado, width: 2))),
        child: Row(children: [
          Expanded(child: Text(texto, style: context.textos.titleMedium)),
          if (accion != null) accion!,
        ]),
      );
}

/// Grupo desplegable de la web (.tema-group-header): barra con degradado
/// morado, signo § y texto blanco; debajo, el contenido sobre blanco.
class GrupoDesplegable extends StatefulWidget {
  const GrupoDesplegable({super.key, required this.titulo, this.subtitulo, required this.children, this.abierto = false, this.accion});
  final String titulo;
  final String? subtitulo;
  final List<Widget> children;
  final bool abierto;
  /// Control a la derecha de la barra (p. ej. «Todos»).
  final Widget? accion;

  @override
  State<GrupoDesplegable> createState() => _GrupoDesplegableState();
}

class _GrupoDesplegableState extends State<GrupoDesplegable> with AutomaticKeepAliveClientMixin {
  late bool _abierto = widget.abierto;

  // Un grupo abierto no se cierra solo al salir de la pantalla por el desplazamiento.
  @override
  bool get wantKeepAlive => _abierto;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final tema = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(gradient: context.degradadoPrimario, borderRadius: BorderRadius.circular(6), boxShadow: context.sombraSuave),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () => setState(() {
                _abierto = !_abierto;
                updateKeepAlive();
              }),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
                child: Row(children: [
                  Text('§', style: TextStyle(fontFamily: Fuentes.serif, fontSize: 21, height: 1, color: Colors.white.withValues(alpha: 0.7))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(widget.titulo, style: TextStyle(fontFamily: Fuentes.serif, fontSize: 16.5, fontWeight: FontWeight.w700, color: Colors.white, height: 1.25)),
                      if (widget.subtitulo != null) Text(widget.subtitulo!, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 12, color: Colors.white.withValues(alpha: 0.85))),
                    ]),
                  ),
                  if (widget.accion != null)
                    Theme(
                      data: tema.copyWith(textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Colors.white, textStyle: tema.textTheme.labelLarge))),
                      child: widget.accion!,
                    ),
                  AnimatedRotation(turns: _abierto ? 0.5 : 0, duration: const Duration(milliseconds: 200), child: Icon(Icons.expand_more, color: Colors.white.withValues(alpha: 0.85))),
                ]),
              ),
            ),
          ),
        ),
        if (_abierto)
          // Material (y no una caja de color) para que se vean las pulsaciones de las filas.
          Material(
            color: context.colores.superficie,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(6)),
            clipBehavior: Clip.antiAlias,
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              for (var i = 0; i < widget.children.length; i++)
                // Cada fila con su línea inferior, como .tema-item.
                DecoratedBox(
                  decoration: BoxDecoration(border: i == widget.children.length - 1 ? null : Border(bottom: BorderSide(color: context.colores.bordeClaro))),
                  child: widget.children[i],
                ),
            ]),
          ),
      ]),
    );
  }
}

/// Código y título de un tema como en las listas de la web (.tema-item):
/// "Tema 3.A.1" en morado y sans seminegrita, y el título en texto normal.
class TextoTema extends StatelessWidget {
  const TextoTema(this.codigo, this.titulo, {super.key, this.maxLines = 2, this.atenuado = false, this.color});
  final String codigo;
  final String titulo;
  final int maxLines;
  /// Tema sin PDF: en gris, como .tema-item-unavailable.
  final bool atenuado;
  /// Color del bloque del tema en la organización del temario: el código se
  /// pinta en una casilla de ese color, como en el PowerPoint.
  final Color? color;

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(children: [
          if (color != null)
            WidgetSpan(alignment: PlaceholderAlignment.middle, child: Padding(padding: const EdgeInsets.only(right: 6), child: CasillaTema(codigo, color: color!)))
          else
            TextSpan(text: codigo, style: TextStyle(fontWeight: FontWeight.w600, color: atenuado ? context.colores.textoClaro : context.esquema.primary)),
          TextSpan(text: titulo.isEmpty ? '' : (color != null ? titulo : ' · $titulo')),
        ]),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontFamily: Fuentes.sans, fontSize: 14, height: 1.35, color: atenuado ? context.colores.textoClaro : context.esquema.onSurface),
      );
}

/// Casilla con el código de un tema sobre el color de su bloque, como las del
/// PowerPoint de organización del temario. [apagada] la deja en contorno
/// (tema aún no estudiado en las vistas de progreso).
class CasillaTema extends StatelessWidget {
  const CasillaTema(this.codigo, {super.key, required this.color, this.apagada = false, this.grande = false, this.onTap});
  final String codigo;
  final Color color;
  final bool apagada;
  final bool grande;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final texto = apagada ? context.esquema.onSurface : (color.computeLuminance() > 0.42 ? const Color(0xFF1F1F1F) : Colors.white);
    final caja = Container(
      padding: EdgeInsets.symmetric(horizontal: grande ? 10 : 6, vertical: grande ? 5 : 2),
      decoration: BoxDecoration(
        color: apagada ? color.withValues(alpha: 0.12) : color,
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(codigo, style: TextStyle(fontFamily: Fuentes.sans, fontSize: grande ? 14 : 12, fontWeight: FontWeight.w600, height: 1.2, color: texto)),
    );
    return onTap == null ? caja : GestureDetector(onTap: onTap, child: caja);
  }
}

/// Banda morada con cifras en blanco (.contador-seleccion del simulador).
class Contador extends StatelessWidget {
  const Contador({super.key, required this.cifras});
  final List<({String valor, String etiqueta})> cifras;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(gradient: context.degradadoPrimario, borderRadius: BorderRadius.circular(8), boxShadow: context.sombraSuave),
        child: Row(children: [
          for (final c in cifras)
            Expanded(
              child: Column(children: [
                FittedBox(child: Text(c.valor, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white, height: 1.1))),
                Text(c.etiqueta.toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 11, letterSpacing: 0.6, color: Colors.white.withValues(alpha: 0.9))),
              ]),
            ),
        ]),
      );
}

class Cargando extends StatelessWidget {
  const Cargando({super.key, this.texto});
  final String? texto;
  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const CircularProgressIndicator(),
          if (texto != null) ...[const SizedBox(height: 12), Text(texto!, style: context.textos.bodySmall)],
        ]),
      );
}

class ErrorVista extends StatelessWidget {
  const ErrorVista({super.key, required this.error, this.reintentar});
  final Object error;
  final VoidCallback? reintentar;
  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.cloud_off, size: 40, color: context.colores.textoClaro),
            const SizedBox(height: 12),
            Text('No se pudo cargar el contenido', style: context.textos.titleMedium),
            const SizedBox(height: 6),
            Text('Comprueba la conexión. Lo ya descargado sigue disponible sin red.',
                textAlign: TextAlign.center, style: context.textos.bodySmall),
            if (reintentar != null) ...[
              const SizedBox(height: 16),
              OutlinedButton(onPressed: reintentar, child: const Text('Reintentar')),
            ],
          ]),
        ),
      );
}

/// Etiqueta pequeña (.tema-card-badge, .pregunta-tipo).
class Etiqueta extends StatelessWidget {
  const Etiqueta(this.texto, {super.key, this.color});
  final String texto;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final c = color ?? context.esquema.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(color: c.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(4)),
      child: Text(texto, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 11.5, color: c, fontWeight: FontWeight.w600, letterSpacing: 0.3)),
    );
  }
}

/// Cifra destacada (".estadistica-item" del simulador de la web): número en
/// sans y etiqueta en mayúsculas, centrados sobre blanco.
class Estadistica extends StatelessWidget {
  const Estadistica({super.key, required this.valor, required this.etiqueta, this.icono, this.color, this.detalle, this.onTap});
  final String valor;
  final String etiqueta;
  /// Se conserva por compatibilidad; la web no usa iconos en estas cajas.
  final IconData? icono;
  final Color? color;
  /// Línea pequeña bajo la etiqueta (p. ej. una fecha).
  final String? detalle;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Material(
        color: context.colores.superficie,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: context.colores.borde)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              FittedBox(child: Text(valor, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 28, fontWeight: FontWeight.w600, height: 1.1, color: color ?? context.esquema.primary))),
              const SizedBox(height: 4),
              Text(etiqueta.toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 11, letterSpacing: 0.6, height: 1.2, color: context.colores.textoSuave)),
              if (detalle != null) Padding(padding: const EdgeInsets.only(top: 2), child: Text(detalle!, textAlign: TextAlign.center, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 12, color: context.colores.textoClaro))),
            ]),
          ),
        ),
      );
}

Future<void> abrirUrl(BuildContext context, String? url, {bool enApp = false}) async {
  if (url == null || url.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enlace no disponible todavía')));
    return;
  }
  final uri = Uri.parse(url);
  final ok = await launchUrl(uri, mode: enApp ? LaunchMode.inAppBrowserView : LaunchMode.externalApplication);
  if (!ok && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No se pudo abrir el enlace')));
  }
}

String formatoTiempo(int segundos) {
  final h = segundos ~/ 3600, m = (segundos % 3600) ~/ 60, s = segundos % 60;
  if (h > 0) return '${h}h ${m}min';
  if (m > 0) return '${m}min ${s}s';
  return '${s}s';
}

String formatoNota(double n) => n.toStringAsFixed(2).replaceAll('.', ',');

/// Cuenta atrás legible: "en 3 días", "en 5 h 20 min", "en 12 min", "ahora".
String cuentaAtras(DateTime fecha, [DateTime? ahora]) {
  final d = fecha.difference(ahora ?? DateTime.now());
  if (d.isNegative) return d.inMinutes > -120 ? 'ahora' : 'pasado';
  if (d.inDays >= 2) return 'en ${d.inDays} días';
  if (d.inHours >= 1) return 'en ${d.inHours} h ${d.inMinutes % 60} min';
  if (d.inMinutes >= 1) return 'en ${d.inMinutes} min';
  return 'ahora';
}

/// Días naturales que faltan hasta [fecha] (0 = hoy; negativo = ya pasó).
int diasHasta(DateTime fecha, [DateTime? ahora]) {
  final h = ahora ?? DateTime.now();
  return (DateTime(fecha.year, fecha.month, fecha.day).difference(DateTime(h.year, h.month, h.day)).inHours / 24).round();
}

/// Valoración de 1 a 5 estrellas (0 = sin valorar). Sin [onChanged] es de solo lectura.
class Estrellas extends StatelessWidget {
  const Estrellas({super.key, required this.valor, this.onChanged, this.tamano = 28});
  final int valor;
  final ValueChanged<int>? onChanged;
  final double tamano;

  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
        for (var i = 1; i <= 5; i++)
          GestureDetector(
            onTap: onChanged == null ? null : () => onChanged!(i == valor ? 0 : i),
            child: Padding(
              padding: EdgeInsets.all(onChanged == null ? 0 : 4),
              child: Icon(i <= valor ? Icons.star : Icons.star_border, size: tamano, color: i <= valor ? context.colores.dorado : context.colores.textoClaro),
            ),
          ),
      ]);
}

/// Fila de navegación (.tema-card de la web): título serif y descripción en
/// cursiva, con la flecha a la derecha.
class FilaEnlace extends StatelessWidget {
  const FilaEnlace({super.key, required this.icono, required this.titulo, this.subtitulo, required this.onTap, this.final_});
  final IconData icono;
  final String titulo;
  final String? subtitulo;
  final VoidCallback onTap;
  final Widget? final_;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Tarjeta(
          padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
          onTap: onTap,
          child: Row(children: [
            Icon(icono, color: context.esquema.primary, size: 26),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(titulo, style: context.textos.titleMedium),
                if (subtitulo != null) Text(subtitulo!, style: TextStyle(fontFamily: Fuentes.serif, fontStyle: FontStyle.italic, fontSize: 14, height: 1.3, color: context.colores.textoSuave)),
              ]),
            ),
            final_ ?? Icon(Icons.chevron_right, color: context.colores.textoClaro),
          ]),
        ),
      );
}

/// Lista de una página. En el móvil es una lista normal. En pantallas anchas
/// (ordenador, tableta en horizontal) ocupa todo el ancho: las secciones (cada
/// [TituloSeccion] empieza una; lo anterior al primero es otra) se reparten en
/// dos columnas manteniendo el orden, y si la página tiene una sola sección se
/// centra con un ancho cómodo de lectura.
class ListaAdaptable extends StatelessWidget {
  const ListaAdaptable({super.key, required this.children, this.padding = const EdgeInsets.fromLTRB(16, 14, 16, 32)});
  final List<Widget> children;
  final EdgeInsets padding;

  static const anchoDosColumnas = 900.0;
  static const anchoLectura = 960.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final ancho = c.maxWidth;
      if (ancho < anchoDosColumnas) return ListView(padding: padding, children: children);
      final grupos = <List<Widget>>[];
      for (final w in children) {
        if (w is TituloSeccion || grupos.isEmpty) {
          grupos.add([w]);
        } else {
          grupos.last.add(w);
        }
      }
      if (grupos.length < 2) {
        final lado = ((ancho - anchoLectura) / 2).clamp(padding.left, double.infinity);
        return ListView(padding: padding.copyWith(left: lado, right: lado), children: children);
      }
      // Corte que deja las dos columnas lo más parejas posible (por número de piezas).
      final pesos = [for (final g in grupos) g.length + 1];
      final total = pesos.fold<int>(0, (a, b) => a + b);
      var mejor = 1, diferencia = total, acumulado = 0;
      for (var i = 1; i < grupos.length; i++) {
        acumulado += pesos[i - 1];
        final d = (total - 2 * acumulado).abs();
        if (d < diferencia) {
          diferencia = d;
          mejor = i;
        }
      }
      Widget columna(Iterable<List<Widget>> gs) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [for (final g in gs) ...g]);
      final lado = ((ancho - 2000) / 2).clamp(padding.left + 8, double.infinity);
      return ListView(
        padding: padding.copyWith(left: lado, right: lado),
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: columna(grupos.take(mejor))),
            const SizedBox(width: 28),
            Expanded(child: columna(grupos.skip(mejor))),
          ]),
        ],
      );
    });
  }
}

/// Cambia entre modo claro y oscuro. Va en la cabecera de todas las pantallas.
class BotonTema extends ConsumerWidget {
  const BotonTema({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oscuro = context.temaOscuro;
    return IconButton(
      tooltip: oscuro ? 'Modo claro' : 'Modo oscuro',
      icon: Icon(oscuro ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
      onPressed: () => ref.read(ajustesProvider.notifier).actualizar((a) => a.copyWith(temaOscuro: !oscuro)),
    );
  }
}

/// Foto de la cuenta de Google del usuario; si no tiene, su inicial (como hace
/// Google), y sin sesión, un icono. En el navegador, si alguna vez no se pudiera
/// leer la imagen desde el lienzo de Flutter, se pinta como <img>.
class AvatarUsuario extends ConsumerWidget {
  const AvatarUsuario({super.key, this.radio = 20});
  final double radio;

  /// Foto del usuario: la de la cuenta o, si falta, la de su proveedor (Google),
  /// pedida con el tamaño justo para que se vea nítida.
  static String? fotoDe(User? u) {
    if (u == null) return null;
    final url = u.photoURL ?? u.providerData.map((p) => p.photoURL).whereType<String>().firstOrNull;
    if (url == null || url.isEmpty) return null;
    return url.replaceAll(RegExp(r'=s\d+-c$'), '=s256-c');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(usuarioActualProvider);
    final url = fotoDe(usuario);
    final nombre = (usuario?.displayName ?? '').trim().isNotEmpty ? usuario!.displayName!.trim() : (usuario?.email ?? '');
    final icono = CircleAvatar(
      radius: radio,
      // Lila claro con la letra morada: se ve igual sobre la cabecera morada que sobre las tarjetas.
      backgroundColor: const Color(0xFFE9DDF3),
      foregroundColor: Paleta.primario,
      child: usuario == null || nombre.isEmpty
          ? Icon(Icons.person_outline, size: radio * 1.2)
          : Text(nombre.characters.first.toUpperCase(), style: TextStyle(fontFamily: Fuentes.sans, fontWeight: FontWeight.w700, fontSize: radio * 1.05, color: Paleta.primario)),
    );
    if (url == null) return icono;
    return ClipOval(
      child: Image.network(
        url,
        width: radio * 2,
        height: radio * 2,
        fit: BoxFit.cover,
        webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
        errorBuilder: (context, error, pila) => icono,
      ),
    );
  }
}

/// Segmentos para elegir el ejercicio de un cante: los que se cantan en la
/// oposición (1.º, 3.º y 4.º en TCEE) y, con [ambos], «3.º y 4.º» (valor 0).
List<ButtonSegment<int>> segmentosEjercicio({bool ambos = false}) {
  final o = Oposiciones.actual;
  return [
    for (final e in o.conCante) ButtonSegment(value: e.numero, label: Text(e.corto), tooltip: e.queSeCanta == null ? null : '${e.queSeCanta![0].toUpperCase()}${e.queSeCanta!.substring(1)}'),
    if (ambos && o.conTemasCantados.length > 1) ButtonSegment(value: 0, label: Text(o.cortoEjercicio(0))),
  ];
}
