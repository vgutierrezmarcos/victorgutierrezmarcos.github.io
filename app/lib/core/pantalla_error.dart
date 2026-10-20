import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Lo que se ve cuando una pantalla falla al construirse. Sin esto, Flutter
/// pinta un rectángulo gris (en la versión publicada) y no hay manera de
/// salir ni de saber qué ha pasado: aquí se explica, se enseña el error tal
/// cual (para poder contarlo) y se puede volver atrás o al inicio.
class PantallaError extends StatelessWidget {
  const PantallaError(this.detalles, {super.key});
  final FlutterErrorDetails detalles;

  /// Lleva al inicio de la app (lo pone TceeApp, que tiene el router).
  static void Function()? alInicio;

  /// Sustituye el rectángulo gris de Flutter por esta pantalla, en toda la app.
  static void instalar() {
    ErrorWidget.builder = (d) => PantallaError(d);
  }

  @override
  Widget build(BuildContext context) {
    final error = detalles.exceptionAsString();
    final nav = Navigator.maybeOf(context);
    // Puede no haber tema ni dirección del texto (si falla la raíz de la app).
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        color: const Color(0xFFF4F1F7),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.build_circle_outlined, size: 44, color: Color(0xFF5F2987)),
                  const SizedBox(height: 12),
                  const Text('Esta pantalla ha fallado', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF2B1A3A))),
                  const SizedBox(height: 8),
                  const Text(
                    'Es un error de la app, no tuyo: tus datos están a salvo. Vuelve atrás y prueba otra vez; si se repite, cuéntanoslo copiando el texto de abajo.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Color(0xFF4A3B58), height: 1.4),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFD9D0E3))),
                    child: SelectableText(error, style: const TextStyle(fontSize: 11.5, color: Color(0xFF6B5C7A), fontFamily: 'monospace')),
                  ),
                  const SizedBox(height: 16),
                  Wrap(spacing: 10, runSpacing: 10, alignment: WrapAlignment.center, children: [
                    if (nav != null && nav.canPop()) FilledButton.icon(onPressed: () => nav.pop(), icon: const Icon(Icons.arrow_back, size: 18), label: const Text('Volver')),
                    if (alInicio != null) OutlinedButton.icon(onPressed: alInicio, icon: const Icon(Icons.home_outlined, size: 18), label: const Text('Ir al inicio')),
                  ]),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
