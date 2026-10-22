import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// En la versión web (dart2js) un desplazamiento de 31 bits o más devuelve 0:
/// `1 << 32` dejó a `nuevoId()` lanzando un RangeError y sin poder crear
/// cronogramas, clases ni cantes en el navegador (1.17.7). Aquí no hay web
/// con la que probarlo, así que se vigila en el código.
void main() {
  test('ningún desplazamiento de 31 bits o más en lib/', () {
    final re = RegExp(r'<<\s*(\d+)');
    final malos = <String>[];
    final ficheros = Directory('lib').listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));
    for (final f in ficheros) {
      final lineas = f.readAsLinesSync();
      for (var i = 0; i < lineas.length; i++) {
        final l = lineas[i].trim();
        if (l.startsWith('//')) continue;
        for (final m in re.allMatches(l)) {
          if (int.parse(m.group(1)!) >= 31) malos.add('${f.path}:${i + 1}: $l');
        }
      }
    }
    expect(malos, isEmpty, reason: 'En la web `1 << 32` es 0: escribe el número (p. ej. 1073741824 = 2^30) o usa menos bits.');
  });
}
