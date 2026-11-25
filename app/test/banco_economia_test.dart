import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/repos/banco_economia.dart';

void main() {
  test('el banco de EconomIA se lee como preguntas no oficiales con su explicación', () {
    final b = BancoEconomia.fromJson({
      'preguntas': [
        {'id': 310101, 'temas': ['3.A.1'], 'enunciado': 'Robbins…', 'opciones': {'a': 'x', 'b': 'y', 'c': 'z', 'd': 'w'}, 'respuesta': ['c'], 'explicacion': {'clave': 'Por la escasez.', 'desarrollo': 'Párrafo.'}, 'imagenes': [{'src': 'https://mcp.example/app/banco/img/1.webp?f=ab', 'alt': 'figura'}]},
        {'id': 'mala'},
      ],
    });
    expect(b.preguntas, hasLength(1));
    final p = b.preguntas.single;
    expect(p.oficial, isFalse);
    expect(p.examen, examenBancoEconomia);
    expect(p.esCorrecta('c'), isTrue);
    expect(p.imagenes.single.src, startsWith('https://'));
    expect(b.explicaciones[310101]!.clave, 'Por la escasez.');
  });
}
