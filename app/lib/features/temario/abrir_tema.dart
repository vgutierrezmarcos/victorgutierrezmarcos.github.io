import 'package:flutter/material.dart';

import '../../data/models/temario.dart';
import 'tema_page.dart';

/// Abre la página de un tema por su código. Si no tiene PDF se abre igualmente
/// (muestra su agenda).
void abrirTema(BuildContext context, Temario? temario, String codigo) {
  final x = temario?.tema(codigo);
  if (x == null) return;
  Navigator.of(context).push(MaterialPageRoute(
    builder: (_) => TemaPage(tema: x.disponible ? x : Tema(codigo: x.codigo, titulo: x.titulo, disponible: false, temarioAnterior: x.temarioAnterior)),
  ));
}
