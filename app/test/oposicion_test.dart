import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/data/models/temario.dart';
import 'package:tcee_app/features/cantar/probabilidades.dart';
import 'package:tcee_app/features/cantar/sorteo.dart';
import 'package:tcee_app/features/inicio/elegir_oposicion.dart';

/// Una oposición de prueba con otro examen: un oral de dos partes en el que
/// sale un tema de cada parte y basta con saberse uno de los dos, y un escrito
/// sin cante.
const otra = Oposicion(
  id: 'otra',
  siglas: 'OTRA',
  nombre: 'Oposición de prueba',
  web: 'https://otra.example.org',
  rutaContenido: '/contenido',
  ejercicios: [
    EjercicioDef(numero: 1, descripcion: 'Escrito'),
    EjercicioDef(numero: 2, descripcion: 'Oral', cante: TipoCante.temas, sorteo: true, bolasPorParte: 1, partesARedactar: 1),
  ],
);

Tema tema(String codigo) => Tema(codigo: codigo, titulo: codigo, disponible: true, temarioAnterior: false);

void main() {
  group('TCEE, como hasta ahora', () {
    const t = Oposiciones.tcee;

    test('ejercicios con cante, con temas y con sorteo', () {
      expect([for (final e in t.conCante) e.numero], [1, 3, 4]);
      expect([for (final e in t.conTemasCantados) e.numero], [3, 4]);
      expect([for (final e in t.conSorteo) e.numero], [3, 4, 5]);
      expect(t.esDictamen(1), isTrue);
      expect(t.esDictamen(3), isFalse);
      expect(t.primerConTemas, 3);
      expect(t.ejerciciosDeBolsa(0), {3, 4});
      expect(t.nombreEjercicio(0), '3.º y 4.º ejercicio');
      expect(t.nombreEjercicio(3), 'Tercer ejercicio');
      expect(t.ejercicio(1)!.cortoConCante, '1.º (coyuntura)');
    });

    test('reglas del sorteo: las del examen, salvo que app-config.json las cambie', () {
      const config = AppConfig.porDefecto;
      expect([for (final n in [3, 4, 5]) t.bolasPorParte(n, config)], [2, 2, 1]);
      expect(t.partesARedactar(5, config), 2);
      expect(t.partesARedactar(3, config), isNull);
      final cambiada = AppConfig.fromJson({
        'sorteo': {'3': {'bolasPorParte': 3}},
      });
      expect(t.bolasPorParte(3, cambiada), 3);
      expect(t.bolasPorParte(4, cambiada), 2);
    });

    test('sus datos siguen donde estaban', () {
      final db = FakeFirebaseFirestore();
      expect(t.esPrincipal, isTrue);
      expect(t.caja('cantes'), 'cantes');
      expect(t.raizUsuario(db, 'u1').path, 'users/u1');
      expect(t.urlTemario, 'https://www.victorgutierrezmarcos.es/oposicion/temario/temario.json');
      expect(t.urlPreguntas, 'https://www.victorgutierrezmarcos.es/oposicion/temario/primer-ejercicio/test/preguntas.json');
    });
  });

  group('DCE (convocatoria de la OEP 2025)', () {
    const d = Oposiciones.dce;

    test('examen: se canta el 3.º; sortean el 1.º, el 3.º y el 4.º, un par por parte', () {
      expect([for (final e in d.conCante) e.numero], [3]);
      expect([for (final e in d.conSorteo) e.numero], [1, 3, 4]);
      expect([for (final e in d.conCronograma) e.numero], [1, 3, 4]);
      expect([for (final n in [1, 3, 4]) d.bolasPorParte(n, AppConfig.porDefecto)], [2, 2, 2]);
      expect(d.partesARedactar(1, AppConfig.porDefecto), isNull);
      expect(d.esDictamen(1), isFalse);
      expect(d.nombreEjercicio(0), '3.º ejercicio');
    });

    test('contacto: su correo, no el de TCEE', () {
      expect(d.correo, 'mcabag26@gmail.com');
      expect(Oposiciones.tcee.correo, 'contacto@victorgutierrezmarcos.es');
    });

    test('sin test propio: practica el de TCEE, pero lo guarda en lo suyo', () {
      expect(d.testVoluntario, isTrue);
      expect(d.urlPreguntas, Oposiciones.tcee.urlPreguntas);
      expect(d.raizUsuario(FakeFirebaseFirestore(), 'u1').path, 'users/u1/oposiciones/dce');
      expect(d.red(FakeFirebaseFirestore(), 'admins').path, 'oposiciones/dce/admins');
    });

    test('probabilidad del 3.º: como en el Excel, saber uno de los dos de cada parte', () {
      final porParte = {
        '3.A': [for (var i = 1; i <= 22; i++) tema('3.A.$i')],
        '3.B': [for (var i = 1; i <= 22; i++) tema('3.B.$i')],
      };
      final estudiados = {for (var i = 1; i <= 11; i++) '3.A.$i', for (var i = 1; i <= 11; i++) '3.B.$i'};
      final partes = partesDeEjercicio(3, porParte: porParte, estudiados: estudiados, config: AppConfig.porDefecto, oposicion: d);
      // Por parte: x/N + (N−x)/N · x/(N−1) con x = 11 y N = 22.
      const parte = 11 / 22 + (11 / 22) * (11 / 21);
      expect(Sorteo.probEjercicio(partes), closeTo(parte * parte, 1e-12));
    });
  });

  group('otra oposición', () {
    test('sus datos van aparte', () {
      final db = FakeFirebaseFirestore();
      expect(otra.esPrincipal, isFalse);
      expect(otra.caja('cantes'), 'cantes_otra');
      expect(otra.raizUsuario(db, 'u1').path, 'users/u1/oposiciones/otra');
      expect(otra.urlTemario, 'https://otra.example.org/contenido/temario/temario.json');
    });

    test('probabilidad con su examen: uno de cada parte y basta con uno de los dos', () {
      final porParte = {
        '2.A': [for (var i = 1; i <= 10; i++) tema('2.A.$i')],
        '2.B': [for (var i = 1; i <= 20; i++) tema('2.B.$i')],
      };
      final estudiados = {'2.A.1', '2.A.2', '2.A.3', '2.A.4', '2.A.5', '2.B.1'};
      final partes = partesDeEjercicio(2, porParte: porParte, estudiados: estudiados, config: AppConfig.porDefecto, oposicion: otra);
      expect([for (final p in partes) p.bolas], [1, 1]);
      // P(sale uno sabido de A) = 5/10, de B = 1/20. Con «basta con una parte»
      // cuenta la mejor, como en el Excel para el 5.º de TCEE.
      final p = Sorteo.probEjercicio(partes, elegir: otra.partesARedactar(2, AppConfig.porDefecto));
      expect(p, closeTo(0.5, 1e-12));
    });
  });

  testWidgets('la primera vez pregunta a qué se presenta', (tester) async {
    await initializeDateFormatting('es');
    Oposicion? elegida;
    await tester.pumpWidget(ElegirOposicionApp(alElegir: (o) async => elegida = o));
    await tester.pumpAndSettle();
    expect(find.text('¿A qué te presentas?'), findsOneWidget);
    // Las lanzadas, sí; las que aún no, no (solo las ven sus administradores, en Ajustes).
    for (final o in Oposiciones.disponibles) {
      expect(find.text(o.nombre), findsOneWidget);
    }
    for (final o in Oposiciones.sinLanzar) {
      expect(find.text(o.nombre), findsNothing);
    }
    final ultima = Oposiciones.disponibles.last;
    await tester.tap(find.text(ultima.siglas));
    await tester.pump();
    expect(elegida?.id, ultima.id);
  });
}
