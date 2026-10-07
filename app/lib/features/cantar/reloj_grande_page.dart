import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_theme.dart';
import 'reloj_cante.dart';

/// Lo que la pantalla grande necesita de quien lleva el cronómetro (Cantar).
abstract class FuenteReloj {
  RelojCante get reloj;

  /// «3.A.7 · Título» del tema que se canta, si se ha elegido.
  String? get temaActual;

  /// Nombre de con quién se comparte el reloj, si se comparte.
  String? get compartidoCon;

  /// Hacia delante (cronómetro) o cuenta atrás.
  ModoReloj get modo;

  /// Empezar, pausar o continuar (o empezar la exposición si espera).
  void alternar();
  /// Minutos de más (o de menos) para la fase en curso.
  void ajustarMinutos(int minutos);
  void pasarAExponer();
  void empezarExposicion();
  void reiniciarExposicion();
  void reiniciarTodo();
  void alternarModo();
}

/// El cronómetro a pantalla completa, con los números enormes, para ponerlo
/// en una tableta o un portátil que vean el opositor y el preparador (o el
/// tribunal de mentira de casa). Sigue al reloj de Cantar, compartido o no.
class RelojGrandePage extends StatefulWidget {
  const RelojGrandePage({super.key, required this.fuente});
  final FuenteReloj fuente;

  @override
  State<RelojGrandePage> createState() => _RelojGrandePageState();
}

class _RelojGrandePageState extends State<RelojGrandePage> {
  Timer? _tic;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _tic = Timer.periodic(const Duration(milliseconds: 250), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tic?.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.fuente;
    final r = f.reloj;
    final ahora = DateTime.now();
    final terminado = r.terminado(ahora);
    final esquema = r.preparacion > Duration.zero && r.enPreparacion(ahora);
    final esperando = r.esperandoExposicion(ahora);
    final lectura = lecturaReloj(r, ahora, f.modo);
    final ultimoMinuto = !esquema && !esperando && r.empezado && r.restanteFase(ahora).inSeconds <= 60;
    final color = terminado || ultimoMinuto ? const Color(0xFFE57373) : (esquema || esperando ? context.colores.dorado : Colors.white);
    final fase = terminado ? 'TIEMPO CUMPLIDO' : (esperando ? 'ESQUEMA TERMINADO' : (esquema ? 'ESQUEMA' : 'EXPOSICIÓN'));
    final tema = f.temaActual;
    final con = f.compartidoCon;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: estiloBarrasSistema(arriba: const Color(0xFF16101C), abajo: const Color(0xFF16101C)),
      child: Scaffold(
      backgroundColor: const Color(0xFF16101C),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, c) {
            final grande = (c.maxWidth / 4.2).clamp(60.0, c.maxHeight * 0.45);
            return Stack(children: [
              Positioned(
                top: 4,
                left: 4,
                child: IconButton(tooltip: 'Salir', color: Colors.white70, icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ),
              if (con != null)
                Positioned(
                  top: 16,
                  right: 20,
                  child: Row(children: [
                    const Icon(Icons.sync, color: Colors.white54, size: 18),
                    const SizedBox(width: 6),
                    Text('Compartido con $con', style: const TextStyle(color: Colors.white54, fontSize: 14)),
                  ]),
                ),
              Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(fase, style: TextStyle(color: color.withValues(alpha: 0.85), fontSize: (grande / 6).clamp(14.0, 34.0), letterSpacing: 4, fontWeight: FontWeight.w600)),
                  FittedBox(
                    child: Text(
                      lectura.texto,
                      style: TextStyle(color: color, fontSize: grande, fontWeight: FontWeight.w300, fontFeatures: const [FontFeature.tabularFigures()], height: 1.05),
                    ),
                  ),
                  if (lectura.demas != null)
                    Text('${lectura.demas} de más', style: TextStyle(color: color, fontSize: (grande / 5).clamp(16.0, 40.0), fontFeatures: const [FontFeature.tabularFigures()])),
                  SizedBox(
                    width: c.maxWidth * 0.6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(value: r.progresoFase(ahora).clamp(0.0, 1.0), minHeight: 8, color: color, backgroundColor: Colors.white12),
                    ),
                  ),
                  if (tema != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 22, 32, 0),
                      child: Text(tema, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 20)),
                    ),
                ]),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 18,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  // Los principales.
                  Wrap(alignment: WrapAlignment.center, spacing: 12, runSpacing: 8, children: [
                    if (esperando)
                      _Boton(Icons.record_voice_over_outlined, 'Empezar la exposición', f.empezarExposicion, destacado: true)
                    else
                      _Boton(r.corriendo ? Icons.pause : Icons.play_arrow, r.corriendo ? 'Pausar' : (r.empezado ? 'Continuar' : 'Empezar'), f.alternar, destacado: !r.corriendo),
                    if (esquema && r.empezado) _Boton(Icons.record_voice_over_outlined, 'Pasar a exponer', f.pasarAExponer),
                  ]),
                  const SizedBox(height: 10),
                  // Los de ajuste, más pequeños.
                  Wrap(alignment: WrapAlignment.center, spacing: 8, runSpacing: 6, children: [
                    if (r.empezado) ...[
                      _Boton(Icons.remove, '1 min', () => f.ajustarMinutos(-1), pequeno: true),
                      _Boton(Icons.add, '1 min', () => f.ajustarMinutos(1), pequeno: true),
                      _Boton(Icons.more_time, '+5 min', () => f.ajustarMinutos(5), pequeno: true),
                    ],
                    if (!esquema && !esperando && r.empezado && r.preparacion > Duration.zero)
                      _Boton(Icons.replay, 'Reiniciar la exposición', f.reiniciarExposicion, pequeno: true),
                    if (r.empezado) _Boton(Icons.restart_alt, 'Reiniciar todo', f.reiniciarTodo, pequeno: true),
                    _Boton(f.modo == ModoReloj.adelante ? Icons.hourglass_bottom : Icons.timer_outlined, f.modo == ModoReloj.adelante ? 'Cuenta atrás' : 'Cronómetro', f.alternarModo, pequeno: true),
                  ]),
                ]),
              ),
            ]);
          }),
      ),
    ),
    );
  }
}

class _Boton extends StatelessWidget {
  const _Boton(this.icono, this.texto, this.onPressed, {this.destacado = false, this.pequeno = false});
  final IconData icono;
  final String texto;
  final VoidCallback? onPressed;
  /// El principal (empezar, continuar, empezar la exposición): relleno.
  final bool destacado;
  /// Los de ajuste: más pequeños, para que no tapen los números.
  final bool pequeno;

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: destacado ? const Color(0xFF16101C) : (pequeno ? Colors.white70 : Colors.white),
          backgroundColor: destacado ? Colors.white : Colors.transparent,
          disabledForegroundColor: Colors.white38,
          side: BorderSide(color: destacado ? Colors.white : (pequeno ? Colors.white24 : Colors.white38)),
          padding: pequeno ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8) : const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          visualDensity: pequeno ? VisualDensity.compact : null,
        ),
        onPressed: onPressed,
        icon: Icon(icono, size: pequeno ? 18 : 22),
        label: Text(texto, style: TextStyle(fontSize: pequeno ? 13 : 16)),
      );
}
