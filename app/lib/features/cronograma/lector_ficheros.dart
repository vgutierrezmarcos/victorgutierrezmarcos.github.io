/// Lee un fichero de cronograma (Excel, Word, PDF, CSV o texto) y lo pasa al
/// intérprete. Puro Dart: sirve igual en el móvil y en el navegador.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';

import 'interprete_cronograma.dart';
import 'lector_pdf.dart';

/// Extensiones que se pueden elegir al importar.
const extensionesCronograma = ['xlsx', 'docx', 'pdf', 'csv', 'txt'];

/// Cronograma de un fichero, o null si no se ha podido abrir.
CronogramaLeido? leerFicheroCronograma(String nombre, Uint8List bytes, {required Set<String> codigos, int? ejercicioPorDefecto, DateTime? hoy}) {
  final ext = nombre.split('.').last.toLowerCase();
  try {
    switch (ext) {
      case 'xlsx' || 'xlsm':
        return interpretarTabla(filasDeExcel(bytes), codigos: codigos, ejercicioPorDefecto: ejercicioPorDefecto, hoy: hoy);
      case 'docx':
        return interpretarCronograma(textoDeDocx(bytes), codigos: codigos, ejercicioPorDefecto: ejercicioPorDefecto, hoy: hoy);
      case 'pdf':
        final t = textoDePdf(bytes);
        return t == null ? null : interpretarCronograma(t, codigos: codigos, ejercicioPorDefecto: ejercicioPorDefecto, hoy: hoy);
      default:
        return interpretarCronograma(textoPlano(bytes), codigos: codigos, ejercicioPorDefecto: ejercicioPorDefecto, hoy: hoy);
    }
  } catch (_) {
    return null;
  }
}

/// Filas de todas las hojas de un Excel (.xlsx), con las fechas como
/// «aaaa-mm-dd». Lee el XML del libro directamente: textos compartidos,
/// números y fechas (números con formato de fecha).
List<List<String>> filasDeExcel(Uint8List bytes) {
  final zip = ZipDecoder().decodeBytes(bytes);
  String? leer(String ruta) {
    final f = zip.findFile(ruta);
    return f == null ? null : utf8.decode(f.content as List<int>, allowMalformed: true);
  }

  String sinEtiquetas(String x) => _entidades(x.replaceAll(RegExp(r'<[^>]+>'), ''));
  final compartidos = [
    for (final m in RegExp(r'<si>(.*?)</si>', dotAll: true).allMatches(leer('xl/sharedStrings.xml') ?? ''))
      sinEtiquetas(RegExp(r'<t[^>]*>(.*?)</t>', dotAll: true).allMatches(m[1]!).map((t) => t[1]!).join()),
  ];
  // Estilos con formato de fecha: los de fábrica (14–22, 45–47) y los propios con d, m o y.
  final estilos = leer('xl/styles.xml') ?? '';
  final propios = {
    for (final m in RegExp(r'<numFmt\s+numFmtId="(\d+)"\s+formatCode="([^"]*)"').allMatches(estilos))
      int.parse(m[1]!): RegExp(r'[dDyY]|mm?[^:]').hasMatch(m[2]!.replaceAll(RegExp(r'\[[^\]]*\]|"[^"]*"'), '')),
  };
  final xfs = RegExp(r'<cellXfs[^>]*>(.*?)</cellXfs>', dotAll: true).firstMatch(estilos)?[1] ?? '';
  final esFecha = [
    for (final m in RegExp(r'<xf\b[^>]*?numFmtId="(\d+)"').allMatches(xfs))
      () {
        final id = int.parse(m[1]!);
        return (id >= 14 && id <= 22) || (id >= 45 && id <= 47) || (propios[id] ?? false);
      }(),
  ];
  String fecha(double serie) {
    final d = DateTime.utc(1899, 12, 30).add(Duration(days: serie.floor()));
    return '${d.year}-${d.month}-${d.day}';
  }

  int columna(String ref) {
    var n = 0;
    for (final c in RegExp(r'^[A-Z]+').firstMatch(ref)![0]!.codeUnits) {
      n = n * 26 + c - 64;
    }
    return n - 1;
  }

  final hojas = zip.files.where((f) => RegExp(r'^xl/worksheets/sheet\d+\.xml$').hasMatch(f.name)).toList()
    ..sort((a, b) => int.parse(RegExp(r'\d+').firstMatch(a.name.split('/').last)![0]!).compareTo(int.parse(RegExp(r'\d+').firstMatch(b.name.split('/').last)![0]!)));
  final filas = <List<String>>[];
  for (final h in hojas) {
    final xml = utf8.decode(h.content as List<int>, allowMalformed: true);
    for (final f in RegExp(r'<row\b[^>]*>(.*?)</row>', dotAll: true).allMatches(xml)) {
      final fila = <String>[];
      for (final c in RegExp(r'<c\b([^>]*?)(?:/>|>(.*?)</c>)', dotAll: true).allMatches(f[1]!)) {
        final attrs = c[1]!;
        final ref = RegExp(r'\br="([A-Z]+\d+)"').firstMatch(attrs)?[1];
        final tipo = RegExp(r'\bt="(\w+)"').firstMatch(attrs)?[1];
        final estilo = int.tryParse(RegExp(r'\bs="(\d+)"').firstMatch(attrs)?[1] ?? '');
        final cuerpo = c[2] ?? '';
        final v = RegExp(r'<v>(.*?)</v>', dotAll: true).firstMatch(cuerpo)?[1];
        final valor = switch (tipo) {
          's' => v == null ? '' : (compartidos.elementAtOrNull(int.parse(v)) ?? ''),
          'inlineStr' => sinEtiquetas(cuerpo),
          'str' || 'e' || 'b' => _entidades(v ?? ''),
          _ => v == null ? '' : (estilo != null && estilo < esFecha.length && esFecha[estilo] && double.tryParse(v) != null ? fecha(double.parse(v)) : v),
        };
        if (ref != null) {
          while (fila.length < columna(ref)) {
            fila.add('');
          }
        }
        fila.add(valor);
      }
      filas.add(fila);
    }
  }
  return filas;
}

String _entidades(String x) => x.replaceAll('&lt;', '<').replaceAll('&gt;', '>').replaceAll('&quot;', '"').replaceAll('&apos;', "'").replaceAll('&amp;', '&');

/// Texto de un Word (.docx): cada párrafo, una línea; cada fila de una tabla,
/// una línea con sus celdas separadas.
String textoDeDocx(Uint8List bytes) {
  final zip = ZipDecoder().decodeBytes(bytes);
  final doc = zip.findFile('word/document.xml');
  if (doc == null) return '';
  final xml = utf8.decode(doc.content as List<int>, allowMalformed: true);
  return _entidades(xml
      .replaceAll(RegExp(r'</w:p>\s*</w:tc>'), '   ')
      .replaceAll('</w:tr>', '\n')
      .replaceAll('</w:p>', '\n')
      .replaceAll(RegExp(r'<w:tab\s*/>'), ' ')
      .replaceAll(RegExp(r'<w:br\s*/>'), '\n')
      .replaceAll(RegExp(r'<[^>]+>'), ''));
}

/// Texto plano o CSV: UTF-8 y, si no lo es, Latin-1 (Excel en Windows).
String textoPlano(Uint8List bytes) {
  final t = utf8.decode(bytes, allowMalformed: true);
  return t.contains('�') ? latin1.decode(bytes, allowInvalid: true) : t;
}
