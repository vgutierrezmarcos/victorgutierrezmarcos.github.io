import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../core/constants.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/preparador.dart';
import '../../theme/app_theme.dart';

/// Primera pantalla cuando hay varias oposiciones: «¿A qué te presentas?» y,
/// después, «¿Cómo vas a usar la app?» (opositor o preparador en esa
/// oposición). Va antes de crear los servicios, así que no usa Riverpod.
/// Estética neutra ([PaletaNeutra]); cada tarjeta, con la de su oposición.
class ElegirOposicionApp extends StatelessWidget {
  const ElegirOposicionApp({super.key, required this.alElegir});
  final Future<void> Function(Oposicion, Papel) alElegir;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: Creditos.nombreApp,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: PaletaNeutra.tinta, surface: PaletaNeutra.fondo),
          scaffoldBackgroundColor: PaletaNeutra.fondo,
          fontFamily: PaletaMarca.tcee.sans,
        ),
        locale: const Locale('es'),
        supportedLocales: const [Locale('es')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: _ElegirOposicionPage(alElegir: alElegir),
      );
}

class _ElegirOposicionPage extends StatefulWidget {
  const _ElegirOposicionPage({required this.alElegir});
  final Future<void> Function(Oposicion, Papel) alElegir;

  @override
  State<_ElegirOposicionPage> createState() => _ElegirOposicionPageState();
}

class _ElegirOposicionPageState extends State<_ElegirOposicionPage> {
  bool _cargando = false;
  /// Oposición elegida en el primer paso (null mientras no la elige).
  Oposicion? _oposicion;

  Future<void> _elegirPapel(Papel papel) async {
    setState(() => _cargando = true);
    await widget.alElegir(_oposicion!, papel);
  }

  List<Widget> _pasoOposicion(String serif) => [
        ..._cabeceraPaso(serif, '¿Qué oposición?', 'Cada oposición tiene su temario, sus cantes y sus preparadores. Podrás cambiarla cuando quieras en Más → Ajustes.'),
        for (final o in Oposiciones.disponibles)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: TarjetaOposicion(oposicion: o, onTap: () => setState(() => _oposicion = o)),
          ),
      ];

  List<Widget> _pasoPapel(String serif, Oposicion o) => [
        ..._cabeceraPaso(serif, '¿Cómo vas a usar la app?', 'En ${o.siglas} puedes ser opositor o preparador. Si en otra oposición tienes el otro papel, lo eliges al cambiar a ella. Se cambia en Más → Ajustes.'),
        TarjetaPapel(
          icono: Icons.school_outlined,
          titulo: 'Me preparo la oposición',
          texto: 'El temario, el test, tus cantes, tu cronograma y, si tienes, tu preparador.',
          onTap: () => _elegirPapel(Papel.opositor),
        ),
        const SizedBox(height: 12),
        TarjetaPapel(
          icono: Icons.groups_outlined,
          titulo: 'Preparo a opositores',
          texto: 'Tus alumnos y sus clases, las clases sueltas de otros alumnos y el temario para consultarlo.',
          onTap: () => _elegirPapel(Papel.preparador),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => setState(() => _oposicion = null),
            icon: const Icon(Icons.arrow_back, size: 18, color: PaletaNeutra.tinta),
            label: const Text('Otra oposición', style: TextStyle(color: PaletaNeutra.tinta)),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final serif = PaletaMarca.tcee.serif;
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        // Cabecera: berenjena con la línea dorada, el logo y el nombre.
        Container(
          decoration: const BoxDecoration(gradient: LinearGradient(colors: [PaletaNeutra.tinta, PaletaNeutra.tintaClara])),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
              child: Row(children: [
                ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset('assets/icon/icon.png', width: 44, height: 44)),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(Creditos.nombreApp, style: TextStyle(fontFamily: serif, fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('Tu oposición, en el bolsillo', style: TextStyle(fontFamily: serif, fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white.withValues(alpha: 0.85))),
                  ]),
                ),
              ]),
            ),
          ),
        ),
        Container(
          height: 4,
          decoration: const BoxDecoration(gradient: LinearGradient(colors: [PaletaNeutra.dorado, PaletaNeutra.doradoClaro, PaletaNeutra.dorado])),
        ),
        Expanded(
          child: _cargando
              ? const Center(child: CircularProgressIndicator(color: PaletaNeutra.tinta))
              : Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: ListView(padding: const EdgeInsets.fromLTRB(20, 28, 20, 32), children: _oposicion == null ? _pasoOposicion(serif) : _pasoPapel(serif, _oposicion!)),
                  ),
                ),
        ),
      ]),
    );
  }
}

/// Título de cada paso, con el filete dorado y la explicación.
List<Widget> _cabeceraPaso(String serif, String titulo, String texto) => [
      Text(titulo, style: TextStyle(fontFamily: serif, fontSize: 26, fontWeight: FontWeight.w700, color: PaletaNeutra.texto)),
      const SizedBox(height: 6),
      Align(alignment: Alignment.centerLeft, child: Container(width: 64, height: 3, color: PaletaNeutra.dorado)),
      const SizedBox(height: 14),
      Text(texto, style: const TextStyle(fontSize: 15, height: 1.4, color: PaletaNeutra.textoSuave)),
      const SizedBox(height: 22),
    ];

/// Una oposición para elegir, con la estética de su web: sus colores, su
/// tipografía, sus siglas y su nombre.
class TarjetaOposicion extends StatelessWidget {
  const TarjetaOposicion({super.key, required this.oposicion, this.onTap, this.elegida = false});
  final Oposicion oposicion;
  final VoidCallback? onTap;
  final bool elegida;

  @override
  Widget build(BuildContext context) {
    final m = PaletaMarca.de(oposicion.id);
    // Texto sobre el color de la oposición: su color claro (verde salvia en
    // TCEE, crema en DCE).
    final claro = m.fondo;
    final radio = BorderRadius.circular(12);
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [m.primarioClaro, m.primario, m.primarioOscuro]),
          borderRadius: radio,
          border: elegida ? Border.all(color: PaletaNeutra.doradoClaro, width: 3) : null,
          boxShadow: [BoxShadow(color: m.primarioOscuro.withValues(alpha: 0.25), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: radio,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 16, 18),
            child: Row(children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(oposicion.siglas, style: TextStyle(fontFamily: m.serif, fontSize: 30, fontWeight: FontWeight.w700, color: claro, height: 1.1)),
                  const SizedBox(height: 4),
                  Container(width: 40, height: 2, color: claro.withValues(alpha: 0.7)),
                  const SizedBox(height: 8),
                  Text(oposicion.nombre, style: TextStyle(fontFamily: m.serif, fontSize: 16, color: Colors.white, height: 1.25)),
                  if (!oposicion.lanzada)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text('Aún sin lanzar: solo la ven sus administradores', style: TextStyle(fontFamily: m.sans, fontSize: 12, color: claro.withValues(alpha: 0.85))),
                    ),
                ]),
              ),
              Icon(elegida ? Icons.check_circle : Icons.arrow_forward, color: claro),
            ]),
          ),
        ),
      ),
    );
  }
}

/// Un papel para elegir (opositor o preparador), en la estética neutra.
class TarjetaPapel extends StatelessWidget {
  const TarjetaPapel({super.key, required this.icono, required this.titulo, required this.texto, required this.onTap, this.elegida = false});
  final IconData icono;
  final String titulo;
  final String texto;
  final VoidCallback onTap;
  final bool elegida;

  @override
  Widget build(BuildContext context) {
    final radio = BorderRadius.circular(12);
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: radio, side: BorderSide(color: elegida ? PaletaNeutra.dorado : PaletaNeutra.tinta.withValues(alpha: 0.15), width: elegida ? 2 : 1)),
      child: InkWell(
        onTap: onTap,
        borderRadius: radio,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 14, 16),
          child: Row(children: [
            Icon(icono, size: 30, color: PaletaNeutra.tinta),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(titulo, style: TextStyle(fontFamily: PaletaMarca.tcee.serif, fontSize: 18, fontWeight: FontWeight.w700, color: PaletaNeutra.texto)),
                const SizedBox(height: 4),
                Text(texto, style: const TextStyle(fontSize: 14, height: 1.35, color: PaletaNeutra.textoSuave)),
              ]),
            ),
            Icon(elegida ? Icons.check_circle : Icons.arrow_forward, color: PaletaNeutra.tinta),
          ]),
        ),
      ),
    );
  }
}
