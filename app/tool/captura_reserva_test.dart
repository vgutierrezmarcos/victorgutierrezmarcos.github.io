// Captura de la agenda con una clase pedida al preparador (para la escena de
// la reserva del vídeo de EconomIA, scripts/video-claude):
//
//   flutter test tool/captura_reserva_test.dart --update-goldens --no-pub
//
// La app completa con los datos de demostración de demo_comun.dart y una
// reserva pendiente a Paula, como la que deja el conector de IA.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugDisableShadows;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/app.dart';
import 'package:tcee_app/core/red_providers.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/red.dart';

import 'demo_comun.dart';

void main() {
  setUpAll(prepararCapturas);

  testWidgets('agenda con una clase pedida', (tester) async {
    final demo = await Demo.crear();
    await demo.conDosPreparadores();
    final pedida = Reserva(id: 'ia1', preparador: 'paula', alumno: 'yo', alumnoNombre: 'Álex', fecha: demo.dia(3, 17, 0), modalidad: Modalidad.online, temas: const ['3.A.8', '3.A.9'], nota: 'Pedida desde EconomIA');
    Recorrido.vistaMovil(tester);
    await tester.pumpWidget(ProviderScope(overrides: [...demo.overrides, misReservasProvider.overrideWith((ref) async => [pedida])], child: const TceeApp()));
    await tester.pumpAndSettle();
    final r = Recorrido(tester);
    await r.subpestana('Agenda');
    if (find.byTooltip('Entendido').evaluate().isNotEmpty) await r.tocar(find.byTooltip('Entendido'));
    await tester.pumpAndSettle();
    // La tarjeta de la clase pedida, entera arriba de la pantalla.
    await tester.ensureVisible(find.textContaining('Clase pedida'));
    await tester.pump(const Duration(seconds: 1));
    await expectLater(find.byType(MaterialApp), matchesGoldenFile(rutaCaptura('agenda-reserva-pedida')));
    // Recorrido.vistaMovil activa las sombras: se deja como estaba.
    debugDisableShadows = true;
  });
}
