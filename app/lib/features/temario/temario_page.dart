import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'tema_page.dart';

/// Temario: ejercicios → partes → temas, con estado de estudio y descarga offline.
class TemarioPage extends ConsumerStatefulWidget {
  const TemarioPage({super.key});
  @override
  ConsumerState<TemarioPage> createState() => _TemarioPageState();
}

class _TemarioPageState extends ConsumerState<TemarioPage> {
  String _busqueda = '';

  @override
  Widget build(BuildContext context) {
    final temario = ref.watch(temarioProvider);
    final ajustes = ref.watch(ajustesProvider);
    final descargas = ref.watch(descargasProvider);
    final notas = ref.read(usuarioRepoProvider).todasLasNotas();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Temario'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar tema (p. ej. 3A7, Keynes, IVA)…',
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                suffixIcon: _busqueda.isEmpty ? null : IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() => _busqueda = '')),
              ),
              onChanged: (v) => setState(() => _busqueda = v),
            ),
          ),
        ),
      ),
      body: temario.when(
        loading: () => const Cargando(),
        error: (e, _) => ErrorVista(error: e, reintentar: () => ref.invalidate(temarioProvider)),
        data: (t) {
          if (_busqueda.trim().isNotEmpty) {
            final q = _normalizar(_busqueda);
            final res = t.todosLosTemas.where((x) => _normalizar('${x.codigo} ${x.titulo}').contains(q) || _normalizar(x.codigo.replaceAll('.', '')).contains(q.replaceAll('.', '').replaceAll(' ', ''))).toList();
            return ListView(padding: const EdgeInsets.all(16), children: [
              Text('${res.length} resultados', style: context.textos.bodySmall),
              for (final x in res) _filaTema(x, ajustes.temasEstudiados.contains(x.codigo), ajustes.temasEnRepaso.contains(x.codigo), x.url != null && descargas.descargado(x.url!), notas.containsKey(x.codigo)),
            ]);
          }
          final total = t.todosLosTemas.where((x) => x.disponible).length;
          final estudiados = ajustes.temasEstudiados.length;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            children: [
              Tarjeta(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Text('Progreso: $estudiados temas marcados como estudiados', style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
                    Text('${total == 0 ? 0 : (100 * estudiados / total).round()} %', style: context.textos.titleMedium?.copyWith(color: context.esquema.primary)),
                  ]),
                  const SizedBox(height: 8),
                  ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: total == 0 ? 0 : estudiados / total, minHeight: 8, backgroundColor: context.colores.fondoClaro)),
                ]),
              ),
              for (final ej in t.ejercicios) ...[
                TituloSeccion(ej.nombre),
                Text(ej.descripcion, style: context.textos.bodySmall),
                const SizedBox(height: 8),
                if (ej.id == 2)
                  Tarjeta(onTap: () => abrirUrl(context, ej.urlPagina, enApp: true), child: Row(children: [Expanded(child: Text('Descripción de la prueba de idiomas en la web', style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))), const Icon(Icons.open_in_new, size: 18)])),
                for (final r in ej.recursos) _filaRecurso(r, descargas.descargado(r.url)),
                for (final p in ej.partes)
                  if (p.temas.isEmpty)
                    _filaParte(p, p.url != null && descargas.descargado(p.url!))
                  else
                    Tarjeta(
                      padding: EdgeInsets.zero,
                      child: ExpansionTile(
                        title: Text('Parte ${p.letra}: ${p.nombre}', style: context.textos.titleSmall),
                        subtitle: Text('${p.temas.where((x) => ajustes.temasEstudiados.contains(x.codigo)).length} de ${p.temas.length} estudiados · ${p.temas.where((x) => x.disponible).length} con PDF', style: context.textos.labelSmall),
                        children: [
                          for (final x in p.temas) _filaTema(x, ajustes.temasEstudiados.contains(x.codigo), ajustes.temasEnRepaso.contains(x.codigo), x.url != null && descargas.descargado(x.url!), notas.containsKey(x.codigo)),
                        ],
                      ),
                    ),
              ],
              const TituloSeccion('Organización'),
              for (final r in t.organizacion) _filaRecurso(r, descargas.descargado(r.url)),
            ],
          );
        },
      ),
    );
  }

  Widget _filaTema(Tema x, bool estudiado, bool repaso, bool offline, bool conNota) {
    return ListTile(
      dense: true,
      enabled: x.disponible,
      leading: IconButton(
        icon: Icon(estudiado ? Icons.check_circle : Icons.circle_outlined, color: estudiado ? Paleta.acierto : context.colores.textoClaro),
        tooltip: 'Estudiado',
        onPressed: () => ref.read(ajustesProvider.notifier).alternarEstudiado(x.codigo),
      ),
      title: Text('${x.codigo} · ${x.titulo}', maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: x.disponible ? context.esquema.onSurface : context.colores.textoClaro)),
      subtitle: !x.disponible
          ? Text('No disponible', style: context.textos.labelSmall)
          : Row(children: [
              if (x.temarioAnterior) Padding(padding: const EdgeInsets.only(right: 6), child: Etiqueta('Temario anterior', color: context.colores.dorado)),
              if (offline) Icon(Icons.offline_pin, size: 14, color: context.colores.textoClaro),
              if (repaso) Padding(padding: const EdgeInsets.only(left: 4), child: Icon(Icons.replay, size: 14, color: context.esquema.primary)),
              if (conNota) Padding(padding: const EdgeInsets.only(left: 4), child: Icon(Icons.sticky_note_2_outlined, size: 14, color: context.colores.dorado)),
            ]),
      onTap: x.disponible ? () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => TemaPage(tema: x))) : null,
    );
  }

  Widget _filaParte(Parte p, bool offline) => Tarjeta(
        padding: EdgeInsets.zero,
        child: ListTile(
          enabled: p.disponible,
          leading: Icon(Icons.picture_as_pdf_outlined, color: p.disponible ? context.esquema.primary : context.colores.textoClaro),
          title: Text('Parte ${p.letra}: ${p.nombre}', style: context.textos.titleSmall),
          subtitle: Text(p.disponible ? (offline ? 'Descargado' : 'PDF completo de la parte') : 'No disponible', style: context.textos.labelSmall),
          onTap: p.disponible
              ? () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => TemaPage(tema: Tema(codigo: '5.${p.letra}', titulo: p.nombre, disponible: true, temarioAnterior: true, url: p.url))))
              : null,
        ),
      );

  Widget _filaRecurso(Recurso r, bool offline) => Tarjeta(
        padding: EdgeInsets.zero,
        child: ListTile(
          leading: Icon(switch (r.tipo) { 'pdf' => Icons.picture_as_pdf_outlined, 'app' => Icons.web, 'xlsm' => Icons.table_chart_outlined, _ => Icons.description_outlined }, color: context.esquema.primary),
          title: Text(r.titulo, style: context.textos.titleSmall),
          subtitle: r.descripcion.isEmpty ? null : Text(r.descripcion, style: context.textos.labelSmall),
          trailing: r.tipo == 'pdf' ? null : const Icon(Icons.open_in_new, size: 18),
          onTap: () {
            if (r.tipo == 'pdf') {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => TemaPage(tema: Tema(codigo: r.id, titulo: r.titulo, disponible: true, temarioAnterior: false, url: r.url), esRecurso: true)));
            } else {
              abrirUrl(context, r.url);
            }
          },
        ),
      );
}

String _normalizar(String s) => s
    .toLowerCase()
    .replaceAll(RegExp('[áàä]'), 'a')
    .replaceAll(RegExp('[éèë]'), 'e')
    .replaceAll(RegExp('[íìï]'), 'i')
    .replaceAll(RegExp('[óòö]'), 'o')
    .replaceAll(RegExp('[úùü]'), 'u');
