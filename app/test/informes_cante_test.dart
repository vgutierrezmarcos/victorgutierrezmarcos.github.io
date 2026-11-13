import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/informe_cante.dart';
import 'package:tcee_app/widgets/markdown_simple.dart';

/// Los informes que guarda la IA en el diario y el Markdown con que se leen.
void main() {
  test('el informe dice qué IA lo escribió y se ordena por fecha', () {
    final nuevo = InformeCante.fromJson('a', {
      'fecha': '2026-10-30T18:02:00',
      'origen': 'ia',
      'cliente': 'Le Chat',
      'informe': '# Informe del cante · 3.A.8\n\n**Nota**: 5,8/10',
      'valoracion': 3,
      'valoraciones': {'3.A.8': 3.0},
      'criterios': {'Rigor': 2},
      'tareas': ['Reescribir II.2', {'texto': 'Cronometrar la intro'}],
    });
    final viejo = InformeCante.fromJson('b', {'fecha': '2026-10-20T10:00:00', 'origen': 'claude', 'informe': '\n\n> Bien la intro'});
    final sinFecha = InformeCante.fromJson('c', {'informe': ''});
    expect(nuevo.autor, 'Le Chat');
    expect(viejo.autor, 'Claude');
    expect(sinFecha.autor, 'tu IA');
    expect(nuevo.primeraLinea, 'Informe del cante · 3.A.8');
    expect(viejo.primeraLinea, 'Bien la intro');
    expect(nuevo.valoraciones, {'3.A.8': 3});
    expect(nuevo.tareas, ['Reescribir II.2', 'Cronometrar la intro']);
    expect(InformeCante.ordenar([viejo, sinFecha, nuevo]).map((i) => i.id), ['a', 'b', 'c']);
  });

  test('el Markdown se separa en bloques', () {
    final b = analizarMarkdown('''
# Informe
Primera línea
sigue el párrafo.

- uno
- dos
  con continuación
1. primero
2. segundo

> una cita

| Apartado | Min |
|---|---|
| I.1 | 4 |

---
```
código
```''');
    expect(b.map((x) => x.tipo), [
      TipoBloqueMd.titulo,
      TipoBloqueMd.parrafo,
      TipoBloqueMd.lista,
      TipoBloqueMd.numerada,
      TipoBloqueMd.cita,
      TipoBloqueMd.tabla,
      TipoBloqueMd.separador,
      TipoBloqueMd.codigo,
    ]);
    expect(b[1].lineas.single, 'Primera línea sigue el párrafo.');
    expect(b[2].lineas, ['uno', 'dos con continuación']);
    expect(b[5].lineas, ['| Apartado | Min |', '| I.1 | 4 |']);
    expect(celdasDeFila(b[5].lineas.last), ['I.1', '4']);
    expect(b[7].lineas, ['código']);
  });

  test('negrita, cursiva, código y enlaces en línea', () {
    expect(analizarEnLinea('Un **error de _signo_ grave** en `II.2` y [la guía](https://x.es/g).'), const [
      TrozoMd('Un '),
      TrozoMd('error de ', negrita: true),
      TrozoMd('signo', negrita: true, cursiva: true),
      TrozoMd(' grave', negrita: true),
      TrozoMd(' en '),
      TrozoMd('II.2', codigo: true),
      TrozoMd(' y '),
      TrozoMd('la guía', enlace: 'https://x.es/g'),
      TrozoMd('.'),
    ]);
    // Los guiones bajos dentro de una palabra no son cursiva.
    expect(analizarEnLinea('para_claude_json'), const [TrozoMd('para_claude_json')]);
  });
}
