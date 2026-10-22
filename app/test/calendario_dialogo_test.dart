// La pregunta de Google Calendar al abrir: una vez por dispositivo, optativa,
// y nunca en el mismo arranque que la de estadísticas.
import 'dart:typed_data';

import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tcee_app/core/constants.dart';
import 'package:tcee_app/core/providers.dart';
import 'package:tcee_app/data/models/preparador.dart';
import 'package:tcee_app/data/repos/preparador_repo.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';
import 'package:tcee_app/features/inicio/calendario_dialogo.dart';
import 'package:tcee_app/features/preparador/calendario_google_tarjeta.dart';

const titulo = '¿Llevamos tus clases a Google Calendar?';

void main() {
  var n = 0;
  Future<Box> caja() => Hive.openBox('dial${n++}', bytes: Uint8List(0));
  late UsuarioRepo usuario;
  late PreparadorRepo preparador;
  late Box app;

  setUp(() async {
    usuario = UsuarioRepo(resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja());
    preparador = PreparadorRepo(alumnos: await caja(), sesiones: await caja(), perfil: await caja());
    app = Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app) : await Hive.openBox(Cajas.app, bytes: Uint8List(0));
    await app.clear();
  });

  Future<void> arrancar(WidgetTester tester, {PermisoCalendario permiso = PermisoCalendario.permitido, Papel papel = Papel.opositor, bool trasOtraPregunta = false, bool conSesion = true}) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        usuarioRepoProvider.overrideWithValue(usuario),
        usuarioActualProvider.overrideWithValue(conSesion ? MockUser(uid: 'yo', email: 'yo@gmail.com') : null),
        papelProvider.overrideWithValue(papel),
        preparadorRepoProvider.overrideWithValue(preparador),
        calendarioPermitidoProvider.overrideWith((ref) async => permiso),
      ],
      child: MaterialApp(
        home: Consumer(builder: (context, ref, _) {
          return Scaffold(body: TextButton(onPressed: () => preguntarCalendarioSiToca(context, ref, trasOtraPregunta: trasOtraPregunta), child: const Text('Arrancar')));
        }),
      ),
    ));
    await tester.tap(find.text('Arrancar'));
    await tester.pumpAndSettle();
  }

  testWidgets('sale una vez; «Ahora no» deja el dispositivo como preguntado y no vuelve a salir', (tester) async {
    await arrancar(tester);
    expect(find.text(titulo), findsOneWidget);
    expect(find.textContaining('tus cantes y las clases con tu preparador'), findsOneWidget);
    expect(calendarioPreguntado, isTrue);
    await tester.tap(find.text('Ahora no'));
    await tester.pumpAndSettle();
    expect(find.text(titulo), findsNothing);
    expect(usuario.ajustes().calendarioGoogle, isFalse);
    await tester.tap(find.text('Arrancar'));
    await tester.pumpAndSettle();
    expect(find.text(titulo), findsNothing);
  });

  testWidgets('al preparador se le explica lo suyo', (tester) async {
    await arrancar(tester, papel: Papel.preparador);
    expect(find.text(titulo), findsOneWidget);
    expect(find.textContaining('tus alumnos recibirán la invitación'), findsOneWidget);
  });

  testWidgets('no sale en el mismo arranque que la pregunta de estadísticas, y queda pendiente', (tester) async {
    await arrancar(tester, trasOtraPregunta: true);
    expect(find.text(titulo), findsNothing);
    expect(calendarioPreguntado, isFalse);
  });

  testWidgets('con el calendario ya conectado no sale y se da por preguntado', (tester) async {
    await usuario.guardarAjustes(const Ajustes(calendarioGoogle: true));
    await arrancar(tester);
    expect(find.text(titulo), findsNothing);
    expect(calendarioPreguntado, isTrue);
  });

  testWidgets('sin sesión (o sin poder usarlo) no sale ni se marca: se preguntará más adelante', (tester) async {
    await arrancar(tester, permiso: PermisoCalendario.sinSesion);
    expect(find.text(titulo), findsNothing);
    expect(calendarioPreguntado, isFalse);
    await arrancar(tester, conSesion: false);
    expect(find.text(titulo), findsNothing);
    expect(calendarioPreguntado, isFalse);
  });
}
