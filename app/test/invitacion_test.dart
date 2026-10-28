import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/core/constants.dart';
import 'package:tcee_app/core/invitacion.dart';

/// La invitación de un preparador: cómo se lee del enlace de invitación y del
/// referrer de Google Play (core/invitacion.dart).
void main() {
  test('el enlace de invitación lleva el código y la oposición', () {
    final enlace = Urls.invitacion('ABC234', 'tcee');
    expect(enlace, 'https://www.victorgutierrezmarcos.es/app/?codigo=ABC234&op=tcee');
    final inv = Invitacion.deUri(Uri.parse(enlace))!;
    expect(inv.codigo, 'ABC234');
    expect(inv.oposicion, 'tcee');
  });

  test('se lee también de la app web, en minúsculas y sin oposición', () {
    final inv = Invitacion.deUri(Uri.parse('https://www.victorgutierrezmarcos.es/app/abrir/?codigo=abc234'))!;
    expect(inv.codigo, 'ABC234');
    expect(inv.oposicion, isNull);
    expect(Invitacion.deUri(Uri.parse('https://www.victorgutierrezmarcos.es/app/abrir/?codigo=xyz789&op=DCE'))!.oposicion, 'dce');
  });

  test('sin código válido no hay invitación', () {
    expect(Invitacion.deUri(null), isNull);
    expect(Invitacion.deUri(Uri.parse('https://www.victorgutierrezmarcos.es/app/')), isNull);
    expect(Invitacion.deUri(Uri.parse('https://www.victorgutierrezmarcos.es/app/?codigo=AB')), isNull);
    expect(Invitacion.deUri(Uri.parse('https://www.victorgutierrezmarcos.es/app/?codigo=ABC2344&op=tcee')), isNull);
    expect(Invitacion.deUri(Uri.parse('tcee://widget/hoy')), isNull);
  });

  test('el referrer de Google Play es la consulta del enlace', () {
    final inv = Invitacion.deReferrer('codigo=ABC234&op=dce')!;
    expect(inv.codigo, 'ABC234');
    expect(inv.oposicion, 'dce');
    // Lo que da Play en una instalación corriente, sin invitación.
    expect(Invitacion.deReferrer('utm_source=google-play&utm_medium=organic'), isNull);
    expect(Invitacion.deReferrer(null), isNull);
    expect(Invitacion.deReferrer(''), isNull);
    expect(Invitacion.deReferrer('%%%'), isNull);
  });

  test('sin la caja app abierta no hay invitación pendiente', () {
    expect(Invitacion.pendiente(), isNull);
  });
}
