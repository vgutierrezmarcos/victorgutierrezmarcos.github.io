import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tcee_app/core/actualizaciones.dart';
import 'package:tcee_app/core/instalacion.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('origen de la instalación', () {
    tearDown(() => fijarOrigenInstalacion(null));

    Future<OrigenInstalacion> con(String? tienda) async {
      fijarOrigenInstalacion(null);
      PackageInfo.setMockInitialValues(appName: 'TCEE', packageName: 'es.victorgutierrezmarcos.tcee_app', version: '1.20.3', buildNumber: '61', buildSignature: '', installerStore: tienda);
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      try {
        return await origenInstalacion();
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    }

    test('Google Play es com.android.vending', () async => expect(await con('com.android.vending'), OrigenInstalacion.play));
    test('el APK de la web no tiene a Play como instalador', () async {
      expect(await con(null), OrigenInstalacion.apk);
      expect(await con('com.google.android.packageinstaller'), OrigenInstalacion.apk);
    });
    test('se recuerda tras la primera lectura', () async {
      expect(await con('com.android.vending'), OrigenInstalacion.play);
      PackageInfo.setMockInitialValues(appName: 'TCEE', packageName: 'x', version: '1', buildNumber: '1', buildSignature: '', installerStore: null);
      expect(await origenInstalacion(), OrigenInstalacion.play);
    });
  });

  group('textos del aviso de versión nueva', () {
    test('desde el APK con la app en Play: se pide pasar a Play', () {
      final t = textosVersionNueva('1.21.0', OrigenInstalacion.apk, hayPlay: true);
      expect(t.titulo, 'La app ya está en Google Play');
      expect(t.texto, contains('se actualizará sola'));
      expect(t.boton, 'Ir a Google Play');
    });
    test('desde el APK sin ficha en Play: actualizar', () {
      final t = textosVersionNueva('1.21.0', OrigenInstalacion.apk, hayPlay: false);
      expect(t.titulo, 'Versión 1.21.0 disponible');
      expect(t.boton, 'Actualizar');
    });
    test('desde Play: actualizar', () {
      final t = textosVersionNueva('1.21.0', OrigenInstalacion.play, hayPlay: true);
      expect(t.titulo, 'Versión 1.21.0 disponible');
      expect(t.boton, 'Actualizar');
    });
    test('en el navegador: recargar', () => expect(textosVersionNueva('1.21.0', OrigenInstalacion.web, hayPlay: true).boton, 'Recargar'));
  });

  test('ficha de Google Play', () {
    expect(esFichaDePlay('https://play.google.com/store/apps/details?id=es.victorgutierrezmarcos.tcee_app'), isTrue);
    expect(esFichaDePlay('https://github.com/x/releases/download/app-latest/oposicion-tcee.apk'), isFalse);
    expect(esFichaDePlay(null), isFalse);
  });
}
