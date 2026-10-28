import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/preparador.dart';

/// Lista de control y esquema a ciegas: el modelo (cubiertos y apartados en
/// el resultado, el cante marcado como esquema), las estadísticas por tema y
/// los apartados que nunca se cuentan.
void main() {
  final hoy = DateTime(2026, 10, 28, 18);
  Cante cante(String id, {required int diasAtras, bool esquema = false, int valoracion = 3, List<String> cubiertos = const [], int apartados = 0}) => Cante(
        id: id,
        fecha: hoy.subtract(Duration(days: diasAtras)),
        estado: EstadoCante.hecho,
        esquema: esquema,
        temas: const ['3.A.1'],
        resultado: ResultadoCante(temaCantado: '3.A.1', valoracion: valoracion, segundos: esquema ? 600 : 1800, cubiertos: apartados == 0 ? const {} : {'3.A.1': cubiertos}, apartados: apartados == 0 ? const {} : {'3.A.1': apartados}),
        updatedAt: hoy,
      );

  test('la lista de control va y vuelve del JSON y se describe', () {
    const r = ResultadoCante(temaCantado: '3.A.1', otrosCantados: ['3.B.2'], valoracion: 4, cubiertos: {'3.A.1': ['1. Objeto', '2. Método']}, apartados: {'3.A.1': 5, '3.B.2': 7});
    final v = ResultadoCante.fromJson(r.toJson());
    expect(v.cubiertos, {'3.A.1': ['1. Objeto', '2. Método']});
    expect(v.apartados, {'3.A.1': 5, '3.B.2': 7});
    expect(v.textoCobertura('3.A.1'), '2/5 apartados');
    expect(v.textoCobertura('3.C.9'), isNull);
    expect(v.textoCoberturaTotal, '2/5 · 0/7 apartados');
    expect(const ResultadoCante().textoCoberturaTotal, isNull);
    // Sin lista no se escribe nada (las versiones anteriores no ven claves nuevas).
    expect(const ResultadoCante(valoracion: 2).toJson().containsKey('cubiertos'), isFalse);
  });

  test('un esquema a ciegas se guarda como cante con «esquema» y cuenta aparte', () {
    final e = cante('e1', diasAtras: 1, esquema: true, valoracion: 2, cubiertos: const ['1. Objeto'], apartados: 4);
    final j = e.toJson();
    expect(j['esquema'], isTrue);
    expect(Cante.fromJson(j).esquema, isTrue);
    expect(Cante.fromJson({...j}..remove('esquema')).esquema, isFalse);
    final stats = EstadisticaTema.desde([e, cante('c1', diasAtras: 5, valoracion: 4), cante('c2', diasAtras: 9, valoracion: 4)])['3.A.1']!;
    expect(stats.veces, 2, reason: 'los cantes enteros');
    expect(stats.esquemas, 1);
    expect(stats.valoracionMedia, 4, reason: 'la autovaloración del esquema no entra en la media');
    expect(stats.segundosMedios, 1800);
    expect(stats.ultimo, hoy.subtract(const Duration(days: 1)), reason: 'pero sí refresca el tema');
    // Solo esquemas: cero cantes, un esquema.
    final solo = EstadisticaTema.desde([e])['3.A.1']!;
    expect(solo.veces, 0);
    expect(solo.esquemas, 1);
  });

  test('apartados que nunca se tocan: en dos o más cantes con lista y ninguna vez marcados', () {
    final cantes = [
      cante('c1', diasAtras: 1, cubiertos: const ['1. Objeto', '2. Método'], apartados: 4),
      cante('c2', diasAtras: 8, cubiertos: const ['1. Objeto', '3. Ramas'], apartados: 4),
      cante('c3', diasAtras: 20), // sin lista: no cuenta
    ];
    final cob = CoberturaApartados.desde(cantes, '3.A.1', apartados: const ['1. Objeto', '2. Método', '3. Ramas', '4. Historia']);
    expect(cob.porApartado['1. Objeto'], (cubierto: 2, ofrecido: 2));
    expect(cob.porApartado['2. Método'], (cubierto: 1, ofrecido: 2));
    expect(cob.porApartado['4. Historia'], (cubierto: 0, ofrecido: 2));
    expect(cob.nuncaCubiertos, ['4. Historia']);
    // Con un solo cante con lista aún no se dice nada.
    expect(CoberturaApartados.desde(cantes.take(1), '3.A.1', apartados: const ['1. Objeto', '4. Historia']).nuncaCubiertos, isEmpty);
    // Sin la lista de apartados, solo se conocen los que alguna vez se marcaron.
    expect(CoberturaApartados.desde(cantes, '3.A.1').nuncaCubiertos, isEmpty);
  });

  test('el informe del cante lleva los apartados tocados', () {
    final c = cante('c1', diasAtras: 0, cubiertos: const ['1. Objeto'], apartados: 4);
    expect(informeCante(c, alumno: 'Ana'), contains('Apartados tocados: 1/4 apartados'));
    expect(informeCante(cante('c2', diasAtras: 0)), isNot(contains('Apartados')));
  });
}
