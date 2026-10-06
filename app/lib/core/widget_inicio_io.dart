import 'dart:io';

import 'package:home_widget/home_widget.dart';

import 'widget_inicio_datos.dart';

const _proveedor = 'es.victorgutierrezmarcos.tcee_app.WidgetTcee';

String _dia(DateTime d) => '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

/// Guarda los datos del widget y lo redibuja (si está en la pantalla de inicio).
Future<void> guardarWidget(DatosWidget d) async {
  if (!Platform.isAndroid) return;
  try {
    await Future.wait([
      HomeWidget.saveWidgetData<String>('siglas', d.siglas),
      HomeWidget.saveWidgetData<String>('examen', d.examen?.millisecondsSinceEpoch.toString()),
      HomeWidget.saveWidgetData<String>('examen_nombre', d.examenNombre),
      HomeWidget.saveWidgetData<String>('cante', d.cante?.millisecondsSinceEpoch.toString()),
      HomeWidget.saveWidgetData<String>('cante_texto', d.canteTexto),
      HomeWidget.saveWidgetData<String>('semana', d.semana),
      HomeWidget.saveWidgetData<String>('test_hecho', d.testHecho == null ? '' : _dia(d.testHecho!)),
      HomeWidget.saveWidgetData<bool>('preparador', d.preparador),
    ]);
    await HomeWidget.updateWidget(qualifiedAndroidName: _proveedor);
  } catch (_) {
    // Sin el plugin (pruebas) o sin widget: nada.
  }
}

/// La dirección con la que se abrió la app desde el widget (o null).
Future<Uri?> abiertoDesdeWidget() async {
  if (!Platform.isAndroid) return null;
  try {
    return await HomeWidget.initiallyLaunchedFromHomeWidget();
  } catch (_) {
    return null;
  }
}

/// Toques en el widget con la app ya abierta.
Stream<Uri?> clicsEnWidget() {
  if (!Platform.isAndroid) return const Stream.empty();
  try {
    return HomeWidget.widgetClicked;
  } catch (_) {
    return const Stream.empty();
  }
}
