// Capturas de las subpestañas como botones (1.19.1), para que Víctor las
// apruebe antes de compilar. No tocan promo/: van a la carpeta de
// $CAPTURAS_DESTINO (ruta absoluta); sin esa variable no hacen nada.
//
//   CAPTURAS_DESTINO=/ruta flutter test tool/capturas_pestanas_test.dart --update-goldens --no-pub

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/app.dart';
import 'package:tcee_app/widgets/comunes.dart';

import 'demo_comun.dart';

void main() {
  final destino = Platform.environment['CAPTURAS_DESTINO'];
  setUpAll(prepararCapturas);

  testWidgets('capturas de las pestañas', (tester) async {
    if (destino == null || destino.isEmpty) return;
    final demo = await Demo.crear();
    Recorrido.vistaMovil(tester);
    await tester.pumpWidget(ProviderScope(overrides: demo.overrides, child: const TceeApp()));
    await tester.pumpAndSettle();
    final r = Recorrido(tester);

    // La pregunta de Google Calendar (1.19.0) sale en el primer arranque de la
    // demo, un momento después de abrir: se cierra antes de cada paso.
    Future<void> sinPreguntas() async {
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      if (find.text('Ahora no').evaluate().isNotEmpty) {
        await tester.tap(find.text('Ahora no'));
        await tester.pumpAndSettle();
      }
    }

    Future<void> captura(String nombre) async {
      await sinPreguntas();
      await expectLater(find.byType(MaterialApp), matchesGoldenFile(Uri.file('$destino/$nombre.png')));
      final e = tester.takeException();
      if (e != null) debugPrint('Excepción en «$nombre»: $e');
    }

    Future<void> estudiar(String nombre) async {
      await sinPreguntas();
      await r.pestana('Estudiar');
      await r.tocar(find.descendant(of: find.byType(BotonesPestanas), matching: find.textContaining(nombre, findRichText: true)));
    }

    await estudiar('Temas');
    await captura('estudiar-temas');
    await estudiar('Test');
    await captura('estudiar-test');
    // La demo es un preparador: en Cantes, «Clases · Cantar».
    await r.pestana('Cantes');
    await captura('cantes');
    // Modo oscuro desde la cabecera.
    await estudiar('Temas');
    await r.tocar(find.byTooltip('Modo oscuro').first);
    await captura('estudiar-temas-oscuro');
    // Las sombras se encienden para las capturas; el test debe dejarlas como estaban.
    debugDisableShadows = true;
  });
}
