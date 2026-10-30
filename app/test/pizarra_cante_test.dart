import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/features/cantar/pizarra_cante.dart';
import 'package:tcee_app/features/cantar/pizarra_pdf.dart';
import 'package:tcee_app/features/cantar/pizarra_trazos.dart';
import 'package:tcee_app/features/cantar/reloj_cante.dart';
import 'package:tcee_app/features/cantar/transcripcion.dart';

/// La pizarra del cante que se manda a la IA con la transcripción: el minuto
/// de cada trazo y el PDF con una página por minuto.
void main() {
  final t0 = DateTime(2026, 11, 3, 18);
  final fecha = DateTime(2026, 11, 3, 18, 2);

  Trazo trazo(String id, {int? color}) => Trazo(id: id, de: 'yo', grosor: 6, puntos: const [Point(10, 10), Point(200, 120)], color: color ?? 0xFF1E5AA8);
  PaginaPizarra hoja(List<Trazo> trazos, {int n = 1}) => PaginaPizarra(id: 'p$n', n: n, trazos: trazos);

  /// Una cronología con el tiempo de exposición que se le diga en cada lectura.
  ({CronologiaPizarra c, void Function(Duration en, List<PaginaPizarra> p) leer}) cronologia({String? Function()? tema}) {
    var ahora = Duration.zero;
    final c = CronologiaPizarra(reloj: (_) => ahora, tema: tema);
    return (
      c: c,
      leer: (en, p) {
        ahora = en;
        c.observar(p, ahora: t0.add(en));
      },
    );
  }

  test('una página por minuto en que cambia, con la pizarra entera al final del minuto', () {
    final x = cronologia(tema: () => '3.A.8');
    final a = trazo('a'), b = trazo('b'), c = trazo('c');
    x.leer(const Duration(seconds: 5), [hoja([a])]);
    x.leer(const Duration(seconds: 40), [hoja([a, b])]);
    // El minuto 1 no cambia nada: no hay página.
    x.leer(const Duration(minutes: 2, seconds: 15), [hoja([a, b, c])]);
    final paginas = x.c.paginas(fecha: fecha);
    expect(paginas.map((p) => cabeceraPaginaCante(p, fecha)), [
      '[00:00]–[01:00] · Tema 3.A.8 · Cante del 3 nov. 2026',
      '[02:00]–[03:00] · Tema 3.A.8 · Cante del 3 nov. 2026',
    ]);
    expect(paginas[0].trazos.map((t) => t.id), ['a', 'b']);
    expect(paginas[0].nuevos, {'a', 'b'});
    // Lo de antes sigue (más claro); lo nuevo es solo c.
    expect(paginas[1].trazos.map((t) => t.id), ['a', 'b', 'c']);
    expect(paginas[1].nuevos, {'c'});
  });

  test('una página justo antes de cada borrado, y lo de después desde cero', () {
    final x = cronologia(tema: () => '3.A.8');
    final a = trazo('a'), b = trazo('b'), c = trazo('c');
    x.leer(const Duration(minutes: 3, seconds: 10), [hoja([a, b])]);
    x.leer(const Duration(minutes: 3, seconds: 37), [hoja([])]);
    x.leer(const Duration(minutes: 3, seconds: 50), [hoja([c])]);
    expect(x.c.eventos.map((e) => e.tipo), [TipoEventoPizarra.poner, TipoEventoPizarra.poner, TipoEventoPizarra.borrar, TipoEventoPizarra.poner]);
    final paginas = x.c.paginas(fecha: fecha);
    expect(paginas.map((p) => cabeceraPaginaCante(p, fecha)), [
      '[03:00]–[03:37] · Tema 3.A.8 · Cante del 3 nov. 2026 · antes de borrar',
      '[03:00]–[04:00] · Tema 3.A.8 · Cante del 3 nov. 2026',
    ]);
    expect(paginas[0].trazos.map((t) => t.id), ['a', 'b']);
    expect(paginas[1].trazos.map((t) => t.id), ['c']);
    expect(paginas[1].nuevos, {'c'});
  });

  test('si se borra sin haber dibujado nada desde la última página, se anota en ella', () {
    final x = cronologia();
    x.leer(const Duration(seconds: 20), [hoja([trazo('a')])]);
    x.leer(const Duration(minutes: 1, seconds: 5), [hoja([])]);
    final paginas = x.c.paginas(fecha: fecha);
    expect(paginas, hasLength(1));
    expect(cabeceraPaginaCante(paginas.single, fecha), '[00:00]–[01:00] · Cante del 3 nov. 2026 · se borra en [01:05]');
  });

  test('la goma y deshacer quitan trazos sin contar como borrado', () {
    final x = cronologia();
    final a = trazo('a'), b = trazo('b');
    x.leer(const Duration(seconds: 10), [hoja([a, b])]);
    x.leer(const Duration(minutes: 1, seconds: 10), [hoja([a])]);
    expect(x.c.eventos.last.tipo, TipoEventoPizarra.quitar);
    final paginas = x.c.paginas(fecha: fecha);
    expect(paginas.map((p) => p.trazos.map((t) => t.id).toList()), [
      ['a', 'b'],
      ['a'],
    ]);
    expect(paginas[1].nuevos, isEmpty);
  });

  test('varias páginas de la pizarra: cada una la suya, y el cambio de página se anota', () {
    final x = cronologia();
    x.leer(const Duration(seconds: 10), [hoja([trazo('a')])]);
    x.c.verHoja('p2', ahora: t0);
    x.leer(const Duration(seconds: 30), [hoja([trazo('a')]), hoja([trazo('b')], n: 2)]);
    expect(x.c.eventos.map((e) => e.tipo), contains(TipoEventoPizarra.pagina));
    final paginas = x.c.paginas(fecha: fecha);
    expect(paginas.map((p) => cabeceraPaginaCante(p, fecha)), [
      '[00:00]–[01:00] · Cante del 3 nov. 2026 · página 1 de la pizarra',
      '[00:00]–[01:00] · Cante del 3 nov. 2026 · página 2 de la pizarra',
    ]);
  });

  test('con dos temas, cada uno empieza en 00:00 con su código', () {
    var tema = '3.A.8';
    final x = cronologia(tema: () => tema);
    x.leer(const Duration(minutes: 5), [hoja([trazo('a')])]);
    tema = '3.B.1';
    x.leer(const Duration(seconds: 20), [hoja([trazo('a'), trazo('b')])]);
    final paginas = x.c.paginas(fecha: fecha);
    expect(paginas.map((p) => cabeceraPaginaCante(p, fecha)), [
      '[05:00]–[06:00] · Tema 3.A.8 · Cante del 3 nov. 2026',
      '[00:00]–[01:00] · Tema 3.B.1 · Cante del 3 nov. 2026',
    ]);
    expect(paginas[1].nuevos, {'b'});
  });

  test('las pausas no cuentan: el tiempo es el de exposición, como en la transcripción', () {
    final reloj = RelojCante(exposicion: const Duration(minutes: 30))..iniciar(t0);
    final c = CronologiaPizarra(reloj: reloj.expuesto, grabando: () => reloj.empezado);
    c.observar([hoja([trazo('a')])], ahora: t0.add(const Duration(seconds: 30)));
    reloj.pausar(t0.add(const Duration(seconds: 50)));
    // En pausa, lo que se dibuja queda en el momento en que se paró.
    c.observar([hoja([trazo('a'), trazo('b')])], ahora: t0.add(const Duration(minutes: 5)));
    reloj.iniciar(t0.add(const Duration(minutes: 6)));
    c.observar([hoja([trazo('a'), trazo('b'), trazo('c')])], ahora: t0.add(const Duration(minutes: 6, seconds: 20)));
    expect(c.eventos.map((e) => e.en), const [Duration(seconds: 30), Duration(seconds: 50), Duration(minutes: 1, seconds: 10)]);
    expect(c.inicio, t0.add(const Duration(seconds: 30)));
  });

  test('el esquema no cuenta: lo dibujado en él sale en el minuto 0', () {
    final reloj = RelojCante(preparacion: const Duration(minutes: 20), exposicion: const Duration(minutes: 30))..iniciar(t0);
    final c = CronologiaPizarra(reloj: reloj.expuesto, grabando: () => reloj.empezado);
    c.observar([hoja([trazo('a')])], ahora: t0.add(const Duration(minutes: 12)));
    reloj.empezarExposicion(t0.add(const Duration(minutes: 20)));
    c.observar([hoja([trazo('a'), trazo('b')])], ahora: t0.add(const Duration(minutes: 21, seconds: 30)));
    expect(c.eventos.map((e) => e.en), const [Duration.zero, Duration(minutes: 1, seconds: 30)]);
  });

  test('antes de empezar no se graba: lo que hay es el punto de partida, más claro', () {
    var empezado = false;
    final c = CronologiaPizarra(reloj: (_) => const Duration(seconds: 15), grabando: () => empezado);
    c.observar([hoja([trazo('a')])], ahora: t0);
    expect(c.eventos, isEmpty);
    expect(c.vacia, isTrue);
    expect(c.paginas(fecha: fecha), isEmpty);
    empezado = true;
    c.observar([hoja([trazo('a'), trazo('b')])], ahora: t0);
    final p = c.paginas(fecha: fecha).single;
    expect(p.trazos.map((t) => t.id), ['a', 'b']);
    expect(p.nuevos, {'b'});
    // Al reiniciar el cronómetro, lo que hay pasa a ser el punto de partida.
    c.reiniciar();
    expect(c.vacia, isTrue);
    expect(c.inicial['p1']!.keys, ['a', 'b']);
  });

  test('el color de quien pinta se guarda en cada trazo, y todo vuelve igual de Hive', () {
    final c = CronologiaPizarra(tema: () => '3.A.8');
    final sinColor = Trazo(id: 'a', de: 'alumno', grosor: 6, puntos: const [Point(1, 1), Point(5, 5)]);
    c.observar([PaginaPizarra(id: 'p1', n: 1, trazos: [sinColor], fondo: fondoRayas)], ahora: t0, colorDe: (_) => 0xFF2E7D9A);
    c.observar([PaginaPizarra(id: 'p1', n: 1, trazos: const [], fondo: fondoRayas)], ahora: t0);
    expect(c.eventos.first.trazo!.color, 0xFF2E7D9A);
    // Como en Hive: los mapas vuelven sin tipos.
    final vuelta = CronologiaPizarra.fromJson(jsonDecode(jsonEncode(c.toJson())) as Map);
    expect(vuelta.eventos.map((e) => (e.tipo, e.en, e.hoja, e.tema)), c.eventos.map((e) => (e.tipo, e.en, e.hoja, e.tema)));
    expect(vuelta.eventos.first.trazo!.puntos, sinColor.puntos);
    expect(vuelta.fondos['p1'], fondoRayas);
    expect(vuelta.paginas(fecha: fecha).single.fondo, fondoRayas);
  });

  test('nombre del PDF y línea del .txt', () {
    expect(nombreFicheroPizarra('3.A.8', DateTime(2026, 11, 3, 18)), 'pizarra_3A08_2026-11-03.pdf');
    expect(fechaDeCante(DateTime(2026, 9, 7)), '7 sept. 2026');
    expect(lineaPizarra('pizarra_3A08_2026-11-03.pdf'), 'Pizarra: pizarra_3A08_2026-11-03.pdf (una página por minuto con su marca [mm:ss])');
    final texto = (Transcripcion()..anadir('Hola', Duration.zero)).fichero(
      oposicion: 'TCEE',
      ejercicio: 'Tercer ejercicio',
      tema: '3.A.8',
      fecha: DateTime(2026, 11, 3, 18, 2),
      exposicion: const Duration(minutes: 29),
      exposicionPrevista: const Duration(minutes: 30),
      pizarra: 'pizarra_3A08_2026-11-03.pdf',
    );
    expect(texto.split('\n').take(4).toList(), [
      '# Cante · Oposición TCEE · Tercer ejercicio · Tema 3.A.8',
      'Fecha: 2026-11-03 18:02 · Exposición: 29:00 (prevista 30:00)',
      'Pizarra: pizarra_3A08_2026-11-03.pdf (una página por minuto con su marca [mm:ss])',
      'Transcripción automática del móvil: puede tener errores de reconocimiento (nombres propios, fórmulas, números).',
    ]);
    // Al borrar la pizarra se quita; y no se repite si ya estaba.
    final sin = conLineaPizarra(texto, null);
    expect(sin.contains('Pizarra:'), isFalse);
    expect(conLineaPizarra(sin, 'pizarra_3A08_2026-11-03.pdf'), texto);
    expect(conLineaPizarra(texto, 'pizarra_3A08_2026-11-03.pdf'), texto);
  });

  test('el PDF sale con una página por tramo y pesa poco', () async {
    final x = cronologia(tema: () => '3.A.8');
    final texto = Trazo.texto(id: 't', de: 'yo', posicion: const Point(100, 100), texto: 'Y = C + I', tamano: 36, ancho: 300, alto: 50, color: 0xFF1F1F1F);
    x.leer(const Duration(seconds: 5), [hoja([trazo('a'), texto])]);
    x.leer(const Duration(minutes: 1, seconds: 5), [hoja([trazo('a'), texto, trazo('b', color: (alfaFosforito << 24) | 0xFDD835)])]);
    final paginas = x.c.paginas(fecha: fecha);
    // Sin la letra de la app (en las pruebas no hay assets): la estándar del PDF.
    final bytes = await pdfPizarraCante(paginas, fecha: fecha);
    expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
    expect(RegExp(r'/Type\s*/Page\b').allMatches(latin1.decode(bytes)).length, 2);
    expect(bytes.length, lessThan(60 * 1024));
  });
}
