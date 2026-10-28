import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/preparador.dart';
import 'package:tcee_app/data/models/temas_clase.dart';
import 'package:tcee_app/data/repos/red_repo.dart';

/// Avisos de la actividad de un alumno (avisosDeActividad, red_repo.dart):
/// solo lo que el alumno comparte y el preparador quiere.
void main() {
  final ahora = DateTime(2026, 10, 28, 12);
  final reciente = ahora.subtract(const Duration(days: 2));
  final clase = Cante(id: 's1', fecha: DateTime(2026, 10, 30, 18), alumno: 'a1', updatedAt: ahora);
  final temas = {'s1': TemasClase(temas: const ['3.A.12', '3.B.5'], fecha: DateTime(2026, 10, 30))};
  final cantePropio = Cante(id: 'c1', fecha: DateTime(2026, 10, 27, 10), estado: EstadoCante.hecho, resultado: const ResultadoCante(valoracion: 2, comentarios: 'Me lié con el gráfico'), temas: const ['3.A.7'], updatedAt: DateTime(2026, 10, 27, 11));
  const todo = {'temas', 'cantes', 'estudiados', 'uso', 'examen'};
  const quiereTodo = PerfilPreparador(avisoCantesPropios: true, avisoEstudiados: true, avisoInactividad: true);

  List<AvisoRed> avisos({Set<String> compartido = todo, PerfilPreparador perfil = quiereTodo, Set<String>? antes, bool verPropios = true}) => avisosDeActividad(
        alumno: 'alu',
        nombre: 'Ana',
        perfil: perfil,
        compartido: compartido,
        temasClases: temas,
        misClases: [clase],
        cantesAlumno: [cantePropio],
        verCantesPropios: verPropios,
        estudiados: const {'3.A.1', '3.A.2', '3.A.3'},
        estudiadosAntes: antes,
        ultimoUso: '2026-10-18',
        fechaExamen: DateTime(2026, 11, 20),
        ahora: ahora,
        reciente: reciente,
      );

  test('sin nada compartido no hay avisos, aunque el preparador los quiera todos', () {
    expect(avisos(compartido: const {}), isEmpty);
  });

  test('con todo compartido y querido salen los cinco, con sus textos', () {
    final a = avisos(antes: const {'3.A.1'});
    expect(a.map((x) => x.id.split(':').first).toList(), ['temas', 'cante-propio', 'estudiados', 'inactivo', 'examen']);
    expect(a[0].titulo, 'Ana ha fijado los temas de la clase del 30/10');
    expect(a[0].texto, '3.A.12, 3.B.5');
    expect(a[0].ruta, '/clase?id=s1');
    expect(a[1].titulo, 'Ana ha cantado 3.A.7 por su cuenta');
    expect(a[1].texto, '2 de 5 estrellas · Me lié con el gráfico');
    expect(a[2].titulo, 'Ana ha marcado 2 temas más como estudiados');
    expect(a[2].texto, '3.A.2, 3.A.3 · 3 en total');
    expect(a[3].titulo, 'Ana lleva 10 días sin usar la app');
    expect(a[4].titulo, 'A Ana le quedan 23 días para el examen');
    expect(a[4].id, 'examen:alu:30');
  });

  test('los interruptores del preparador apagados por defecto callan cantes, estudiados e inactividad', () {
    final a = avisos(perfil: const PerfilPreparador(), antes: const {});
    expect(a.map((x) => x.id.split(':').first).toList(), ['temas', 'examen']);
  });

  test('cada tipo depende de lo que comparte el alumno', () {
    expect(avisos(compartido: const {'cantes'}, antes: const {}).single.id, 'cante-propio:alu:c1');
    expect(avisos(compartido: const {'uso'}).single.id, 'inactivo:alu:2026-42');
    // Los cantes por su cuenta también exigen que comparta sus cantes (Qué ven tus preparadores).
    expect(avisos(compartido: const {'cantes'}, verPropios: false), isEmpty);
  });

  test('estudiados: sin instantánea anterior no se avisa; sin temas nuevos, tampoco', () {
    expect(avisos(compartido: const {'estudiados'}), isEmpty);
    expect(avisos(compartido: const {'estudiados'}, antes: const {'3.A.1', '3.A.2', '3.A.3', '3.B.9'}), isEmpty);
  });

  test('examen: 7 días o menos, 30 o menos, y nada después', () {
    AvisoRed? examen(DateTime f) => avisosDeActividad(alumno: 'alu', nombre: '', perfil: quiereTodo, compartido: const {'examen'}, fechaExamen: f, ahora: ahora, reciente: reciente).firstOrNull;
    expect(examen(DateTime(2026, 10, 29))!.id, 'examen:alu:7');
    expect(examen(DateTime(2026, 10, 29))!.titulo, 'A Tu alumno le queda 1 día para el examen');
    expect(examen(DateTime(2026, 11, 27))!.id, 'examen:alu:30');
    expect(examen(DateTime(2026, 11, 28)), isNull);
    expect(examen(DateTime(2026, 10, 20)), isNull);
  });
}
