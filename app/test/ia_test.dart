import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/core/ia.dart';
import 'package:tcee_app/core/ia_mensajes.dart';
import 'package:tcee_app/data/models/oposicion.dart';

void main() {
  final hoy = DateTime.utc(2026, 11, 11);

  test('lee del documento del conector las IA conectadas', () {
    final c = conexionesDe({
      'ias': {
        'claude': {'ultimoUso': '2026-11-11T10:00:00.000Z'},
        'otra': {'ultimoUso': '2026-11-10T10:00:00.000Z'},
        'lechat': {'ultimoUso': 'mal'},
      },
    });
    expect(c.keys, [Ia.claude]);
    expect(conexionesDe(null), isEmpty);
  });

  test('sin elegir, la IA es la última con la que se usó el conector', () {
    expect(iaElegida(const EstadoIa(), {Ia.claude: hoy.subtract(const Duration(days: 3)), Ia.lechat: hoy}), Ia.lechat);
    expect(iaElegida(const EstadoIa(preferida: Ia.chatgpt), {Ia.claude: hoy}), Ia.chatgpt);
    expect(iaElegida(const EstadoIa(), const {}), isNull);
  });

  test('la burbuja abre la IA solo si está conectada y sin ocultar', () {
    expect(iaDeLaBurbuja(const EstadoIa(preferida: Ia.claude), const {}), isNull);
    expect(iaDeLaBurbuja(const EstadoIa(preferida: Ia.claude), {Ia.claude: hoy}), Ia.claude);
    expect(iaDeLaBurbuja(const EstadoIa(preferida: Ia.chatgpt), {Ia.claude: hoy}), isNull);
    expect(iaDeLaBurbuja(const EstadoIa(preferida: Ia.chatgpt, aMano: true), const {}), Ia.chatgpt);
    expect(iaDeLaBurbuja(const EstadoIa(preferida: Ia.claude, burbuja: false), {Ia.claude: hoy}), isNull);
    expect(iaDeLaBurbuja(const EstadoIa(), {Ia.gemini: hoy}), Ia.gemini);
    // Configurada no depende de si se ve la burbuja.
    expect(iaConfigurada(const EstadoIa(preferida: Ia.claude, burbuja: false), {Ia.claude: hoy}), Ia.claude);
    expect(iaConfigurada(const EstadoIa(preferida: Ia.lechat), const {}), isNull);
  });

  test('el estado se guarda y se recupera', () {
    final e = EstadoIa.fromJson(const EstadoIa(preferida: Ia.lechat, aMano: true, burbuja: false).toJson());
    expect((e.preferida, e.aMano, e.burbuja), (Ia.lechat, true, false));
    expect(EstadoIa.fromJson(const {}).burbuja, isTrue);
  });

  test('el mensaje va en el enlace solo si la IA lo admite', () {
    final url = Uri.parse(Ia.claude.urlCon('Duda del tema 3.A.8 («Demanda»): ¿qué es?'));
    expect(url.host, 'claude.ai');
    expect(url.queryParameters['q'], 'Duda del tema 3.A.8 («Demanda»): ¿qué es?');
    expect(Ia.gemini.urlCon('hola'), 'https://gemini.google.com/app');
  });

  test('los mensajes nombran el conector y la oposición', () {
    final m = MensajesIa(Oposiciones.tcee);
    final todos = [m.libre, ...m.inicio(preparador: false).map((a) => a.mensaje), ...m.inicio(preparador: true).map((a) => a.mensaje), ...m.tema('3.A.8', 'Demanda').map((a) => a.mensaje), ...m.resultadoTest.map((a) => a.mensaje), ...m.cronograma.map((a) => a.mensaje), ...m.cantes.map((a) => a.mensaje)];
    for (final t in todos) {
      expect(t, contains('EconomIA'));
      expect(t, contains('Oposición: TCEE'));
    }
    expect(m.tema('3.A.8', 'Demanda').first.mensaje, contains('3.A.8'));
  });
}
