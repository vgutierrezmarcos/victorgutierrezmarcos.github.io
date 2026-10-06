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

  void alternar();
  void masTiempo();
  void pasarAExponer();
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

  String _formato(Duration d) {
    final s = (d.inMilliseconds / 1000).ceil();
    final h = s ~/ 3600;
    final mm = ((s % 3600) ~/ 60).toString().padLeft(2, '0');
    final ss = (s % 60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$mm:$ss' : '$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.fuente;
    final r = f.reloj;
    final ahora = DateTime.now();
    final terminado = r.terminado(ahora);
    final esquema = r.preparacion > Duration.zero && r.enPreparacion(ahora);
    final restante = r.restanteFase(ahora);
    final ultimoMinuto = !esquema && r.empezado && restante.inSeconds <= 60;
    final color = terminado || ultimoMinuto ? const Color(0xFFE57373) : (esquema ? context.colores.dorado : Colors.white);
    final fase = terminado ? 'TIEMPO CUMPLIDO' : (esquema ? 'ESQUEMA' : 'EXPOSICIÓN');
    final tema = f.temaActual;
    final con = f.compartidoCon;

    return Scaffold(
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
                      _formato(restante),
                      style: TextStyle(color: color, fontSize: grande, fontWeight: FontWeight.w300, fontFeatures: const [FontFeature.tabularFigures()], height: 1.05),
                    ),
                  ),
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
                child: Wrap(alignment: WrapAlignment.center, spacing: 12, runSpacing: 8, children: [
                  _Boton(r.corriendo ? Icons.pause : Icons.play_arrow, r.corriendo ? 'Pausar' : (r.empezado ? 'Continuar' : 'Empezar'), terminado ? null : f.alternar),
                  if (r.empezado && !terminado) _Boton(Icons.more_time, '+5 min', f.masTiempo),
                  if (esquema && r.empezado) _Boton(Icons.record_voice_over_outlined, 'Pasar a exponer', f.pasarAExponer),
                ]),
              ),
            ]);
          }),
      ),
    );
  }
}

class _Boton extends StatelessWidget {
  const _Boton(this.icono, this.texto, this.onPressed);
  final IconData icono;
  final String texto;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          disabledForegroundColor: Colors.white38,
          side: const BorderSide(color: Colors.white38),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        ),
        onPressed: onPressed,
        icon: Icon(icono),
        label: Text(texto, style: const TextStyle(fontSize: 16)),
      );
}
