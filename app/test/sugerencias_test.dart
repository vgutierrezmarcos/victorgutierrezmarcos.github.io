import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/sugerencia.dart';

/// Las sugerencias de mejora que el usuario manda al autor.
void main() {
  test('se lee lo que escriben la app, el conector y la Action, y lo que no se entiende queda como recibida', () {
    final app = Sugerencia.fromJson('s_1', {'recurso': 'ficha', 'tema': '3.A.8', 'tipo': 'errata', 'propuesta': 'Sobra una coma.', 'estado': 'recibida', 'origen': 'app 1.26.0'}, creado: DateTime(2026, 11, 5));
    final ia = Sugerencia.fromJson('s_2', {'recurso': 'tema', 'tema': '3.A.8', 'apartado': 'II. Estática comparativa', 'tipo': 'no_explica', 'propuesta': 'Falta Slutsky.', 'estado': 'aceptada', 'respuesta': 'Añadido.', 'origen': 'conector (Claude)'}, creado: DateTime(2026, 11, 1));
    final rara = Sugerencia.fromJson('s_3', {'tema': 7, 'estado': 'publicada', 'tipo': 'x', 'vista': 'sí'});
    expect(app.titulo, 'Ficha del 3.A.8');
    expect(app.nombreTipo, 'Errata');
    expect(app.resuelta, isFalse);
    expect(ia.titulo, 'Tema 3.A.8');
    expect(ia.desdeIa, isTrue);
    expect(ia.novedad, isTrue);
    expect(ia.nombreEstado, 'Aceptada');
    expect(rara.estado, 'recibida');
    expect(rara.tema, '');
    expect(rara.nombreTipo, 'Otra cosa');
    expect(rara.vista, isFalse);
    // Recién enviada (sin fecha del servidor todavía), la primera; luego, de la más nueva a la más vieja.
    expect(Sugerencia.ordenar([ia, rara, app]).map((s) => s.id), ['s_3', 's_1', 's_2']);
  });

  test('una resuelta deja de ser novedad al verla, y se cuentan los materiales mejorados, no las sugerencias', () {
    Sugerencia s(String id, String recurso, String tema, String estado, {bool vista = false}) =>
        Sugerencia.fromJson(id, {'recurso': recurso, 'tema': tema, 'estado': estado, 'vista': vista, 'propuesta': 'p'});
    final lista = [s('a', 'tema', '3.A.8', 'aceptada'), s('b', 'tema', '3.A.8', 'aceptada', vista: true), s('c', 'ficha', '3.A.8', 'aceptada'), s('d', 'tema', '3.A.9', 'descartada'), s('e', 'tema', '3.B.1', 'recibida')];
    expect(lista.where((x) => x.novedad).map((x) => x.id), ['a', 'c', 'd']);
    expect(Sugerencia.materialesMejorados(lista), 2);
  });

  test('solo los temas y sus fichas admiten sugerencias', () {
    expect(Sugerencia.destinoDe('3.A.8'), (tema: '3.A.8', recurso: 'tema'));
    expect(Sugerencia.destinoDe('3.B.31-repaso'), (tema: '3.B.31', recurso: 'ficha'));
    expect(Sugerencia.destinoDe('1D01'), isNull);
    expect(Sugerencia.destinoDe('recopilacion-test'), isNull);
  });
}
