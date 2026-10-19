import 'pizarra_registro.dart';

typedef AlEventoDom = void Function(EventoDom e);

/// En el móvil no hay navegador: no hay nada que enganchar.
void Function() engancharPizarraWeb({bool evitarScribble = true, AlEventoDom? alEvento, String Function()? volcarRegistro}) => () {};

String agenteNavegador() => '';

/// Si el navegador es de Apple (iPad, iPhone o Mac); en el móvil, no.
bool navegadorApple() => false;
