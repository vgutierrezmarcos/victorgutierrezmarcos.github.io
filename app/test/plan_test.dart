import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/core/calendario.dart';
import 'package:tcee_app/core/notificaciones.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/temario.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';
import 'package:tcee_app/features/cantar/reloj_cante.dart';
import 'package:tcee_app/features/plan/cantes_util.dart';

void main() {
  test('aviso de actualización: comparación de versiones', () {
    expect(AppConfig.esPosterior('1.3.1', '1.3.0'), isTrue);
    expect(AppConfig.esPosterior('1.10.0', '1.9.3'), isTrue);
    expect(AppConfig.esPosterior('2.0.0', '1.99.99'), isTrue);
    expect(AppConfig.esPosterior('1.3.1', '1.3.1'), isFalse);
    expect(AppConfig.esPosterior('1.3.0', '1.3.1'), isFalse);
    expect(AppConfig.esPosterior('1.3.1+5', '1.3.1'), isFalse);
    final c = AppConfig.fromJson({'app': {'versionActual': '1.4.0', 'urlApk': 'https://example.org/app.apk'}});
    expect(c.versionActual, '1.4.0');
    expect(c.urlApk, 'https://example.org/app.apk');
  });

  test('el recordatorio diario está desactivado por defecto', () {
    expect(const Ajustes().horaRecordatorio, -1);
    expect(Ajustes.fromJson(null).horaRecordatorio, -1);
    // Los ajustes guardados por versiones anteriores traían las 20:00 sin que nadie lo activara.
    expect(Ajustes.fromJson({'horaRecordatorio': 1200, 'racha': 3}).horaRecordatorio, -1);
    final activado = const Ajustes().copyWith(horaRecordatorio: 21 * 60);
    expect(Ajustes.fromJson(activado.toJson()).horaRecordatorio, 21 * 60);
  });

  group('cantes', () {
    final base = Cante(id: 'a', fecha: DateTime(2026, 10, 8, 17), titulo: 'Preparador', bolsa: TipoBolsa.lista, temas: const ['3.A.1', '3.B.2'], updatedAt: DateTime(2026, 10, 1));

    test('ida y vuelta por JSON', () {
      final c = base.copyWith(estado: EstadoCante.hecho, resultado: const ResultadoCante(sorteados: ['3.A.1', '3.B.2'], temaCantado: '3.A.1', segundos: 840, valoracion: 4, comentarios: 'Bien'));
      final d = Cante.fromJson(c.toJson());
      expect(d.fecha, c.fecha);
      expect(d.bolsa, TipoBolsa.lista);
      expect(d.temas, ['3.A.1', '3.B.2']);
      expect(d.hecho, isTrue);
      expect(d.resultado!.temaCantado, '3.A.1');
      expect(d.resultado!.segundos, 840);
    });

    test('la fusión se queda con la versión más reciente, también si es un borrado', () {
      final viejo = base;
      final borrado = Cante.fromJson({...base.toJson(), 'borrado': true, 'updatedAt': DateTime(2026, 10, 2).toIso8601String()});
      final otro = Cante(id: 'b', fecha: DateTime(2026, 10, 1, 9), updatedAt: DateTime(2026, 9, 1));
      final f = Cante.fusionar([viejo, otro], [borrado]);
      expect(f.map((c) => c.id), ['b', 'a']); // ordenados por fecha
      expect(f.last.borrado, isTrue);
      expect(Cante.fusionar([borrado], [viejo]).single.borrado, isTrue);
    });

    test('serie semanal hasta la fecha indicada', () {
      final serie = serieSemanal(base, DateTime(2026, 10, 29));
      expect(serie.map((c) => c.fecha.day), [8, 15, 22, 29]);
      expect(serie.every((c) => c.fecha.hour == 17 && c.fecha.weekday == DateTime.thursday), isTrue);
      expect(serie.first.id, 'a');
      expect(serie.map((c) => c.id).toSet().length, 4);
      expect(serie.map((c) => c.serie).toSet().length, 1);
    });

    test('la serie conserva la hora al cruzar el cambio de hora', () {
      final serie = serieSemanal(Cante(id: 'x', fecha: DateTime(2026, 10, 22, 17)), DateTime(2026, 11, 5));
      expect(serie.map((c) => '${c.fecha.day}/${c.fecha.month} ${c.fecha.hour}'), ['22/10 17', '29/10 17', '5/11 17']);
    });

    test('estadísticas por tema del diario', () {
      Cante hecho(String id, String tema, int seg, int val, int dia) =>
          Cante(id: id, fecha: DateTime(2026, 10, dia), estado: EstadoCante.hecho, resultado: ResultadoCante(temaCantado: tema, segundos: seg, valoracion: val));
      final s = EstadisticaTema.desde([hecho('1', '3.A.1', 600, 2, 1), hecho('2', '3.A.1', 800, 3, 5), hecho('3', '3.B.2', 0, 0, 2), base]);
      expect(s.keys.toSet(), {'3.A.1', '3.B.2'});
      expect(s['3.A.1']!.veces, 2);
      expect(s['3.A.1']!.segundosMedios, 700);
      expect(s['3.A.1']!.valoracionMedia, 2.5);
      expect(s['3.A.1']!.flojo, isTrue);
      expect(s['3.A.1']!.ultimo, DateTime(2026, 10, 5));
      expect(s['3.B.2']!.flojo, isFalse); // sin valorar no cuenta como flojo
    });

    test('avisos: la víspera a las 20:00 y una hora antes', () {
      final a = Notificaciones.avisosDeCante(base);
      expect(a.map((x) => x.cuando), [DateTime(2026, 10, 7, 20), DateTime(2026, 10, 8, 16)]);
      expect(a.first.texto, contains('17:00'));
    });
  });

  group('horario', () {
    test('el horario por defecto reproduce las estadísticas del Excel', () {
      final h = Horario.porDefecto();
      expect(h.dias.every((d) => d.length == 48), isTrue);
      final semana = h.horasPorDia();
      // Valores de la hoja "Horario de estudio": COUNTIF(...) * 0,5 / 7
      expect(semana[Actividad.dormir], closeTo((6 * 15 + 20) * 0.5 / 7, 1e-9));
      expect(semana[Actividad.estudiar], closeTo((4 * 18 + 2 * 16) * 0.5 / 7, 1e-9));
      expect(semana[Actividad.idioma], closeTo(4 * 0.5 / 7, 1e-9));
      expect(semana[Actividad.ejercicio], closeTo(6 * 3 * 0.5 / 7, 1e-9));
      expect(semana.values.reduce((a, b) => a + b), closeTo(24, 1e-9));
      final sinSabado = h.horasPorDia(sinSabado: true);
      expect(sinSabado[Actividad.dormir], closeTo(7.5, 1e-9));
      expect(sinSabado.values.reduce((a, b) => a + b), closeTo(24, 1e-9));
      expect(h.horasEstudioSemana, 52);
    });

    test('pintar y guardar', () {
      final h = Horario.porDefecto().con(5, 20, Actividad.estudiar); // sábado a las 10:00
      expect(h.dias[5][20], Actividad.estudiar);
      expect(Horario.porDefecto().dias[5][20], Actividad.desayuno);
      final d = Horario.fromJson(h.toJson());
      expect(d.dias[5][20], Actividad.estudiar);
      expect(d.toJson(), h.toJson());
      expect(Horario.fromJson(['corrupto']).toJson(), Horario.porDefecto().toJson());
    });
  });

  test('plan: ida y vuelta por JSON', () {
    final p = const Plan().copyWith(
      fechas: {1: DateTime(2027, 3, 6), 3: DateTime(2027, 6, 1)},
      hitos: [Hito(id: 'h', titulo: 'Simulacro', fecha: DateTime(2027, 2, 1))],
      avisosCante: false,
    );
    final d = Plan.fromJson(p.toJson());
    expect(d.fechas, p.fechas);
    expect(d.hitos.single.titulo, 'Simulacro');
    expect(d.horario, isNull);
    expect(d.avisosCante, isFalse);
    expect(d.updatedAt, isNotNull);
    expect(Plan.fromJson(null).avisosCante, isTrue);
  });

  group('agenda por tema', () {
    test('apuntar, resolver, borrar y dar una vuelta', () {
      var a = const AgendaTema(codigo: '3.A.7').anadir('Actualizar datos de inflación').anadir('Gráfico IS-LM');
      expect(a.pendientes.length, 2);
      a = a.alternar(a.apuntes.first.id);
      expect(a.pendientes.single.texto, 'Gráfico IS-LM');
      expect(a.resueltos.single.texto, 'Actualizar datos de inflación');
      a = a.vueltaCompletada(DateTime(2026, 10, 2));
      // El apunte no resuelto sigue pendiente para la siguiente vuelta.
      expect(a.pendientes.single.texto, 'Gráfico IS-LM');
      expect(a.vueltas, [DateTime(2026, 10, 2)]);
      a = a.borrar(a.pendientes.single.id);
      expect(a.pendientes, isEmpty);
      final d = AgendaTema.fromJson('3.A.7', a.toJson());
      expect(d.resueltos.length, 1);
      expect(d.vueltas.length, 1);
      expect(d.vacia, isFalse);
      expect(const AgendaTema(codigo: 'x').vacia, isTrue);
    });

    test('fusionar no pierde apuntes de ningún dispositivo y respeta resueltos y borrados', () {
      final comun = const AgendaTema(codigo: 't').anadir('común');
      final movil = comun.anadir('desde el móvil').alternar(comun.apuntes.single.id).vueltaCompletada(DateTime(2026, 10, 1));
      final tableta = comun.anadir('desde la tableta').vueltaCompletada(DateTime(2026, 10, 1));
      final f = AgendaTema.fusionar(movil, tableta);
      expect(f.apuntes.length, 3);
      expect(f.pendientes.map((x) => x.texto).toSet(), {'desde el móvil', 'desde la tableta'});
      expect(f.vueltas.length, 1);
      final conBorrado = AgendaTema.fusionar(f.borrar(f.pendientes.first.id), f);
      expect(conBorrado.pendientes.length, 1);
    });
  });

  group('reloj de cante', () {
    final t0 = DateTime(2026, 10, 8, 17);
    DateTime en(int min, [int seg = 0]) => t0.add(Duration(minutes: min, seconds: seg));

    test('fases, pausa y fin', () {
      final r = RelojCante(preparacion: const Duration(minutes: 5), exposicion: const Duration(minutes: 10));
      expect(r.empezado, isFalse);
      r.iniciar(t0);
      expect(r.enPreparacion(en(4)), isTrue);
      expect(r.restanteFase(en(4)), const Duration(minutes: 1));
      expect(r.enPreparacion(en(5)), isFalse);
      expect(r.restanteFase(en(7)), const Duration(minutes: 8));
      expect(r.expuesto(en(7)), const Duration(minutes: 2));
      r.pausar(en(7));
      expect(r.corriendo, isFalse);
      expect(r.transcurrido(en(60)), const Duration(minutes: 7)); // parado no avanza
      r.iniciar(en(60));
      expect(r.terminado(en(67, 59)), isFalse);
      expect(r.terminado(en(68)), isTrue);
      expect(r.expuesto(en(90)), const Duration(minutes: 10)); // no pasa del total
      expect(r.progresoFase(en(90)), 1);
    });

    test('hitos y avisos pendientes', () {
      final r = RelojCante(preparacion: const Duration(minutes: 5), exposicion: const Duration(minutes: 10));
      expect(r.hitos.map((h) => h.en.inMinutes), [5, 10, 14, 15]);
      expect(r.hitos.last.fin, isTrue);
      r.iniciar(t0);
      expect(r.avisosPendientes(en(6)).map((a) => a.cuando), [en(10), en(14), en(15)]);
      // Exposición muy corta: solo avisa al final.
      expect(RelojCante(exposicion: const Duration(minutes: 2)).hitos.length, 1);
    });
  });

  group('calendario', () {
    final cante = Cante(id: 'abc', fecha: DateTime.utc(2026, 10, 8, 15).toLocal(), titulo: 'Preparador; grupo, A', notas: 'Línea 1\nLínea 2');

    test('fichero .ics', () {
      final ics = Calendario.ics([eventoDeCante(cante), eventoDeFecha('ej1', 'TCEE · Primer ejercicio', DateTime(2027, 3, 6))], ahora: DateTime.utc(2026, 10, 2, 9));
      final lineas = ics.split('\r\n');
      expect(lineas.first, 'BEGIN:VCALENDAR');
      expect(lineas[lineas.length - 2], 'END:VCALENDAR');
      expect(ics, contains('UID:cante-abc@victorgutierrezmarcos.es'));
      expect(ics, contains('DTSTAMP:20261002T090000Z'));
      expect(ics, contains('DTSTART:20261008T150000Z'));
      expect(ics, contains('DTEND:20261008T153000Z')); // 30 minutos por defecto
      expect(ics, contains(r'SUMMARY:Cante TCEE · Preparador\; grupo\, A'));
      expect(ics, contains(r'Línea 1\nLínea 2'));
      expect(ics, contains('TRIGGER:-PT60M'));
      expect(ics, contains('DTSTART;VALUE=DATE:20270306'));
      expect(ics, contains('DTEND;VALUE=DATE:20270307'));
      expect('BEGIN:VEVENT'.allMatches(ics).length, 2);
      expect(lineas.every((l) => l.length <= 75), isTrue);
    });

    test('enlace de Google Calendar', () {
      final url = Uri.parse(Calendario.urlGoogle(eventoDeCante(cante)));
      expect(url.host, 'calendar.google.com');
      expect(url.queryParameters['action'], 'TEMPLATE');
      expect(url.queryParameters['dates'], '20261008T150000Z/20261008T153000Z');
      expect(url.queryParameters['text'], 'Cante TCEE · Preparador; grupo, A');
    });
  });
}
