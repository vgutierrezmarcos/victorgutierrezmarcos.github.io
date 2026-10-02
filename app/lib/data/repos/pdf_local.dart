import 'dart:typed_data';

/// PDF listo para el visor: una ruta en el móvil o los bytes en el navegador.
class PdfLocal {
  const PdfLocal({this.ruta, this.bytes});
  final String? ruta;
  final Uint8List? bytes;
}
