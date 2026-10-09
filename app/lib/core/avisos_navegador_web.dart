import 'dart:js_interop';

@JS('avisosApp')
external _AvisosApp? get _avisosApp;

extension type _AvisosApp._(JSObject _) implements JSObject {
  external bool admite();
  external String permiso();
  external JSPromise<JSString> pedir();
  external void mostrar(int id, String titulo, String texto, String? aviso);
  external void alTocar(JSFunction f);
  external JSPromise<JSString> versionNueva();
  external void recargar();
}

bool get navegadorAdmiteAvisos {
  try {
    return _avisosApp?.admite() ?? false;
  } catch (_) {
    return false;
  }
}

String permisoAvisosNavegador() {
  try {
    return _avisosApp?.permiso() ?? 'denied';
  } catch (_) {
    return 'denied';
  }
}

Future<bool> pedirPermisoAvisosNavegador() async {
  try {
    final a = _avisosApp;
    if (a == null) return false;
    return (await a.pedir().toDart).toDart == 'granted';
  } catch (_) {
    return false;
  }
}

void iniciarAvisosNavegador(void Function(String contenido) alTocar) {
  try {
    _avisosApp?.alTocar(((JSString c) => alTocar(c.toDart)).toJS);
  } catch (_) {}
}

void mostrarAvisoNavegador(int id, String titulo, String texto, {String? contenido}) {
  try {
    _avisosApp?.mostrar(id, titulo, texto, contenido);
  } catch (_) {}
}

Future<String?> versionNuevaNavegador() async {
  try {
    final a = _avisosApp;
    if (a == null) return null;
    final v = (await a.versionNueva().toDart).toDart;
    return v.isEmpty ? null : v;
  } catch (_) {
    return null;
  }
}

void recargarNavegador() {
  try {
    _avisosApp?.recargar();
  } catch (_) {}
}
