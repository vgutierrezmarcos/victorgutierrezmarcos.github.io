import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../core/constants.dart';
import '../../data/models/oposicion.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Primera pantalla cuando hay varias oposiciones: «¿A qué te presentas?».
/// Va antes de crear los servicios, así que no usa Riverpod.
class ElegirOposicionApp extends StatelessWidget {
  const ElegirOposicionApp({super.key, required this.alElegir});
  final Future<void> Function(Oposicion) alElegir;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: Creditos.nombreApp,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.claro,
        locale: const Locale('es'),
        supportedLocales: const [Locale('es')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: _ElegirOposicionPage(alElegir: alElegir),
      );
}

class _ElegirOposicionPage extends StatefulWidget {
  const _ElegirOposicionPage({required this.alElegir});
  final Future<void> Function(Oposicion) alElegir;

  @override
  State<_ElegirOposicionPage> createState() => _ElegirOposicionPageState();
}

class _ElegirOposicionPageState extends State<_ElegirOposicionPage> {
  bool _cargando = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const BarraWeb(title: Text(Creditos.nombreApp), subtitulo: 'Tu oposición, en el bolsillo', conTema: false),
        body: _cargando
            ? const Cargando()
            : ListaAdaptable(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
                children: [
                  const TituloSeccion('¿A qué te presentas?'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text('Cada oposición tiene su temario, sus cantes y sus preparadores. Podrás cambiarla cuando quieras en Más → Ajustes.', style: context.textos.bodySmall),
                  ),
                  for (final o in Oposiciones.todas)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TarjetaOposicion(
                        oposicion: o,
                        onTap: () async {
                          setState(() => _cargando = true);
                          await widget.alElegir(o);
                        },
                      ),
                    ),
                ],
              ),
      );
}

/// Una oposición para elegir: siglas, nombre y lo que se canta.
class TarjetaOposicion extends StatelessWidget {
  const TarjetaOposicion({super.key, required this.oposicion, this.onTap, this.elegida = false});
  final Oposicion oposicion;
  final VoidCallback? onTap;
  final bool elegida;

  @override
  Widget build(BuildContext context) {
    final cantados = oposicion.conTemasCantados.map((e) => e.corto).join(' y ');
    return Tarjeta(
      onTap: onTap,
      color: elegida ? context.colores.primarioPalido : null,
      child: Row(children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(oposicion.siglas, style: context.textos.headlineSmall?.copyWith(color: context.esquema.primary)),
            Text(oposicion.nombre, style: context.textos.titleSmall),
            const SizedBox(height: 2),
            Text(
              [
                '${oposicion.ejercicios.length} ejercicios',
                'se canta el $cantados',
                if (oposicion.testVoluntario) 'test voluntario',
              ].join(' · '),
              style: context.textos.labelSmall,
            ),
          ]),
        ),
        Icon(elegida ? Icons.check_circle : Icons.chevron_right, color: context.esquema.primary),
      ]),
    );
  }
}
