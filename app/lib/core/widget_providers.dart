import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/preparador.dart';
import 'cronograma_providers.dart';
import 'providers.dart';
import 'widget_inicio.dart';

/// Datos del widget de la pantalla de inicio, a partir de lo que ya muestra
/// la app: el próximo ejercicio con fecha, el próximo cante (o clase, para el
/// preparador), la semana del cronograma y si el test diario está hecho.
final datosWidgetProvider = Provider<DatosWidget>((ref) {
  final oposicion = ref.watch(oposicionProvider);
  final ahora = DateTime.now();
  final fechas = ref.watch(fechasEjerciciosProvider).entries.where((e) => !e.value.isBefore(DateTime(ahora.year, ahora.month, ahora.day))).toList()
    ..sort((a, b) => a.value.compareTo(b.value));
  final proximo = fechas.firstOrNull;
  final preparador = ref.watch(papelProvider) == Papel.preparador;

  DateTime? cante;
  var canteTexto = '';
  if (preparador) {
    final clase = ref.watch(proximasSesionesProvider).where((c) => c.fecha.isAfter(ahora)).firstOrNull;
    if (clase != null) {
      final alumno = ref.watch(alumnosProvider).where((a) => a.id == clase.alumno).firstOrNull;
      cante = clase.fecha;
      canteTexto = 'Clase con ${alumno?.nombre ?? 'tu alumno'}';
    }
  } else {
    final c = ref.watch(proximosCantesProvider).where((c) => c.fecha.isAfter(ahora)).firstOrNull;
    if (c != null) {
      cante = c.fecha;
      canteTexto = [
        if (c.dePreparador) 'con ${(c.preparadorNombre ?? '').isEmpty ? 'tu preparador' : c.preparadorNombre}' else (c.titulo.isEmpty ? 'Cante' : c.titulo),
        if (c.temas.isNotEmpty) c.temas.take(3).join(', '),
      ].join(' · ');
    }
  }

  final estado = ref.watch(estadoCronogramaProvider);
  final semana = estado?.semanaActual;
  final textoSemana = estado == null
      ? null
      : estado.terminado
          ? 'Vuelta terminada'
          : semana == null
              ? '${estado.hechos.length} de ${estado.total} temas'
              : semana.descanso
                  ? 'Semana de descanso'
                  : 'Semana: ${semana.temas.where(estado.hechos.contains).length} de ${semana.temas.length}';

  return DatosWidget(
    siglas: oposicion.siglas,
    // El preparador, como en Hoy: sin cuenta atrás al examen ni cronograma propio.
    examen: preparador ? null : proximo?.value,
    examenNombre: proximo == null || preparador ? '' : oposicion.nombreEjercicio(proximo.key).toLowerCase(),
    cante: cante,
    canteTexto: canteTexto,
    semana: preparador ? null : textoSemana,
    testHecho: ref.watch(testDiarioHechoProvider) ? ahora : null,
    preparador: preparador,
  );
});

DatosWidget? _ultimo;

/// Manda los datos al widget cuando cambian (se escucha desde la app).
void actualizarWidget(DatosWidget d) {
  if (d == _ultimo) return;
  _ultimo = d;
  guardarWidget(d);
}
