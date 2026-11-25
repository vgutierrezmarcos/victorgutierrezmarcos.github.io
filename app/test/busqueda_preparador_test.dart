import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/red.dart';

/// Emparejamiento opositor-preparador (25/11/2026): presentación opcional y
/// «prefiero presencial, pero acepto online».
void main() {
  const soloOnline = PreparadorVerificado(uid: 'p1', nombre: 'Online', modalidad: 'online');
  const presencialMadrid = PreparadorVerificado(uid: 'p2', nombre: 'Madrid', modalidad: 'presencial', ciudad: 'Madrid');

  test('solo presencial no encaja con quien solo da online; con «acepto online», sí, algo por debajo', () {
    const solo = Busqueda(id: 'b', alumno: 'a', modalidad: Modalidad.presencial, ciudad: 'Sevilla');
    const flexible = Busqueda(id: 'b', alumno: 'a', modalidad: Modalidad.presencial, ciudad: 'Sevilla', aceptaOnline: true);
    const online = Busqueda(id: 'b', alumno: 'a', modalidad: Modalidad.online);
    expect(compatibilidad(solo, soloOnline), 0);
    expect(compatibilidad(flexible, soloOnline), greaterThan(0));
    expect(compatibilidad(flexible, soloOnline), lessThan(compatibilidad(online, soloOnline)));
  });

  test('la ciudad se compara sin mayúsculas, tildes ni «capital»', () {
    const b = Busqueda(id: 'b', alumno: 'a', modalidad: Modalidad.presencial, ciudad: 'MADRID capital');
    expect(compatibilidad(b, presencialMadrid), greaterThan(0));
    expect(esMadrid(' madrid '), isTrue);
    expect(ciudadBonita('  san   sebastián '), 'San Sebastián');
  });

  test('la presentación va y vuelve por JSON y se resume en etiquetas', () {
    const b = Busqueda(
      id: 'b', alumno: 'a', modalidad: Modalidad.presencial, ciudad: 'Madrid', aceptaOnline: true,
      perfil: PerfilBusqueda(vuelta: 'segunda', aprobados: [1], convocatorias: 1, formacion: 'economia', dedicacion: 'compagina', preparadorAntes: false),
    );
    final j = b.toJson();
    expect(j['aceptaOnline'], isTrue);
    final otra = Busqueda.fromJson(j);
    expect(otra.aceptaOnline, isTrue);
    expect(otra.soloPresencial, isFalse);
    expect(otra.perfil.etiquetas, ['Segunda vuelta', 'Aprobado 1.º', '1 convocatoria antes', 'Formación: Economía', 'Compagino con trabajo', 'Sin preparador antes']);
    expect(otra.textoModalidad, 'Presencial en Madrid (acepta online)');
    // Sin presentación no se guarda el campo (las búsquedas de antes siguen igual).
    expect(const Busqueda(id: 'b', alumno: 'a').toJson().containsKey('perfil'), isFalse);
    expect(PerfilBusqueda.fromJson({'vuelta': 'inventada'}).vuelta, '');
  });
}
