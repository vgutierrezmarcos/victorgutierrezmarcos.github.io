import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/estructura.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../temario/abrir_tema.dart';

/// Un bloque del temario: sus temas con la idea clave de cada uno, el avance
/// del opositor y las conexiones del bloque con el resto del temario.
class BloquePage extends ConsumerWidget {
  const BloquePage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final e = ref.watch(estructuraProvider).value ?? EstructuraTemario.vacia;
    final b = e.bloque(id);
    final temario = ref.watch(temarioProvider).value;
    final estudiados = ref.watch(ajustesProvider.select((a) => a.temasEstudiados));
    if (b == null) return Scaffold(appBar: BarraWeb(title: const Text('Bloque')), body: const Center(child: Text('Bloque no encontrado.')));

    final hechos = b.temas.where(estudiados.contains).length;
    final conexiones = e.conexionesDeBloque(id);
    bool dentro(Extremo x) => x.esTema ? b.temas.contains(x.tema) : x.bloque == id;
    final siguientes = e.sugeridos(estudiados).where(b.temas.contains).toList();

    Widget extremo(Extremo x) {
      if (x.esTema) return CasillaTema(x.tema!, color: e.colorDe(x.tema!) ?? context.esquema.primary, onTap: () => abrirTema(context, temario, x.tema!));
      final otro = e.bloque(x.bloque!);
      return GestureDetector(
        onTap: x.bloque == id ? null : () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BloquePage(id: x.bloque!))),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(border: Border.all(color: otro?.color ?? context.colores.borde, width: 1.5), borderRadius: BorderRadius.circular(3)),
          child: Text(x.bloque == id ? 'Todo el bloque' : (otro?.nombre ?? ''), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 12, fontWeight: FontWeight.w600, color: context.esquema.onSurface)),
        ),
      );
    }

    return Scaffold(
      appBar: BarraWeb(title: const Text('Bloque')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          // Cabecera con el color del bloque, como su caja en el PowerPoint.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(color: b.color, borderRadius: BorderRadius.circular(8), boxShadow: context.sombraSuave),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(b.categoria.toUpperCase(), style: TextStyle(fontFamily: Fuentes.sans, fontSize: 11.5, fontWeight: FontWeight.w600, letterSpacing: 0.8, color: textoSobre(b.color).withValues(alpha: 0.85))),
              Text(b.nombre, style: TextStyle(fontFamily: Fuentes.serif, fontSize: 21, fontWeight: FontWeight.w700, height: 1.2, color: textoSobre(b.color))),
              const SizedBox(height: 4),
              Text('$hechos de ${b.temas.length} temas estudiados', style: TextStyle(fontFamily: Fuentes.sans, fontSize: 13.5, color: textoSobre(b.color))),
            ]),
          ),
          const SizedBox(height: 6),
          ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: b.temas.isEmpty ? 0 : hechos / b.temas.length, minHeight: 6)),
          if (siguientes.isNotEmpty) ...[
            const SizedBox(height: 12),
            Tarjeta(
              color: context.colores.primarioPalido,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Por dónde seguir', style: context.textos.titleMedium),
                Text('De este bloque, conectan con temas que ya te sabes:', style: context.textos.bodySmall),
                const SizedBox(height: 8),
                Wrap(spacing: 6, runSpacing: 6, children: [for (final t in siguientes) CasillaTema(t, color: b.color, grande: true, onTap: () => abrirTema(context, temario, t))]),
              ]),
            ),
          ],
          const TituloSeccion('Temas del bloque'),
          Material(
            color: context.colores.superficie,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: context.colores.borde)),
            clipBehavior: Clip.antiAlias,
            child: Column(children: [
              for (var i = 0; i < b.temas.length; i++)
                DecoratedBox(
                  decoration: BoxDecoration(border: i == b.temas.length - 1 ? null : Border(bottom: BorderSide(color: context.colores.bordeClaro))),
                  child: ListTile(
                    dense: true,
                    leading: IconButton(
                      icon: Icon(estudiados.contains(b.temas[i]) ? Icons.check_circle : Icons.circle_outlined, color: estudiados.contains(b.temas[i]) ? Paleta.acierto : context.colores.textoClaro),
                      tooltip: 'Estudiado',
                      onPressed: () => ref.read(ajustesProvider.notifier).alternarEstudiado(b.temas[i]),
                    ),
                    title: TextoTema(b.temas[i], temario?.tema(b.temas[i])?.titulo ?? '', color: b.color),
                    subtitle: e.ideas[b.temas[i]] == null
                        ? null
                        : Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(e.ideas[b.temas[i]]!, style: TextStyle(fontFamily: Fuentes.serif, fontStyle: FontStyle.italic, fontSize: 13.5, height: 1.3, color: context.colores.textoSuave)),
                          ),
                    onTap: () => abrirTema(context, temario, b.temas[i]),
                  ),
                ),
            ]),
          ),
          if (conexiones.isNotEmpty) ...[
            const TituloSeccion('Conexiones con el resto del temario'),
            Tarjeta(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Column(children: [
                for (final c in conexiones)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Builder(builder: (context) {
                      // Siempre se pinta primero el extremo que pertenece a este bloque.
                      final mio = dentro(c.de) ? c.de : c.a;
                      final otro = c.otro(mio);
                      final haciaFuera = mio == c.de ? c.flechaA : c.flechaDe;
                      final haciaDentro = mio == c.de ? c.flechaDe : c.flechaA;
                      final bloqueOtro = otro.esTema ? e.bloqueDe(otro.tema!) : null;
                      return Row(children: [
                        extremo(mio),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(haciaFuera && haciaDentro ? Icons.sync_alt : (haciaDentro ? Icons.arrow_back : (haciaFuera ? Icons.arrow_forward : Icons.remove)), size: 16, color: context.colores.textoSuave),
                        ),
                        // Un tema lleva al lado el nombre de su bloque; un bloque ocupa el resto de la fila.
                        if (otro.esTema) ...[
                          extremo(otro),
                          const SizedBox(width: 8),
                          Expanded(child: Text(bloqueOtro?.nombre ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.labelSmall)),
                        ] else
                          Expanded(child: Align(alignment: Alignment.centerLeft, child: extremo(otro))),
                      ]);
                    }),
                  ),
              ]),
            ),
            Padding(padding: const EdgeInsets.only(top: 4), child: Text('Toca un tema para abrirlo.', style: context.textos.labelSmall)),
          ],
        ],
      ),
    );
  }
}
