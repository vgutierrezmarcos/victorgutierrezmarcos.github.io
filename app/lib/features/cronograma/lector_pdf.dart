/// Texto de un PDF, sin dependencias nativas: descomprime los flujos
/// (FlateDecode), lee los flujos de objetos (PDF 1.5) y traduce el texto con
/// las tablas ToUnicode de cada fuente. Sirve para los PDF que generan Word,
/// Excel, Google Docs o un navegador; los escaneados (imágenes) no tienen
/// texto. Cada cambio de línea del PDF es un salto de línea.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';

class _Objeto {
  _Objeto(this.dic, [this.flujo]);
  final String dic;
  final Uint8List? flujo;
}

class _Fuente {
  _Fuente(this.mapa, this.bytes);
  final Map<int, String> mapa;
  /// Bytes por código (1 o 2).
  final int bytes;
}

/// Texto de [datos], o null si no es un PDF o no se ha podido leer.
String? textoDePdf(Uint8List datos) {
  try {
    final crudo = latin1.decode(datos, allowInvalid: true);
    if (!crudo.startsWith('%PDF')) return null;
    final objetos = _objetos(datos, crudo);
    final paginas = _paginas(objetos);
    final out = StringBuffer();
    for (final p in paginas) {
      final fuentes = _fuentesDePagina(objetos, p);
      for (final c in _contenidos(objetos, p)) {
        out.write(_textoDeContenido(c, fuentes));
        out.write('\n');
      }
    }
    final texto = out.toString().replaceAll('ﬁ', 'fi').replaceAll('ﬂ', 'fl').replaceAll('ﬀ', 'ff').replaceAll('ﬃ', 'ffi').replaceAll('ﬄ', 'ffl').replaceAll(RegExp(r'[ \t]+\n'), '\n').replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
    return texto.isEmpty ? null : texto;
  } catch (_) {
    return null;
  }
}

// ------------------------------------------------------------------ Objetos

final _reObj = RegExp(r'(\d+)\s+\d+\s+obj\b');

Map<int, _Objeto> _objetos(Uint8List datos, String crudo) {
  final out = <int, _Objeto>{};
  for (final m in _reObj.allMatches(crudo)) {
    final n = int.parse(m[1]!);
    final fin = crudo.indexOf('endobj', m.end);
    if (fin < 0) continue;
    final cuerpo = crudo.substring(m.end, fin);
    final s = cuerpo.indexOf('stream');
    if (s < 0) {
      out[n] = _Objeto(cuerpo);
      continue;
    }
    final dic = cuerpo.substring(0, s);
    var inicio = m.end + s + 6;
    if (crudo.startsWith('\r\n', inicio)) {
      inicio += 2;
    } else if (crudo[inicio] == '\n' || crudo[inicio] == '\r') {
      inicio += 1;
    }
    final largo = RegExp(r'/Length\s+(\d+)(?!\s+\d+\s+R)').firstMatch(dic);
    var finFlujo = largo != null ? inicio + int.parse(largo[1]!) : crudo.indexOf('endstream', inicio);
    if (finFlujo < inicio || finFlujo > datos.length) finFlujo = crudo.indexOf('endstream', inicio);
    if (finFlujo < 0) continue;
    final bytes = Uint8List.sublistView(datos, inicio, finFlujo);
    out[n] = _Objeto(dic, _decodificar(dic, bytes));
  }
  // Objetos guardados dentro de flujos de objetos (/Type /ObjStm).
  for (final o in out.values.toList()) {
    if (!o.dic.contains('/ObjStm') || o.flujo == null) continue;
    final texto = latin1.decode(o.flujo!, allowInvalid: true);
    final primero = int.tryParse(RegExp(r'/First\s+(\d+)').firstMatch(o.dic)?[1] ?? '') ?? 0;
    final pares = RegExp(r'(\d+)\s+(\d+)').allMatches(texto.substring(0, primero)).map((m) => (int.parse(m[1]!), int.parse(m[2]!))).toList();
    for (var i = 0; i < pares.length; i++) {
      final desde = primero + pares[i].$2;
      final hasta = i + 1 < pares.length ? primero + pares[i + 1].$2 : texto.length;
      if (desde <= texto.length && hasta <= texto.length && desde <= hasta) out.putIfAbsent(pares[i].$1, () => _Objeto(texto.substring(desde, hasta)));
    }
  }
  return out;
}

Uint8List _decodificar(String dic, Uint8List bytes) {
  if (!dic.contains('FlateDecode')) return bytes;
  try {
    return Uint8List.fromList(const ZLibDecoder().decodeBytes(bytes));
  } catch (_) {
    try {
      return Uint8List.fromList(Inflate(bytes).getBytes());
    } catch (_) {
      return bytes;
    }
  }
}

int? _ref(String texto, String clave) => int.tryParse(RegExp('/$clave\\s+(\\d+)\\s+\\d+\\s+R').firstMatch(texto)?[1] ?? '');

/// Diccionario (o su referencia) que sigue a /[clave].
String? _dicDe(Map<int, _Objeto> objetos, String texto, String clave) {
  final r = _ref(texto, clave);
  if (r != null) return objetos[r]?.dic;
  final i = texto.indexOf('/$clave');
  if (i < 0) return null;
  final ini = texto.indexOf('<<', i);
  if (ini < 0) return null;
  var nivel = 0;
  for (var j = ini; j < texto.length - 1; j++) {
    if (texto.startsWith('<<', j)) {
      nivel++;
      j++;
    } else if (texto.startsWith('>>', j)) {
      nivel--;
      j++;
      if (nivel == 0) return texto.substring(ini, j + 1);
    }
  }
  return null;
}

// ------------------------------------------------------------------- Páginas

List<_Objeto> _paginas(Map<int, _Objeto> objetos) {
  final out = <_Objeto>[];
  final catalogo = objetos.values.where((o) => RegExp(r'/Type\s*/Catalog').hasMatch(o.dic)).firstOrNull;
  void recorrer(int? n, Set<int> vistos) {
    if (n == null || !vistos.add(n)) return;
    final o = objetos[n];
    if (o == null) return;
    if (RegExp(r'/Type\s*/Page\b(?!s)').hasMatch(o.dic)) {
      out.add(o);
      return;
    }
    final kids = RegExp(r'/Kids\s*\[([^\]]*)\]').firstMatch(o.dic)?[1] ?? '';
    for (final k in RegExp(r'(\d+)\s+\d+\s+R').allMatches(kids)) {
      recorrer(int.parse(k[1]!), vistos);
    }
  }

  if (catalogo != null) recorrer(_ref(catalogo.dic, 'Pages'), {});
  if (out.isEmpty) {
    final claves = objetos.keys.toList()..sort();
    out.addAll([for (final k in claves) if (RegExp(r'/Type\s*/Page\b(?!s)').hasMatch(objetos[k]!.dic)) objetos[k]!]);
  }
  return out;
}

List<Uint8List> _contenidos(Map<int, _Objeto> objetos, _Objeto pagina) {
  final arr = RegExp(r'/Contents\s*\[([^\]]*)\]').firstMatch(pagina.dic);
  final unica = _ref(pagina.dic, 'Contents');
  final refs = arr != null ? RegExp(r'(\d+)\s+\d+\s+R').allMatches(arr[1]!).map((m) => int.parse(m[1]!)).toList() : [if (unica != null) unica];
  return [for (final r in refs) if (objetos[r]?.flujo != null) objetos[r]!.flujo!];
}

Map<String, _Fuente> _fuentesDePagina(Map<int, _Objeto> objetos, _Objeto pagina) {
  final recursos = _dicDe(objetos, pagina.dic, 'Resources') ?? '';
  final fuentes = _dicDe(objetos, recursos, 'Font') ?? '';
  final out = <String, _Fuente>{};
  for (final m in RegExp(r'/([^\s/<>\[\]()]+)\s+(\d+)\s+\d+\s+R').allMatches(fuentes)) {
    final f = objetos[int.parse(m[2]!)];
    if (f == null) continue;
    final tu = _ref(f.dic, 'ToUnicode');
    final cmap = tu == null ? null : objetos[tu]?.flujo;
    final compuesta = f.dic.contains('/Type0') || f.dic.contains('Identity-H');
    out[m[1]!] = cmap == null ? _Fuente(const {}, compuesta ? 2 : 1) : _leerCMap(latin1.decode(cmap, allowInvalid: true), compuesta ? 2 : 1);
  }
  return out;
}

_Fuente _leerCMap(String t, int porDefecto) {
  final mapa = <int, String>{};
  int hex(String h) => int.parse(h, radix: 16);
  String uni(String h) {
    final codigos = <int>[];
    for (var i = 0; i + 4 <= h.length; i += 4) {
      codigos.add(hex(h.substring(i, i + 4)));
    }
    if (h.length == 2) codigos.add(hex(h));
    return String.fromCharCodes(codigos);
  }

  var bytes = porDefecto;
  final espacio = RegExp(r'begincodespacerange\s*<([0-9A-Fa-f]+)>').firstMatch(t);
  if (espacio != null) bytes = espacio[1]!.length ~/ 2;
  for (final b in RegExp(r'beginbfchar(.*?)endbfchar', dotAll: true).allMatches(t)) {
    for (final m in RegExp(r'<([0-9A-Fa-f]+)>\s*<([0-9A-Fa-f]*)>').allMatches(b[1]!)) {
      mapa[hex(m[1]!)] = uni(m[2]!);
    }
  }
  for (final b in RegExp(r'beginbfrange(.*?)endbfrange', dotAll: true).allMatches(t)) {
    for (final m in RegExp(r'<([0-9A-Fa-f]+)>\s*<([0-9A-Fa-f]+)>\s*(<([0-9A-Fa-f]+)>|\[([^\]]*)\])').allMatches(b[1]!)) {
      final desde = hex(m[1]!);
      final hasta = hex(m[2]!);
      if (hasta - desde > 5000) continue;
      if (m[4] != null) {
        final base = uni(m[4]!);
        final ultimo = base.codeUnitAt(base.length - 1);
        for (var c = desde; c <= hasta; c++) {
          mapa[c] = base.substring(0, base.length - 1) + String.fromCharCode(ultimo + c - desde);
        }
      } else {
        final lista = RegExp(r'<([0-9A-Fa-f]+)>').allMatches(m[5]!).map((x) => uni(x[1]!)).toList();
        for (var c = desde; c <= hasta && c - desde < lista.length; c++) {
          mapa[c] = lista[c - desde];
        }
      }
    }
  }
  return _Fuente(mapa, bytes);
}

// ------------------------------------------------------------- Contenido

String _textoDeContenido(Uint8List c, Map<String, _Fuente> fuentes) {
  final t = latin1.decode(c, allowInvalid: true);
  final out = StringBuffer();
  final pila = <Object>[];
  _Fuente? fuente;
  double? yAnterior;

  String decodificar(List<int> bytes) {
    final f = fuente;
    if (f == null || f.mapa.isEmpty) {
      return f != null && f.bytes == 2 ? '' : String.fromCharCodes(bytes);
    }
    final s = StringBuffer();
    for (var i = 0; i + f.bytes <= bytes.length; i += f.bytes) {
      final code = f.bytes == 2 ? (bytes[i] << 8) | bytes[i + 1] : bytes[i];
      s.write(f.mapa[code] ?? (f.bytes == 1 ? String.fromCharCode(code) : ''));
    }
    return s.toString();
  }

  void nuevaLinea(double y) {
    if (yAnterior != null && (y - yAnterior!).abs() > 1) out.write('\n');
    yAnterior = y;
  }

  double num(int desdeElFinal) {
    final v = pila.length >= desdeElFinal ? pila[pila.length - desdeElFinal] : 0;
    return v is double ? v : 0;
  }

  var i = 0;
  while (i < t.length) {
    final ch = t[i];
    if (ch == '(') {
      // Cadena literal, con paréntesis anidados y escapes.
      final bytes = <int>[];
      var nivel = 1;
      i++;
      while (i < t.length && nivel > 0) {
        final c = t[i];
        if (c == '\\' && i + 1 < t.length) {
          final n = t[i + 1];
          const esc = {'n': 10, 'r': 13, 't': 9, 'b': 8, 'f': 12, '(': 40, ')': 41, '\\': 92};
          if (esc.containsKey(n)) {
            bytes.add(esc[n]!);
            i += 2;
          } else if (RegExp(r'[0-7]').hasMatch(n)) {
            var j = i + 1;
            var oct = '';
            while (j < t.length && oct.length < 3 && RegExp(r'[0-7]').hasMatch(t[j])) {
              oct += t[j];
              j++;
            }
            bytes.add(int.parse(oct, radix: 8) & 0xFF);
            i = j;
          } else {
            i += 2;
          }
          continue;
        }
        if (c == '(') nivel++;
        if (c == ')') {
          nivel--;
          if (nivel == 0) break;
        }
        bytes.add(c.codeUnitAt(0) & 0xFF);
        i++;
      }
      i++;
      pila.add(bytes);
    } else if (t.startsWith('<<', i) || t.startsWith('>>', i)) {
      // Diccionarios en línea (contenido marcado): sus valores no son texto.
      i += 2;
    } else if (ch == '<') {
      final fin = t.indexOf('>', i);
      final h = t.substring(i + 1, fin < 0 ? t.length : fin).replaceAll(RegExp(r'\s'), '');
      final bytes = <int>[for (var k = 0; k + 1 < h.length + (h.length.isOdd ? 1 : 0); k += 2) int.parse((h.length.isOdd && k == h.length - 1) ? '${h[k]}0' : h.substring(k, k + 2), radix: 16)];
      pila.add(bytes);
      i = fin < 0 ? t.length : fin + 1;
    } else if (ch == '[') {
      pila.add('[');
      i++;
    } else if (ch == ']') {
      final elementos = <Object>[];
      while (pila.isNotEmpty && pila.last != '[') {
        elementos.insert(0, pila.removeLast());
      }
      if (pila.isNotEmpty) pila.removeLast();
      pila.add(elementos);
      i++;
    } else if (ch == '/') {
      var j = i + 1;
      while (j < t.length && !RegExp(r'[\s/\[\]()<>{}%]').hasMatch(t[j])) {
        j++;
      }
      pila.add(_Nombre(t.substring(i + 1, j)));
      i = j;
    } else if (ch == '%') {
      final fin = t.indexOf('\n', i);
      i = fin < 0 ? t.length : fin + 1;
    } else if (RegExp(r'[\d.+\-]').hasMatch(ch)) {
      var j = i + 1;
      while (j < t.length && RegExp(r'[\d.]').hasMatch(t[j])) {
        j++;
      }
      pila.add(double.tryParse(t.substring(i, j)) ?? 0.0);
      i = j;
    } else if (RegExp(r'[A-Za-z\x27"*]').hasMatch(ch)) {
      var j = i + 1;
      while (j < t.length && RegExp(r'[A-Za-z*\x27"0-9]').hasMatch(t[j])) {
        j++;
      }
      final op = t.substring(i, j);
      i = j;
      switch (op) {
        case 'Tf':
          final nombre = pila.length >= 2 ? pila[pila.length - 2] : null;
          if (nombre is _Nombre) fuente = fuentes[nombre.n];
        case 'Td' || 'TD':
          // Solo los saltos de línea; los espacios entre palabras van en el texto.
          if (num(1) != 0) {
            out.write('\n');
            yAnterior = null;
          }
        case 'Tm':
          nuevaLinea(num(1));
        case 'T*':
          out.write('\n');
        case 'Tj' || "'" || '"':
          if (op != 'Tj') out.write('\n');
          final s = pila.isNotEmpty ? pila.last : null;
          if (s is List<int>) out.write(decodificar(s));
        case 'TJ':
          final a = pila.isNotEmpty ? pila.last : null;
          if (a is List<Object>) {
            for (final e in a) {
              if (e is List<int>) out.write(decodificar(e));
              if (e is double && e < -200) out.write(' ');
            }
          }
        case 'ET':
          out.write(' ');
        case 'BI':
          // Imagen en línea: hasta EI.
          final fin = t.indexOf('EI', i);
          i = fin < 0 ? t.length : fin + 2;
      }
      pila.clear();
    } else {
      i++;
    }
  }
  return out.toString();
}

class _Nombre {
  const _Nombre(this.n);
  final String n;
}
