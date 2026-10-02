import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';

/// Tarjeta con el estilo de las "cards" de la web (borde suave, esquinas 12).
class Tarjeta extends StatelessWidget {
  const Tarjeta({super.key, required this.child, this.onTap, this.padding = const EdgeInsets.all(16), this.color});
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      clipBehavior: Clip.antiAlias,
      child: InkWell(onTap: onTap, child: Padding(padding: padding, child: child)),
    );
  }
}

/// Título de sección en mayúsculas con espaciado, como ".section-title" de la web.
class TituloSeccion extends StatelessWidget {
  const TituloSeccion(this.texto, {super.key, this.accion});
  final String texto;
  final Widget? accion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 20, 4, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(texto.toUpperCase(),
                style: context.textos.labelMedium?.copyWith(
                    color: context.esquema.primary, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
          ),
          if (accion != null) accion!,
        ],
      ),
    );
  }
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

class Etiqueta extends StatelessWidget {
  const Etiqueta(this.texto, {super.key, this.color});
  final String texto;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final c = color ?? context.esquema.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: c.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
      child: Text(texto, style: context.textos.labelSmall?.copyWith(color: c, fontWeight: FontWeight.w700)),
    );
  }
}

/// Tarjeta de estadística ("stat-card" de la web).
class Estadistica extends StatelessWidget {
  const Estadistica({super.key, required this.valor, required this.etiqueta, this.icono, this.color});
  final String valor;
  final String etiqueta;
  final IconData? icono;
  final Color? color;
  @override
  Widget build(BuildContext context) => Tarjeta(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (icono != null) Icon(icono, size: 20, color: color ?? context.esquema.primary),
          const SizedBox(height: 6),
          Text(valor, style: context.textos.headlineSmall?.copyWith(color: color ?? context.esquema.primary)),
          Text(etiqueta, style: context.textos.labelMedium),
        ]),
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

/// Fila de navegación dentro de una tarjeta (icono, título, subtítulo y flecha).
class FilaEnlace extends StatelessWidget {
  const FilaEnlace({super.key, required this.icono, required this.titulo, this.subtitulo, required this.onTap, this.final_});
  final IconData icono;
  final String titulo;
  final String? subtitulo;
  final VoidCallback onTap;
  final Widget? final_;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Tarjeta(
          padding: EdgeInsets.zero,
          onTap: onTap,
          child: ListTile(
            leading: Icon(icono, color: context.esquema.primary),
            title: Text(titulo, style: context.textos.titleSmall),
            subtitle: subtitulo == null ? null : Text(subtitulo!, style: context.textos.labelSmall),
            trailing: final_ ?? const Icon(Icons.chevron_right),
          ),
        ),
      );
}
