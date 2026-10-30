import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/features/cantar/reloj_cante.dart';
import 'package:tcee_app/features/cantar/reloj_clase.dart';

/// El cronómetro de las clases con preparador, con lo mismo que el de Cantar.
void main() {
  ControlRelojClase nuevo({List<RelojCante>? publicados, List<String>? avisos}) => ControlRelojClase(
        esquemaPorDefecto: const Duration(minutes: 10),
        exposicionPorDefecto: const Duration(minutes: 30),
        otroNombre: 'Ana',
        miUid: 'yo',
        efectos: false,
        publicador: (r, {temas = const [], elegido}) async => publicados?.add(r),
        alAvisar: (t, {required fin}) => avisos?.add(t),
      );

  test('por defecto cuenta hacia delante desde 0, con los tiempos de la clase', () {
    final c = nuevo();
    final ahora = DateTime.now();
    expect(c.modo, ModoReloj.adelante);
    expect(c.reloj.preparacion, const Duration(minutes: 10));
    expect(lecturaReloj(c.reloj, ahora, c.modo).texto, '00:00');
    c.reloj.iniciar(ahora);
    expect(lecturaReloj(c.reloj, ahora.add(const Duration(minutes: 3, seconds: 5)), c.modo).texto, '03:05');
    c.alternarModo();
    expect(c.modo, ModoReloj.atras);
    expect(lecturaReloj(c.reloj, ahora.add(const Duration(minutes: 3)), c.modo).texto, '07:00');
  });

  test('empezar, pausar, más tiempo y reiniciar todo se publican', () async {
    final publicados = <RelojCante>[];
    final c = nuevo(publicados: publicados);
    c.alternar();
    await Future<void>.delayed(Duration.zero);
    expect(c.reloj.corriendo, isTrue);
    c.ajustarMinutos(5);
    await Future<void>.delayed(Duration.zero);
    expect(c.reloj.preparacion, const Duration(minutes: 15));
    c.alternar();
    await Future<void>.delayed(Duration.zero);
    expect(c.reloj.corriendo, isFalse);
    c.reiniciarTodo();
    await Future<void>.delayed(Duration.zero);
    expect(c.reloj.empezado, isFalse);
    expect(c.reloj.preparacion, const Duration(minutes: 10));
    expect(publicados, hasLength(4));
  });

  test('toma el estado del otro sin repetir los avisos ya pasados y avisa de los nuevos', () {
    final avisos = <String>[];
    final c = nuevo(avisos: avisos);
    final ahora = DateTime.now();
    // El otro empezó hace 20 minutos sin esquema: ya pasó la mitad (15 min).
    final r = RelojCante(exposicion: const Duration(minutes: 30))..iniciar(ahora.subtract(const Duration(minutes: 20)));
    c.recibir(estadoDePrueba(r, temas: ['3.A.1', '3.B.2'], elegido: '3.A.1'));
    expect(c.tic(ahora), isEmpty);
    final luego = c.tic(ahora.add(const Duration(minutes: 9, seconds: 1)));
    expect(luego.map((h) => h.texto), ['Queda 1 minuto.']);
    expect(avisos, ['Queda 1 minuto.']);
    expect(c.siguienteTema, '3.B.2');
    expect(c.quien, 'Otro');
  });

  test('pasar al tema siguiente deja la exposición desde cero', () async {
    final c = nuevo();
    final r = RelojCante(preparacion: const Duration(minutes: 10), exposicion: const Duration(minutes: 30))..iniciar(DateTime.now().subtract(const Duration(minutes: 20)));
    r.empezarExposicion(DateTime.now().subtract(const Duration(minutes: 5)));
    c.recibir(estadoDePrueba(r, temas: ['3.A.1', '3.B.2'], elegido: '3.A.1'));
    await c.pasarAlSiguienteTema();
    expect(c.elegido, '3.B.2');
    expect(c.reloj.corriendo, isFalse);
    expect(c.reloj.expuesto(DateTime.now()), Duration.zero);
    expect(c.siguienteTema, isNull);
  });
}
