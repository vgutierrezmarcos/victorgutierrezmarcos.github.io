import 'dart:math';

import '../../data/models/cronograma.dart';
import '../../data/models/fases.dart';
import '../../data/models/plan.dart';

/// Lógica del cronograma por fases de un ejercicio escrito (1.º de DCE), sin
/// interfaz: reparto de las semanas hasta el examen entre la primera vuelta,
/// los simulacros y la revisión, y qué temas están flojos.

/// Reparto de las semanas hasta el examen.
class RepartoFases {
  const RepartoFases({required this.fases, required this.semanas, required this.ritmo, this.aviso});

  /// Las tres fases, en orden; las que se salta el opositor, con `saltada`.
  final List<FaseCronograma> fases;

  /// Semanas hasta el examen (sin contar la del examen si cae en lunes).
  final int semanas;

  /// Temas por semana que pide la primera vuelta (0 si se la salta).
  final int ritmo;

  /// Por qué no da tiempo (null si da). La app avisa en lugar de comprimir
  /// las fases sin decir nada.
  final String? aviso;

  FaseCronograma? fase(TipoFase t) => fases.where((f) => f.tipo == t && !f.saltada).firstOrNull;
}

DateTime _mas(DateTime d, int dias) => DateTime(d.year, d.month, d.day + dias);

/// Reparte las semanas desde la de [desde] hasta la víspera de [examen] entre
/// las fases que no estén en [saltadas], en proporción a `cfg.reparto` y en
/// orden (la revisión, al final). Con [inicios], la fase empieza la semana de
/// esa fecha (si el opositor la cambia); las demás se ajustan para no
/// solaparse y para que cada una tenga al menos una semana.
RepartoFases repartoFases({
  required DateTime desde,
  required DateTime examen,
  required FasesEscrito cfg,
  required int temas,
  Set<TipoFase> saltadas = const {},
  Map<TipoFase, DateTime> inicios = const {},
}) {
  final primero = lunesDe(desde);
  final ultimoDia = _mas(DateTime(examen.year, examen.month, examen.day), -1);
  final lunes = <DateTime>[for (var l = primero; !l.isAfter(ultimoDia); l = _mas(l, 7)) l];
  final n = lunes.length;
  final activas = TipoFase.values.where((t) => !saltadas.contains(t)).toList();
  FaseCronograma saltada(TipoFase t) => FaseCronograma(tipo: t, inicio: primero, fin: primero, saltada: true);

  if (n == 0 || activas.isEmpty) {
    return RepartoFases(
      fases: [for (final t in TipoFase.values) saltada(t)],
      semanas: n,
      ritmo: 0,
      aviso: n == 0 ? 'El examen es esta semana o ya ha pasado: no quedan semanas que repartir.' : null,
    );
  }

  // Semanas de cada fase activa: proporcionales a su peso, con el mayor resto
  // para cuadrar el total y al menos una cada una si hay semanas para todas.
  final pesos = [for (final t in activas) max(cfg.reparto[t] ?? 0, 0.0)];
  final suma = pesos.fold(0.0, (a, b) => a + b);
  final exactas = [for (final p in pesos) suma <= 0 ? n / activas.length : n * p / suma];
  final cuenta = [for (final x in exactas) x.floor()];
  final porResto = List.generate(activas.length, (i) => i)..sort((a, b) => (exactas[b] - cuenta[b]).compareTo(exactas[a] - cuenta[a]));
  for (var k = 0; cuenta.fold(0, (a, b) => a + b) < n; k++) {
    cuenta[porResto[k % activas.length]]++;
  }
  if (n >= activas.length) {
    for (var i = 0; i < cuenta.length; i++) {
      while (cuenta[i] == 0) {
        final mayor = List.generate(cuenta.length, (j) => j).reduce((a, b) => cuenta[a] >= cuenta[b] ? a : b);
        cuenta[mayor]--;
        cuenta[i]++;
      }
    }
  }

  // Semana en la que empieza cada fase, respetando las fechas que se cambien.
  final empieza = <int>[];
  var acumulado = 0;
  for (var i = 0; i < activas.length; i++) {
    var e = acumulado;
    final pedida = inicios[activas[i]];
    if (i > 0 && pedida != null) e = lunes.indexWhere((l) => l == lunesDe(pedida)).clamp(0, n);
    final minimo = i == 0 ? 0 : min(empieza[i - 1] + 1, n);
    final maximo = max(minimo, n - (activas.length - i));
    e = i == 0 ? 0 : e.clamp(minimo, maximo);
    empieza.add(e);
    acumulado = e + cuenta[i];
  }

  final fases = <FaseCronograma>[];
  for (final t in TipoFase.values) {
    final i = activas.indexOf(t);
    if (i < 0) {
      fases.add(saltada(t));
      continue;
    }
    final fin = i == activas.length - 1 ? n : empieza[i + 1];
    if (fin <= empieza[i]) {
      fases.add(saltada(t));
      continue;
    }
    fases.add(FaseCronograma(tipo: t, inicio: lunes[empieza[i]], fin: i == activas.length - 1 ? ultimoDia : _mas(lunes[fin], -1)));
  }

  final vuelta = fases.firstWhere((f) => f.tipo == TipoFase.vuelta);
  final semanasVuelta = vuelta.semanas;
  final ritmo = vuelta.saltada || temas == 0 ? 0 : (semanasVuelta == 0 ? temas : (temas / semanasVuelta).ceil());
  String? aviso;
  if (!vuelta.saltada && temas > 0 && ritmo > cfg.maxTemasSemana) {
    aviso = 'No da tiempo a una primera vuelta completa: en ${semanasVuelta == 1 ? 'una semana' : '$semanasVuelta semanas'} '
        'saldrían $ritmo temas por semana (más de ${cfg.maxTemasSemana}). Puedes elegir menos temas, alargar la primera vuelta '
        'o saltarte los simulacros.';
  }
  return RepartoFases(fases: fases, semanas: n, ritmo: ritmo, aviso: aviso);
}

// ----------------------------------------------------------- Temas flojos

enum RazonFlojo { mal, regular, sinEscribir, descartado }

/// Un tema flojo y por qué.
class TemaFlojo {
  const TemaFlojo({required this.codigo, required this.razones, this.ultima, this.ultimaVez, this.descartes = 0, this.salidas = 0, this.hoy});
  final String codigo;
  final List<RazonFlojo> razones;
  /// Nota de la última vez que se escribió (null si nunca).
  final NotaEscrito? ultima;
  /// Última vez que se escribió (o, si nunca, que se estudió).
  final DateTime? ultimaVez;
  /// Veces que se descartó en un simulacro y veces que salió en uno.
  final int descartes;
  final int salidas;
  final DateTime? hoy;

  /// «Salió mal · descartado 3 de 4» (para la lista de la semana).
  String get explicacion => [
        for (final r in razones)
          switch (r) {
            RazonFlojo.mal => 'salió mal',
            RazonFlojo.regular => 'salió regular',
            RazonFlojo.sinEscribir => ultimaVez == null || hoy == null ? 'sin escribir' : '${(hoy!.difference(ultimaVez!).inDays / 7).floor()} semanas sin escribir',
            RazonFlojo.descartado => 'descartado $descartes de $salidas',
          },
      ].join(' · ');
}

/// Temas flojos del ejercicio [ejercicio] según lo escrito en el diario
/// ([cantes]), de más a menos urgente: primero los peor valorados y, a
/// igualdad, los que hace más que no se escriben. Un tema es flojo si:
///  - la última vez que se escribió salió mal o regular (y no se ha vuelto a
///    escribir bien dos veces seguidas: con una puede haber sido suerte);
///  - lleva más de `cfg.diasSinEscribir` días sin escribirse (contando desde
///    que se estudió, en [estudiados], si nunca se ha escrito);
///  - en los simulacros se descarta casi siempre (en `cfg.proporcionDescarte`
///    de las veces o más, tras salir `cfg.minSalidasDescarte` veces), salvo
///    que después se haya escrito bien dos veces seguidas.
List<TemaFlojo> temasFlojos({
  required Iterable<Cante> cantes,
  required int ejercicio,
  required DateTime hoy,
  required FasesEscrito cfg,
  Map<String, DateTime> estudiados = const {},
}) {
  final hechos = cantes.where((c) => c.hecho && !c.borrado && c.ejercicio == ejercicio && c.resultado != null).toList()..sort((a, b) => a.fecha.compareTo(b.fecha));
  final arrastre = <String, bool>{};
  final bienSeguidos = <String, int>{};
  final bienTrasDescarte = <String, int>{};
  final ultima = <String, NotaEscrito>{};
  final ultimaVez = <String, DateTime>{};
  final descartes = <String, int>{};
  final salidas = <String, int>{};

  for (final c in hechos) {
    final r = c.resultado!;
    final simulacro = r.descartados.isNotEmpty;
    for (final t in r.descartados) {
      descartes[t] = (descartes[t] ?? 0) + 1;
      salidas[t] = (salidas[t] ?? 0) + 1;
      bienTrasDescarte[t] = 0;
    }
    for (final t in r.temasCantados) {
      if (simulacro) salidas[t] = (salidas[t] ?? 0) + 1;
      ultimaVez[t] = c.fecha;
      final nota = NotaEscrito.de(r.valoracionDe(t));
      if (nota == null) continue;
      ultima[t] = nota;
      if (nota == NotaEscrito.bien) {
        bienTrasDescarte[t] = (bienTrasDescarte[t] ?? 0) + 1;
        if (arrastre[t] == true) {
          bienSeguidos[t] = (bienSeguidos[t] ?? 0) + 1;
          if (bienSeguidos[t]! >= 2) arrastre[t] = false;
        }
      } else {
        arrastre[t] = true;
        bienSeguidos[t] = 0;
        bienTrasDescarte[t] = 0;
      }
    }
  }

  final todos = {...ultimaVez.keys, ...descartes.keys, ...estudiados.keys};
  final out = <TemaFlojo>[];
  for (final t in todos) {
    final razones = <RazonFlojo>[];
    if (arrastre[t] == true) razones.add(ultima[t] == NotaEscrito.mal ? RazonFlojo.mal : RazonFlojo.regular);
    final vez = ultimaVez[t] ?? estudiados[t];
    if (vez != null && hoy.difference(vez).inDays > cfg.diasSinEscribir) razones.add(RazonFlojo.sinEscribir);
    final s = salidas[t] ?? 0, d = descartes[t] ?? 0;
    if (s >= cfg.minSalidasDescarte && d / s >= cfg.proporcionDescarte - 1e-9 && (bienTrasDescarte[t] ?? 0) < 2) razones.add(RazonFlojo.descartado);
    if (razones.isNotEmpty) out.add(TemaFlojo(codigo: t, razones: razones, ultima: ultima[t], ultimaVez: vez, descartes: d, salidas: s, hoy: hoy));
  }
  // Peor valorados primero (sin escribir nunca, entre mal y regular); a
  // igualdad, los que hace más que no se escriben.
  int peso(TemaFlojo f) => f.ultima == null ? 2 : f.ultima!.valor;
  out.sort((a, b) {
    final p = peso(a).compareTo(peso(b));
    if (p != 0) return p;
    final x = a.ultimaVez, y = b.ultimaVez;
    if (x == null || y == null) return x == null ? (y == null ? 0 : -1) : 1;
    return x.compareTo(y);
  });
  return out;
}

/// Cuántos temas flojos caben en una semana con [otros] temas escritos (los de
/// sus simulacros): como mucho `cfg.maxFlojosSemana` y nunca más de un tercio
/// de los temas de la semana (los flojos incluidos).
int topeFlojos(int otros, FasesEscrito cfg) => min(cfg.maxFlojosSemana, otros ~/ 2);

/// Los temas flojos que entran esta semana en la revisión.
List<TemaFlojo> flojosDeSemana(List<TemaFlojo> flojos, FasesEscrito cfg) => flojos.take(topeFlojos(2 * cfg.simulacrosPorSemana, cfg)).toList();
