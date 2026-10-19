import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfx/pdfx.dart';

import '../../data/models/oposicion.dart';
import '../cantar/pizarra_compartida.dart';
import '../cantar/pizarra_tinta.dart';
import '../cantar/pizarra_trazos.dart';

/// Anotaciones (bolígrafo y fosforito) sobre el PDF de un tema.
///
/// Se guardan en la cuenta, como la pizarra: una página del tema por
/// documento, en `anotaciones/{tema}/paginas/p{n}` dentro de los datos del
/// usuario (de la oposición), con los trazos en la lista `trazos`. Las reglas
/// ya dejan a cada usuario leer y escribir todo lo suyo. Cada página del tema
/// mide [anchoPaginaAnotada] unidades de ancho (y lo que toque de alto), así
/// que se ven igual en el móvil, la tableta y el ordenador.

const anchoPaginaAnotada = 1000;

/// Grosores del bolígrafo y del fosforito sobre el tema (fino, medio, grueso).
const grosoresAnotacion = {
  herramientaBoligrafo: [2, 3, 5],
  herramientaFosforito: [12, 18, 26],
};

/// Colores a un toque: los del bolígrafo y los del fosforito.
const coloresBoligrafo = [0xFF1F1F1F, 0xFF1E5AA8, 0xFFC62828, 0xFF2E7D32];
const nombresBoligrafo = ['Negro', 'Azul', 'Rojo', 'Verde'];
const coloresFosforito = [0xFFFFE34D, 0xFF9BE37A, 0xFFFF9EC7, 0xFF8FD3FF];
const nombresFosforito = ['Amarillo', 'Verde', 'Rosa', 'Azul'];

/// Firestore de las anotaciones (en las capturas de la app, una simulada).
final firestoreAnotacionesProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

/// Los documentos de un tema no pueden llevar «/» en el id.
String idTemaAnotado(String codigo) => codigo.replaceAll('/', '_');

/// Las anotaciones de [codigo] del usuario [uid] en [oposicion].
FuentePizarra fuenteAnotaciones(FirebaseFirestore db, Oposicion oposicion, {required String uid, required String codigo}) =>
    PizarraCompartida(oposicion.raizUsuario(db, uid).collection('anotaciones').doc(idTemaAnotado(codigo)).collection('paginas'), miUid: uid);

/// El tema con sus anotaciones en un PDF nuevo: cada página, la del tema
/// (como imagen) con los trazos encima como vectores; el fosforito se
/// multiplica con el papel, como en pantalla, y el texto se sigue leyendo.
Future<Uint8List> pdfAnotado(PdfDocument documento, Map<int, List<Trazo>> anotaciones, {void Function(int hechas, int total)? progreso}) async {
  final salida = pw.Document(title: 'Tema anotado', creator: 'Oposición TCEE');
  final total = documento.pagesCount;
  for (var n = 1; n <= total; n++) {
    final pagina = await documento.getPage(n);
    final ancho = pagina.width, alto = pagina.height;
    // Unos 150 ppp en A4: se lee bien al imprimirlo sin que pese demasiado.
    final imagen = await pagina.render(width: 1240, height: 1240 * alto / ancho, format: PdfPageImageFormat.jpeg, quality: 85, backgroundColor: '#FFFFFF');
    await pagina.close();
    final trazos = anotaciones[n] ?? const <Trazo>[];
    final escala = ancho / anchoPaginaAnotada;
    salida.addPage(pw.Page(
      pageFormat: pdf.PdfPageFormat(ancho, alto),
      margin: pw.EdgeInsets.zero,
      build: (_) => pw.Stack(children: [
        if (imagen != null) pw.Image(pw.MemoryImage(imagen.bytes), width: ancho, height: alto, fit: pw.BoxFit.fill),
        if (trazos.isNotEmpty)
          pw.CustomPaint(
            size: pdf.PdfPoint(ancho, alto),
            painter: (g, size) {
              for (final fosforito in [true, false]) {
                for (final t in trazos.where((t) => t.esFosforito == fosforito)) {
                  final argb = t.color ?? coloresBoligrafo.first;
                  g.saveContext();
                  g.setGraphicState(pdf.PdfGraphicState(opacity: ((argb >> 24) & 0xff) / 255, blendMode: fosforito ? pdf.PdfBlendMode.multiply : pdf.PdfBlendMode.normal));
                  g.setFillColor(pdf.PdfColor.fromInt(argb | 0xFF000000));
                  for (final c in contornosDeTrazo(t)) {
                    // El PDF cuenta la altura desde abajo.
                    g.moveTo(c.first.dx * escala, alto - c.first.dy * escala);
                    for (final p in c.skip(1)) {
                      g.lineTo(p.dx * escala, alto - p.dy * escala);
                    }
                    g.closePath();
                  }
                  g.fillPath();
                  g.restoreContext();
                }
              }
            },
          ),
      ]),
    ));
    progreso?.call(n, total);
  }
  return salida.save();
}
