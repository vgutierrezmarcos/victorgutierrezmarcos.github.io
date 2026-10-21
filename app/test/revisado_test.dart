import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/revisado.dart';
import 'package:tcee_app/features/temario/html_revisado.dart';

/// Temario revisado (exclusivo de la app): el manifiesto de la rama
/// revision-temario, qué versión de cada tema se enseña y el HTML adaptado.
void main() {
  const commit = '0ee0c23aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
  const raw = 'https://raw.githubusercontent.com/vgutierrezmarcos/victorgutierrezmarcos.github.io/$commit/';
  const cdn = 'https://cdn.jsdelivr.net/gh/vgutierrezmarcos/victorgutierrezmarcos.github.io@$commit/';

  Map<String, dynamic> tema(String codigo, {bool repaso = true}) {
    final a = codigo.replaceAll('.', '').replaceFirstMapped(RegExp(r'(\d)([A-Z])(\d)$'), (m) => '${m[1]}${m[2]}0${m[3]}');
    final c = 'oposicion/temario/tercer-ejercicio';
    return {
      'codigo': codigo,
      'archivo': a,
      'titulo': 'Título de $codigo',
      'aprobado': '2026-10-17',
      'version': '1a3f226',
      'fecha': '2026-10-17',
      'pdf': {'ruta': '$c/$a.pdf', 'tamano': 1165817, 'sha': 'a9d862314c'},
      'docx': {'ruta': '$c/$a.docx', 'tamano': 2650751, 'sha': '72f35cd400'},
      'html': {'ruta': '$c/$a.html', 'tamano': 294098, 'sha': '7ef8fce1c6', 'graficos': '5095951d4e'},
      if (repaso) 'repaso': {'ruta': '$c/$a-repaso.pdf', 'tamano': 491508, 'sha': '6c08940ca5'},
      if (repaso) 'repasoAprobado': '2026-10-17',
    };
  }

  group('manifiesto', () {
    test('lee los temas con sus ficheros y las bases fijadas al commit', () {
      final m = ManifiestoRevisados.fromJson({
        'rama': 'revision-temario',
        'commit': commit,
        'raw': raw,
        'cdn': cdn,
        'temas': [tema('3.A.12'), tema('3.A.21', repaso: false)],
      });
      expect(m.commit, commit);
      expect(m.temas.keys, ['3.A.12', '3.A.21']);
      final t = m.de('3.A.12')!;
      expect(t.archivo, '3A12');
      expect(t.titulo, 'Título de 3.A.12');
      expect(t.aprobado, DateTime(2026, 10, 17));
      expect(t.version, '1a3f226');
      expect(t.url(t.pdf), '${raw}oposicion/temario/tercer-ejercicio/3A12.pdf');
      expect(t.urlDocumentoHtml, '${cdn}oposicion/temario/tercer-ejercicio/3A12.html');
      expect(t.repaso!.tamano, 491508);
      expect(t.docx!.extension, 'docx');
      expect(m.de('3.A.21')!.repaso, isNull);
      expect(m.de('3.A.1'), isNull);
    });

    test('el nombre local lleva el hash del contenido: si cambia el fichero, cambia el nombre', () {
      final a = TemaRevisado.fromJson(tema('3.A.12'))!;
      final b = TemaRevisado.fromJson({
        ...tema('3.A.12'),
        'pdf': {'ruta': 'oposicion/temario/tercer-ejercicio/3A12.pdf', 'tamano': 1, 'sha': 'ffff000011'},
      })!;
      expect(a.nombreLocal(ClaseFichero.pdf), '3A12-revisado-pdf-a9d862314c.pdf');
      expect(b.nombreLocal(ClaseFichero.pdf), isNot(a.nombreLocal(ClaseFichero.pdf)));
      expect(b.nombreLocal(ClaseFichero.pdf), startsWith(a.prefijoLocal(ClaseFichero.pdf)));
      // Cada clase de fichero tiene su prefijo: borrar las versiones viejas del
      // PDF no toca la ficha de repaso ni el Word.
      expect(a.nombreLocal(ClaseFichero.repaso), '3A12-revisado-repaso-6c08940ca5.pdf');
      expect(a.nombreLocal(ClaseFichero.repaso).startsWith(a.prefijoLocal(ClaseFichero.pdf)), isFalse);
      expect(a.nombreLocal(ClaseFichero.docx), endsWith('.docx'));
      // Nunca colisiona con el PDF de la versión anterior (3A12.pdf).
      expect(a.nombreLocal(ClaseFichero.pdf), isNot('3A12.pdf'));
    });

    test('sin hash del fichero, usa la versión del tema', () {
      final t = TemaRevisado.fromJson({
        'codigo': '3.A.8',
        'version': 'abc1234',
        'pdf': {'ruta': 'oposicion/temario/tercer-ejercicio/3A08.pdf'},
      })!;
      expect(t.archivo, '3A08');
      expect(t.nombreLocal(ClaseFichero.pdf), '3A08-revisado-pdf-abc1234.pdf');
      expect(t.docx, isNull);
      expect(t.html, isNull);
      expect(t.urlDocumentoHtml, isNull);
    });

    test('es tolerante: lo que no se entiende se ignora y lo demás vale', () {
      final m = ManifiestoRevisados.fromJson({
        'temas': [
          tema('3.A.12'),
          {'codigo': '3.A.9'}, // sin PDF
          {'codigo': 'no es un código', 'pdf': {'ruta': 'x.pdf'}},
          {'codigo': '3.A.16', 'pdf': {'ruta': ''}},
          'texto suelto',
          null,
          {
            ...tema('3.A.17'),
            'docx': 'no es un fichero',
            'pdf': {'ruta': '/oposicion/temario/tercer-ejercicio/3A17.pdf', 'tamano': 'mucho', 'sha': '../../x'},
          },
        ],
      });
      expect(m.temas.keys, ['3.A.12', '3.A.17']);
      final t = m.de('3.A.17')!;
      expect(t.docx, isNull);
      expect(t.pdf.ruta, 'oposicion/temario/tercer-ejercicio/3A17.pdf');
      expect(t.pdf.tamano, 0);
      // El hash entra en un nombre de fichero: nada de barras ni puntos.
      expect(t.pdf.sha, 'x');
      // Sin bases en el manifiesto: las de la rama.
      expect(t.url(t.pdf), startsWith('https://raw.githubusercontent.com/vgutierrezmarcos/victorgutierrezmarcos.github.io/revision-temario/'));
      expect(t.urlDocumentoHtml, startsWith('https://cdn.jsdelivr.net/gh/vgutierrezmarcos/victorgutierrezmarcos.github.io@revision-temario/'));
    });

    test('un manifiesto que no vale queda vacío', () {
      expect(ManifiestoRevisados.fromJson(null).isEmpty, isTrue);
      expect(ManifiestoRevisados.fromJson('[]').isEmpty, isTrue);
      expect(ManifiestoRevisados.fromJson({'temas': 'ninguno'}).isEmpty, isTrue);
      expect(ManifiestoRevisados.fromJson({}).isEmpty, isTrue);
    });

    test('solo se aceptan bases https (y se les pone la barra final)', () {
      final m = ManifiestoRevisados.fromJson({
        'raw': 'http://ejemplo.com/',
        'cdn': 'https://cdn.jsdelivr.net/gh/otro@abc',
        'temas': [tema('3.A.12')],
      });
      final t = m.de('3.A.12')!;
      expect(t.url(t.pdf), startsWith('https://raw.githubusercontent.com/'));
      expect(t.urlDocumentoHtml, 'https://cdn.jsdelivr.net/gh/otro@abc/oposicion/temario/tercer-ejercicio/3A12.html');
    });
  });

  group('qué versión se enseña', () {
    final rev = TemaRevisado.fromJson(tema('3.A.12'))!;

    test('sin versión revisada, la de siempre, sin distintivo ni invitación', () {
      for (final sesion in [true, false]) {
        final e = elegirVersion(revisado: null, conSesion: sesion);
        expect(e.version, VersionTema.anterior);
        expect(e.hayRevisada, isFalse);
        expect(e.invitarASesion, isFalse);
        expect(e.puedeCambiar, isFalse);
      }
    });

    test('con sesión, la revisada por defecto', () {
      final e = elegirVersion(revisado: rev, conSesion: true);
      expect(e.esRevisada, isTrue);
      expect(e.hayRevisada, isTrue);
      expect(e.invitarASesion, isFalse);
      expect(e.puedeCambiar, isTrue);
    });

    test('con sesión, la anterior si se pide («Ver versión anterior»)', () {
      final e = elegirVersion(revisado: rev, conSesion: true, pideAnterior: true);
      expect(e.version, VersionTema.anterior);
      expect(e.hayRevisada, isTrue);
      expect(e.puedeCambiar, isTrue);
    });

    test('sin versión anterior, la revisada y sin «Ver versión anterior»', () {
      final e = elegirVersion(revisado: rev, conSesion: true, pideAnterior: true, hayAnterior: false);
      expect(e.esRevisada, isTrue);
      expect(e.puedeCambiar, isFalse);
    });

    test('sin sesión, la anterior con la invitación a entrar, aunque se pida la revisada', () {
      for (final pide in [true, false]) {
        final e = elegirVersion(revisado: rev, conSesion: false, pideAnterior: pide);
        expect(e.version, VersionTema.anterior);
        expect(e.hayRevisada, isTrue);
        expect(e.invitarASesion, isTrue);
        expect(e.puedeCambiar, isFalse);
      }
    });
  });

  group('HTML para la app', () {
    const url = '${cdn}oposicion/temario/tercer-ejercicio/3A12.html';
    const pagina = '''<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="../../../favicon.svg" type="image/svg+xml">
    <link rel="stylesheet" href="../../../styles.css">
    <link rel="stylesheet" href="../../../search-styles.css">
    <link rel="stylesheet" href="../../../cookie-consent.css">
    <link rel="stylesheet" href="../latex/tema.css">
    <link rel="canonical" href="https://www.victorgutierrezmarcos.es/oposicion/temario/tercer-ejercicio/3A12.html">
    <script>window.MathJax = {};</script>
    <script defer src="https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/tex-chtml-full.js"></script>
</head>
<body class="pagina-tema">
    <header class="site-header"><div class="header-content"><p class="site-title"><a href="../../../index.html">Víctor Gutiérrez Marcos</a></p></div></header>
    <nav class="main-nav"><div class="nav-container"><ul class="nav-list"><li><a href="../../../index.html">INICIO</a></li></ul></div></nav>
    <nav class="sub-nav" style="background: x;"><div class="nav-container"><ul><li><a href="../../temario.html">TEMARIO</a></li></ul></div></nav>
    <main class="main-content">
        <div class="tema-layout">
            <aside class="tema-indice"><ul><li><a href="#introducción">Introducción</a></li></ul></aside>
            <article class="tema-documento">
                <nav class="breadcrumb"><a href="../../temario.html">Temario</a></nav>
                <header class="tema-cabecera">
                    <p class="tema-codigo">Tema 3.A.12</p>
                    <div class="tema-descargas">
                        <a href="3A12.pdf" target="_blank">Descargar PDF</a>
                        <div class="dentro">anidado</div>
                    </div>
                </header>
<section id="introducción"><p>Texto <img src="../fuentes/3A12/graficos/mc.svg" style="width:50%"></p></section>
                <footer class="tema-pie">
                    <section class="tema-oposicion"><p>Tienes el resto del <a href="../../temario.html">temario</a>.</p></section>
                    <section class="tema-cita"><p class="tema-licencia">Licencia CC BY-NC-ND 4.0.</p></section>
                </footer>
            </article>
        </div>
    </main>
<footer class="site-footer"><div class="footer-content"><a href="../../../politica-cookies.html">Política de cookies</a></div></footer>
    <script src="../../../search-engine.js"></script>
    <script src="../../../search-ui.js"></script>
    <script src="../../../cookie-consent.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.10.1/firebase-auth.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.10.1/firebase-firestore.js"></script>
    <script src="../../../firebase-config.js"></script>
    <script src="../../../auth.js"></script>
</body>
</html>''';

    final h = prepararHtmlRevisado(pagina, urlDocumento: url);

    test('quita la web: cabecera, menús, migas, pie, descargas y enlaces al resto del sitio', () {
      for (final fuera in ['site-header', 'main-nav', 'sub-nav', 'breadcrumb', 'site-footer', 'tema-descargas', 'tema-oposicion', 'Descargar PDF', 'anidado', 'politica-cookies', 'rel="canonical"', 'favicon']) {
        expect(h, isNot(contains(fuera)), reason: fuera);
      }
    });

    test('quita los scripts del sitio (buscador, cookies y Analytics, Firebase)', () {
      for (final fuera in ['search-engine.js', 'search-ui.js', 'cookie-consent.js', 'firebasejs', 'firebase-config.js', 'auth.js', 'search-styles.css', 'cookie-consent.css']) {
        expect(h, isNot(contains(fuera)), reason: fuera);
      }
    });

    test('deja el tema, las fórmulas, el índice, los gráficos y la licencia', () {
      for (final dentro in ['mathjax@3.2.2', 'window.MathJax', 'tema-indice', 'tema-cabecera', 'Tema 3.A.12', '../fuentes/3A12/graficos/mc.svg', '../latex/tema.css', '../../../styles.css', 'tema-licencia', 'CC BY-NC-ND 4.0', '</html>']) {
        expect(h, contains(dentro), reason: dentro);
      }
    });

    test('<base> con la URL de jsDelivr al principio del <head> y el script de enlaces antes de </body>', () {
      final base = h.indexOf('<base href="$url">');
      expect(base, greaterThan(h.indexOf('<head>')));
      expect(base, lessThan(h.indexOf('<meta charset')));
      expect(h.indexOf('tcee-app-enlaces'), lessThan(h.indexOf('</body>')));
      expect(h.indexOf('id="tcee-app"'), lessThan(h.indexOf('</head>')));
    });

    test('un HTML sin nada de la web no se rompe', () {
      final r = prepararHtmlRevisado('<p>Solo texto</p>', urlDocumento: url);
      expect(r, contains('<p>Solo texto</p>'));
      expect(r, contains('<base href="$url">'));
    });
  });
}
