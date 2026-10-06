import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/features/cantar/reloj_cante.dart';
import 'package:tcee_app/features/cantar/reloj_compartido.dart';

/// El cronómetro de una clase compartido entre el alumno y su preparador.
void main() {
  test('lo que publica uno lo ve el otro con el mismo tiempo', () async {
    final db = FakeFirebaseFirestore();
    for (final op in [Oposiciones.tcee, Oposiciones.dce]) {
      final alumno = RelojCompartido.deClase(db, op, alumnoUid: 'alu', canteId: 'c1', miUid: 'alu', miNombre: 'Ana');
      final preparador = RelojCompartido.deClase(db, op, alumnoUid: 'alu', canteId: 'c1', miUid: 'paula', miNombre: 'Paula');

      final r = RelojCante(preparacion: const Duration(minutes: 45), exposicion: const Duration(minutes: 30));
      r.iniciar(DateTime.now().subtract(const Duration(minutes: 10)));
      await preparador.publicar(r, temas: ['3.A.1', '3.B.2'], elegido: '3.B.2');

      final visto = await alumno.escuchar().firstWhere((e) => e != null);
      expect(visto!.activo, isTrue);
      expect(visto.por, 'paula');
      expect(visto.porNombre, 'Paula');
      expect(visto.temas, ['3.A.1', '3.B.2']);
      expect(visto.elegido, '3.B.2');
      expect(visto.reloj.corriendo, isTrue);
      final ahora = DateTime.now();
      expect((visto.reloj.restanteFase(ahora) - r.restanteFase(ahora)).inSeconds.abs(), lessThanOrEqualTo(2));

      await alumno.dejar();
      final despues = await preparador.escuchar().first;
      expect(despues!.activo, isFalse);
      expect(despues.por, 'alu');
    }
  });
}
