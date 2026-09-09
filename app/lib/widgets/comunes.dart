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
