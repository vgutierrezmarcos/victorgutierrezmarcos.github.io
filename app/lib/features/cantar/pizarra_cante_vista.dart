import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../../core/plataforma.dart';
import '../../widgets/comunes.dart';
import 'transcripcion.dart';

/// Abre el PDF de la pizarra del cante [canteId] (el mismo que se manda a la
/// IA): una página por minuto en que cambió, con su marca.
Future<void> verPizarraDelCante(BuildContext context, String canteId) async {
  final p = PizarrasCante.de(canteId);
  if (p == null) return;
  final nav = Navigator.of(context);
  final bytes = await PizarrasCante.pdf(canteId);
  if (bytes == null) return;
  await nav.push(MaterialPageRoute(builder: (_) => _VistaPizarraCante(nombre: p.nombre, bytes: Uint8List.fromList(bytes))));
}

class _VistaPizarraCante extends StatefulWidget {
  const _VistaPizarraCante({required this.nombre, required this.bytes});
  final String nombre;
  final Uint8List bytes;

  @override
  State<_VistaPizarraCante> createState() => _VistaPizarraCanteState();
}

class _VistaPizarraCanteState extends State<_VistaPizarraCante> {
  late final _control = PdfControllerPinch(document: PdfDocument.openData(widget.bytes));

  @override
  void dispose() {
    _control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: BarraWeb(
          title: const Text('Pizarra del cante'),
          subtitulo: widget.nombre,
          actions: [
            IconButton(
              tooltip: 'Guardar el PDF',
              icon: const Icon(Icons.download_outlined),
              onPressed: () => guardarBytes(nombre: widget.nombre, bytes: widget.bytes, mime: 'application/pdf', asunto: 'Pizarra del cante'),
            ),
          ],
        ),
        body: PdfViewPinch(controller: _control),
      );
}
