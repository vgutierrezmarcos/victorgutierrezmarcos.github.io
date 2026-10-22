import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/esquema.dart';
import 'package:tcee_app/data/models/revisado.dart';

/// El esquema de un tema (los marcadores de su PDF) y el CDN de los revisados.
void main() {
  test('los esquemas van por nombre de fichero y lo que no se entiende se ignora', () {
    final e = Esquemas.fromJson({
      '3A08.pdf': [
        [0, 'INTRODUCCIÓN', 1],
        [0, '1. ANÁLISIS', 5],
        [1, '1.1. Ingredientes', 5],
        [2, '1.1.1. Conjunto de elección', 6],
        ['mal', 'x', 1],
        [1, '', 7],
        [1, 'Sin página'],
      ],
      '4A01.pdf': [],
      5: [[0, 'raro', 1]],
    });
    expect(e.porFichero.keys, ['3A08.pdf']);
    final l = e.de('https://www.victorgutierrezmarcos.es/oposicion/temario/tercer-ejercicio/3A08.pdf')!;
    expect(l.map((x) => x.titulo), ['INTRODUCCIÓN', '1. ANÁLISIS', '1.1. Ingredientes', '1.1.1. Conjunto de elección']);
    expect(l[2].nivel, 1);
    expect(l[3].pagina, 6);
    expect(e.de('https://www.victorgutierrezmarcos.es/oposicion/temario/cuarto-ejercicio/4A01.pdf'), isNull);
    expect(e.de(null), isNull);
    expect(Esquemas.fromJson('nada').porFichero, isEmpty);
    // La entrada en la que cae cada página: la última que empieza en ella o antes.
    expect(entradaEnPagina(l, 1), 0);
    expect(entradaEnPagina(l, 5), 2);
    expect(entradaEnPagina(l, 40), 3);
    expect(entradaEnPagina(l, 0), -1);
  });

  test('el tema revisado trae su esquema y su CDN es githack fijado al commit (jsDelivr daba 503)', () {
    final m = ManifiestoRevisados.fromJson({
      'commit': '0b1db3dda31df16affec595d4eb7dd2863cd418b',
      'raw': 'https://raw.githubusercontent.com/vgutierrezmarcos/victorgutierrezmarcos.github.io/0b1db3dda31df16affec595d4eb7dd2863cd418b/',
      'cdn': 'https://cdn.jsdelivr.net/gh/vgutierrezmarcos/victorgutierrezmarcos.github.io@0b1db3dda31df16affec595d4eb7dd2863cd418b/',
      'temas': [
        {
          'codigo': '3.A.8',
          'pdf': {'ruta': 'oposicion/temario/tercer-ejercicio/3A08.pdf', 'sha': 'b4557ad195'},
          'html': {'ruta': 'oposicion/temario/tercer-ejercicio/3A08.html', 'sha': 'c1'},
          'esquema': [[0, 'Introducción', 1], [0, 'I. Análisis', 4]],
        },
      ],
    });
    final t = m.temas['3.A.8']!;
    expect(t.urlDocumentoHtml, 'https://rawcdn.githack.com/vgutierrezmarcos/victorgutierrezmarcos.github.io/0b1db3dda31df16affec595d4eb7dd2863cd418b/oposicion/temario/tercer-ejercicio/3A08.html');
    expect(t.url(t.pdf), startsWith('https://raw.githubusercontent.com/'));
    expect(t.esquema.map((e) => e.titulo), ['Introducción', 'I. Análisis']);
    // Sin commit, la rama por githack (nunca jsDelivr).
    final sinCommit = ManifiestoRevisados.fromJson({
      'cdn': 'https://cdn.jsdelivr.net/gh/vgutierrezmarcos/victorgutierrezmarcos.github.io@revision-temario/',
      'temas': [
        {'codigo': '3.A.9', 'pdf': {'ruta': 'p.pdf', 'sha': 'a'}, 'html': {'ruta': 'p.html', 'sha': 'b'}},
      ],
    });
    expect(sinCommit.temas['3.A.9']!.urlDocumentoHtml, 'https://raw.githack.com/vgutierrezmarcos/victorgutierrezmarcos.github.io/revision-temario/p.html');
    expect(sinCommit.temas['3.A.9']!.esquema, isEmpty);
  });
}
