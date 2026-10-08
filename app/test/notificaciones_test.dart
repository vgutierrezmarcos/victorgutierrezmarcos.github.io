import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/core/notificaciones.dart';

void main() {
  test('el botón pulsado en un aviso se añade como parámetro, con ? si la ruta no llevaba ninguno', () {
    expect(Notificaciones.conAccion('ruta:/tablon', 'ver'), 'ruta:/tablon?accion=ver');
    expect(Notificaciones.conAccion('ruta:/cantes?cante=sust_1', 'ver'), 'ruta:/cantes?cante=sust_1&accion=ver');
    expect(Notificaciones.conAccion('ruta:/cantes?cante=x&tema=3.A.2', 'esquema'), 'ruta:/cantes?cante=x&tema=3.A.2&accion=esquema');
    expect(Notificaciones.conAccion('ruta:/semana', null), 'ruta:/semana');
    expect(Notificaciones.conAccion('ruta:/semana', ''), 'ruta:/semana');
    expect(Notificaciones.conAccion(null, 'ver'), isNull);
  });
}
