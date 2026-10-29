import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/pregunta.dart';
import 'package:tcee_app/data/models/resultado.dart';
import 'package:tcee_app/data/models/preparador.dart';
import 'package:tcee_app/features/preparador/deberes.dart';

/// Deberes para la próxima clase: el modelo, las etiquetas y el tachado automático.
void main() {
  final ayer = DateTime(2026, 10, 27, 20);
  final hoy = DateTime(2026, 10, 28, 12);
  final clase = DateTime(2026, 10, 30, 18);
  Tarea t(String id, String tipo, {String? tema, int preguntas = 0, String texto = ''}) => Tarea(id: id, tipo: tipo, tema: tema, preguntas: preguntas, texto: texto, creada: ayer);
  Cante conDeberes(List<Tarea> tareas) => Cante(id: 's1', fecha: clase, preparador: 'prep', preparadorNombre: 'Paula', tareas: tareas, updatedAt: ayer);

  test('las tareas van y vuelven del JSON y se etiquetan', () {
    final c = conDeberes([t('a', 'estudiar', tema: '3.A.12'), t('b', 'test', tema: '3.B.5', preguntas: 30), t('c', 'libre', texto: 'Repasa Mundell-Fleming'), t('d', 'esquema', tema: '3.A.1'), t('e', 'cantar', tema: '3.A.2')]);
    final v = Cante.fromJson(c.toJson());
    expect(v.tareas.map((x) => x.id), ['a', 'b', 'c', 'd', 'e']);
    expect(v.tareas[0].etiqueta(tituloDe: (x) => 'Título'), 'Estudiar 3.A.12 · Título');
    expect(v.tareas[1].etiqueta(), 'Test de 30 preguntas de 3.B.5');
    expect(v.tareas[2].etiqueta(), 'Repasa Mundell-Fleming');
    expect(v.tareas[3].etiqueta(), 'Esquema a ciegas de 3.A.1');
    expect(v.tareas[4].etiqueta(), 'Cantar 3.A.2 por tu cuenta');
    expect(v.tareasHechas, 0);
    expect(Cante.fromJson({...c.toJson()}..remove('tareas')).tareas, isEmpty);
    // Una tarea de un tipo desconocido (versión futura) se ignora.
    expect(Tarea.listaDeJson([{'id': 'x', 'tipo': 'rara', 'creada': ayer.toIso8601String()}]), isEmpty);
    expect(informeCante(c), contains('Deberes: Estudiar 3.A.12; Test de 30 preguntas de 3.B.5;'));
  });

  test('se tachan solas: estudiar, esquema, cantar y test (después de ponerlas)', () {
    final c = conDeberes([t('a', 'estudiar', tema: '3.A.12'), t('b', 'esquema', tema: '3.A.1'), t('c', 'cantar', tema: '3.A.2'), t('d', 'test', tema: '3.B.5', preguntas: 30), t('e', 'libre', texto: 'Algo'), t('f', 'cantar', tema: '3.A.9')]);
    Cante hecho(String id, String tema, {bool esquema = false, DateTime? fecha}) => Cante(id: id, fecha: fecha ?? hoy, estado: EstadoCante.hecho, esquema: esquema, resultado: ResultadoCante(temaCantado: tema, valoracion: 3), updatedAt: hoy);
    final test = ResultadoTest(id: 'r', timestamp: hoy, puntosBrutos: 0, maxPuntos: 0, notaSobre10: 5, correctas: 15, incorrectas: 15, sinResponder: 0, totalPreguntas: 30, tiempoSeconds: 0, temas: const ['3.B.5']);
    final cambiadas = tacharDeberes(
      [c],
      estudiados: const {'3.A.12'},
      cantes: [hecho('e1', '3.A.1', esquema: true), hecho('c1', '3.A.2'), hecho('viejo', '3.A.9', fecha: ayer.subtract(const Duration(days: 1)))],
      tests: [test],
      ahora: hoy,
    );
    final tareas = {for (final x in cambiadas.single.tareas) x.id: x.hecha};
    expect(tareas, {'a': true, 'b': true, 'c': true, 'd': true, 'e': false, 'f': false}, reason: 'la libre no se tacha sola; el cante anterior a la tarea no cuenta');
    expect(cambiadas.single.tareas.first.hechaEn, hoy);
    // Sin cambios no devuelve nada; un test más corto o de repaso no vale.
    expect(tacharDeberes([c], estudiados: const {}, tests: [ResultadoTest(id: 'r2', timestamp: hoy, puntosBrutos: 0, maxPuntos: 0, notaSobre10: 5, correctas: 5, incorrectas: 5, sinResponder: 0, totalPreguntas: 10, tiempoSeconds: 0, temas: const ['3.B.5'])]), isEmpty);
    // Un test de todo el temario cuenta para el tema si lleva 3 preguntas suyas (con el banco).
    Pregunta p(int id, String tema) => Pregunta(id: id, examen: 'E', numero: id, temas: [tema], enunciado: 'P', opciones: const {'a': 'A', 'b': 'B'}, respuesta: const ['a'], oficial: true);
    final banco = BancoPreguntas(preguntas: [for (var i = 1; i <= 40; i++) p(i, i <= 3 ? '3.B.5' : '3.A.1')], examenes: const [], temas: const {});
    final general = ResultadoTest(id: 'r3', timestamp: hoy, puntosBrutos: 0, maxPuntos: 0, notaSobre10: 5, correctas: 20, incorrectas: 20, sinResponder: 0, totalPreguntas: 40, tiempoSeconds: 0, temas: const [], respuestas: {for (var i = 1; i <= 40; i++) i: 'a'});
    final soloTest = conDeberes([t('d', 'test', tema: '3.B.5', preguntas: 30)]);
    expect(tacharDeberes([soloTest], estudiados: const {}, tests: [general], banco: banco, ahora: hoy).single.tareas.single.hecha, isTrue);
    expect(tacharDeberes([soloTest], estudiados: const {}, tests: [general], ahora: hoy), isEmpty, reason: 'sin banco no se sabe de qué temas era');
  });

  test('sin otra clase programada, los deberes de la última valen «para la próxima»', () {
    final hecha = conDeberes([t('a', 'libre', texto: 'Repasa')]).copyWith(estado: EstadoCante.hecho);
    expect(deberesParaLaProxima([hecha], clase.add(const Duration(days: 2)))?.id, 's1');
    // En cuanto hay otra clase pendiente con preparador, ya no.
    final otra = Cante(id: 's2', fecha: clase.add(const Duration(days: 7)), preparador: 'prep', updatedAt: ayer);
    expect(deberesParaLaProxima([hecha, otra], clase.add(const Duration(days: 2))), isNull);
    // Ni si son viejos.
    expect(deberesParaLaProxima([hecha], clase.add(const Duration(days: 40))), isNull);
  });
}
