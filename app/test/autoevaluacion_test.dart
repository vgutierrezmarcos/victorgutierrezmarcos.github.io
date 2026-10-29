import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/autoevaluacion.dart';

void main() {
  final a = Autoevaluacion.fromJson({
    'codigo': '3.A.8',
    'preguntas': [
      for (var i = 1; i <= 15; i++) {'id': 'p$i', 'tipo': i == 1 ? 'vf' : 'definicion', 'apartado': 'I', 'pregunta': '¿$i?', 'respuesta': i == 1 ? 'Falso: no.' : 'Sí.', if (i == 1) 'verdadero': false},
    ],
  });
  final hoy = DateTime(2026, 10, 29, 10);

  test('lee las preguntas y el índice', () {
    expect(a.preguntas, hasLength(15));
    expect(a.preguntas.first.esVf, isTrue);
    expect(a.preguntas.first.verdadero, isFalse);
    expect(IndiceAutoevaluacion.fromJson({'temas': {'3.A.8': {'archivo': '3A08', 'preguntas': 24}}}).archivoDe('3.A.8'), '3A08');
  });

  test('Leitner: sesión de 12, lo sabido vuelve a los 3 días y lo no sabido al siguiente', () {
    var l = const LeitnerAuto({});
    expect(l.sesion(a.preguntas, hoy), hasLength(12));
    l = l.responder('p1', true, hoy).responder('p2', false, hoy);
    final manana = hoy.add(const Duration(days: 1));
    expect(l.vencida('p1', manana), isFalse);
    expect(l.vencida('p2', manana), isTrue);
    expect(l.vencida('p1', hoy.add(const Duration(days: 3))), isTrue);
    // Primero las vistas que vencen, luego las nuevas.
    expect(l.sesion(a.preguntas, manana).first.id, 'p2');
    expect(LeitnerAuto.fromJson(l.toJson()).estado['p1']!.caja, 2);
  });
}
