import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/plan.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Color de cada actividad en la rejilla del horario.
Color colorActividad(BuildContext context, Actividad a) => switch (a) {
      Actividad.dormir => const Color(0xFF7986A8),
      Actividad.desayuno || Actividad.comida || Actividad.cena => context.colores.dorado,
      Actividad.estudiar => context.esquema.primary,
      Actividad.idioma => const Color(0xFF2B8A9E),
      Actividad.ejercicio => Paleta.acierto,
      Actividad.descanso => context.colores.borde,
    };

/// Horario semanal en franjas de media hora (hoja "Horario de estudio" del
/// Excel): se elige una actividad y se pinta sobre la rejilla.
class HorarioPage extends ConsumerStatefulWidget {
  const HorarioPage({super.key});
  @override
  ConsumerState<HorarioPage> createState() => _HorarioPageState();
}

class _HorarioPageState extends ConsumerState<HorarioPage> {
  static const _altoFranja = 20.0;
  static const _anchoHora = 44.0;

  Actividad _pincel = Actividad.estudiar;
  late Horario _horario = ref.read(planProvider).horario ?? Horario.porDefecto();
  bool _cambiado = false;

  void _pintar(Offset p, double anchoDia) {
    final dia = ((p.dx - _anchoHora) / anchoDia).floor();
    final franja = (p.dy / _altoFranja).floor();
    if (dia < 0 || dia > 6 || franja < 0 || franja >= Horario.franjasPorDia) return;
    if (_horario.dias[dia][franja] == _pincel) return;
    setState(() {
      _horario = _horario.con(dia, franja, _pincel);
      _cambiado = true;
    });
  }

  Future<void> _guardar() async {
    await ref.read(planProvider.notifier).actualizar((p) => p.copyWith(horario: _horario));
    if (mounted) setState(() => _cambiado = false);
  }

  @override
  Widget build(BuildContext context) {
    final semana = _horario.horasPorDia();
    final sinSabado = _horario.horasPorDia(sinSabado: true);
    String h(double v) => v.toStringAsFixed(1).replaceAll('.', ',');
    // Como en el Excel, las tres comidas se suman en una sola fila.
    double comer(Map<Actividad, double> m) => m[Actividad.desayuno]! + m[Actividad.comida]! + m[Actividad.cena]!;
    final filas = <(String, Color, double, double)>[
      ('Estudiar', colorActividad(context, Actividad.estudiar), semana[Actividad.estudiar]!, sinSabado[Actividad.estudiar]!),
      ('Idioma', colorActividad(context, Actividad.idioma), semana[Actividad.idioma]!, sinSabado[Actividad.idioma]!),
      ('Ejercicio', colorActividad(context, Actividad.ejercicio), semana[Actividad.ejercicio]!, sinSabado[Actividad.ejercicio]!),
      ('Descanso', colorActividad(context, Actividad.descanso), semana[Actividad.descanso]!, sinSabado[Actividad.descanso]!),
      ('Comer', colorActividad(context, Actividad.comida), comer(semana), comer(sinSabado)),
      ('Dormir', colorActividad(context, Actividad.dormir), semana[Actividad.dormir]!, sinSabado[Actividad.dormir]!),
    ];

    return Scaffold(
      appBar: BarraWeb(
        title: const Text('Horario de estudio'),
        actions: [
          if (_cambiado) TextButton(onPressed: _guardar, child: const Text('Guardar')),
          PopupMenuButton<String>(
            onSelected: (_) => setState(() {
              _horario = Horario.porDefecto();
              _cambiado = true;
            }),
            itemBuilder: (_) => const [PopupMenuItem(value: 'defecto', child: Text('Volver al horario de ejemplo'))],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          Text('Elige una actividad y toca las franjas para pintarlas. Mantén pulsado y arrastra para pintar varias seguidas.', style: context.textos.bodySmall),
          const SizedBox(height: 8),
          Wrap(spacing: 6, runSpacing: 4, children: [
            for (final a in Actividad.values)
              ChoiceChip(
                avatar: CircleAvatar(backgroundColor: colorActividad(context, a), radius: 7),
                label: Text(a.etiqueta),
                selected: _pincel == a,
                showCheckmark: false,
                onSelected: (_) => setState(() => _pincel = a),
              ),
          ]),
          const TituloSeccion('Horas al día'),
          Tarjeta(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(children: [
              Row(children: [
                const Expanded(child: SizedBox()),
                SizedBox(width: 76, child: Text('Semana', textAlign: TextAlign.end, style: context.textos.labelSmall)),
                SizedBox(width: 76, child: Text('Sin sábado', textAlign: TextAlign.end, style: context.textos.labelSmall)),
              ]),
              for (final (nombre, color, a, b) in filas)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(children: [
                    CircleAvatar(backgroundColor: color, radius: 5),
                    const SizedBox(width: 8),
                    Expanded(child: Text(nombre, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
                    SizedBox(width: 76, child: Text('${h(a)} h', textAlign: TextAlign.end, style: context.textos.titleSmall)),
                    SizedBox(width: 76, child: Text('${h(b)} h', textAlign: TextAlign.end, style: context.textos.titleSmall)),
                  ]),
                ),
            ]),
          ),
          Padding(padding: const EdgeInsets.only(top: 4), child: Text('${h(_horario.horasEstudioSemana)} horas de estudio a la semana.', style: context.textos.labelSmall)),
          const TituloSeccion('Semana'),
          Row(children: [
            const SizedBox(width: _anchoHora),
            for (final d in ['L', 'M', 'X', 'J', 'V', 'S', 'D']) Expanded(child: Text(d, textAlign: TextAlign.center, style: context.textos.labelMedium)),
          ]),
          const SizedBox(height: 4),
          LayoutBuilder(builder: (context, c) {
            final anchoDia = (c.maxWidth - _anchoHora) / 7;
            return GestureDetector(
              onTapUp: (d) => _pintar(d.localPosition, anchoDia),
              onLongPressStart: (d) => _pintar(d.localPosition, anchoDia),
              onLongPressMoveUpdate: (d) => _pintar(d.localPosition, anchoDia),
              child: Column(children: [
                for (var f = 0; f < Horario.franjasPorDia; f++)
                  SizedBox(
                    height: _altoFranja,
                    child: Row(children: [
                      SizedBox(width: _anchoHora, child: f.isEven ? Text('${(f ~/ 2).toString().padLeft(2, '0')}:00', style: context.textos.labelSmall?.copyWith(fontSize: 10)) : null),
                      for (var d = 0; d < 7; d++)
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(0.5),
                            decoration: BoxDecoration(color: colorActividad(context, _horario.dias[d][f]), borderRadius: BorderRadius.circular(2)),
                          ),
                        ),
                    ]),
                  ),
              ]),
            );
          }),
        ],
      ),
    );
  }
}
