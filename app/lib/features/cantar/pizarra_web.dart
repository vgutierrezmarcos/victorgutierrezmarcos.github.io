import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:web/web.dart' as web;

import 'pizarra_registro.dart';

typedef AlEventoDom = void Function(EventoDom e);

/// Para las pruebas con el navegador: `window.__registroPizarra()` devuelve
/// el registro de la pizarra abierta.
@JS('__registroPizarra')
external set _registroJs(JSFunction? f);

web.Element? _vista() => web.document.querySelector('flutter-view');

/// Solo lo que cae en la app Flutter, nunca dentro de una vista HTML
/// incrustada (un iframe de pdf.js, una imagen), que tiene su propio tacto.
bool _dentroDeFlutter(web.EventTarget? objetivo, web.Element? vista) {
  if (vista == null || objetivo == null || !objetivo.isA<web.Element>()) return false;
  final el = objetivo as web.Element;
  return vista.contains(el) && el.closest('flt-platform-view') == null;
}

String _etiqueta(web.EventTarget? objetivo) => objetivo != null && objetivo.isA<web.Element>() ? (objetivo as web.Element).tagName : '';

/// Engancha la pizarra al navegador mientras está abierta y devuelve cómo
/// desengancharla.
///
/// [evitarScribble]: un `touchmove` no pasivo con `preventDefault`. En el
/// iPad, Scribble se queda con los toques cortos del Apple Pencil cuando le
/// parecen letras y Safari no entrega (o entrega tarde) los eventos de puntero;
/// con esto deja de hacerlo (bug 217430 de WebKit).
///
/// [alEvento] recibe cada evento de puntero y de tacto en la fase de captura
/// de `document`, es decir, antes de que lo vea el motor de Flutter: así la
/// pizarra sabe lo que el motor va a perder.
void Function() engancharPizarraWeb({bool evitarScribble = true, AlEventoDom? alEvento, String Function()? volcarRegistro}) {
  final vista = _vista();
  final quitar = <void Function()>[];

  void escuchar(String tipo, web.EventListener f, {bool pasivo = true}) {
    web.document.addEventListener(tipo, f, web.AddEventListenerOptions(capture: true, passive: pasivo));
    // Se quita con el mismo `capture`: si no, el navegador no lo encuentra.
    quitar.add(() => web.document.removeEventListener(tipo, f, web.EventListenerOptions(capture: true)));
  }

  if (evitarScribble) {
    final f = ((web.Event e) {
      if (_dentroDeFlutter(e.target, vista)) e.preventDefault();
    }).toJS;
    // passive: false es lo que cuenta: en iOS, en document, el touchmove es
    // pasivo por defecto y preventDefault no haría nada.
    escuchar('touchmove', f, pasivo: false);
  }

  if (alEvento != null) {
    for (final tipo in const ['pointerdown', 'pointermove', 'pointerup', 'pointercancel', 'pointerleave', 'pointerout']) {
      final f = ((web.Event ev) {
        final e = ev as web.PointerEvent;
        alEvento(EventoDom(
          tipo: tipo,
          puntero: e.pointerType,
          id: e.pointerId,
          botones: e.buttons,
          presion: e.pressure.toDouble(),
          x: e.clientX.toDouble(),
          y: e.clientY.toDouble(),
          ts: e.timeStamp.toDouble(),
          primario: e.isPrimary,
          objetivo: _etiqueta(e.target),
        ));
      }).toJS;
      escuchar(tipo, f);
    }
    for (final tipo in const ['touchstart', 'touchmove', 'touchend', 'touchcancel']) {
      final f = ((web.Event ev) {
        final e = ev as web.TouchEvent;
        final lista = tipo == 'touchend' || tipo == 'touchcancel' ? e.changedTouches : e.touches;
        final primero = lista.length > 0 ? lista.item(0) : null;
        // `touchType` (direct o stylus) solo lo da Safari y no está tipado.
        final tipoToque = primero == null ? '' : (primero.getProperty<JSString?>('touchType'.toJS)?.toDart ?? '');
        alEvento(EventoDom(
          tipo: tipo,
          puntero: '',
          x: primero?.clientX.toDouble() ?? 0,
          y: primero?.clientY.toDouble() ?? 0,
          ts: e.timeStamp.toDouble(),
          objetivo: _etiqueta(e.target),
          toques: e.touches.length,
          tipoToque: tipoToque,
        ));
      }).toJS;
      escuchar(tipo, f);
    }
  }

  if (volcarRegistro != null) {
    _registroJs = (() => volcarRegistro().toJS).toJS;
    quitar.add(() => _registroJs = null);
  }

  return () {
    for (final q in quitar) {
      q();
    }
  };
}

String agenteNavegador() => web.window.navigator.userAgent;
