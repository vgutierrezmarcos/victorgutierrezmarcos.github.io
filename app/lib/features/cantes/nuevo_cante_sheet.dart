import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/oposicion.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/cante_form_page.dart';
import '../preparador/reservas.dart';
import '../preparador/sustituciones.dart';

/// El «+» de la agenda de cantes: qué se puede añadir y para qué sirve cada
/// cosa (un cante por cuenta propia, reservar clase con el preparador o pedir
/// una clase suelta a otro), sin tener que ir a «Más».
Future<void> mostrarHojaNuevoCante(BuildContext context, WidgetRef ref, {DateTime? dia}) {
  final usuario = ref.read(usuarioActualProvider);
  final firebase = ref.read(serviciosProvider).firebaseDisponible;
  final vinculos = ref.read(misPreparadoresProvider);
  // Preparadores conectados que admiten reservas.
  final conHuecos = [for (final v in vinculos) if (ref.read(huecosDeProvider(v.uid)).valueOrNull?.activo ?? false) v];
  void ir(Widget w) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => w));

  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (d) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('¿Qué quieres apuntar?', style: d.textos.titleLarge),
          const SizedBox(height: 10),
          FilaEnlace(
            icono: Icons.record_voice_over_outlined,
            titulo: 'Un cante por mi cuenta',
            subtitulo: 'Solo o con quien quieras: día, hora y temas que entran. Con cuenta atrás y aviso.',
            onTap: () {
              Navigator.pop(d);
              ir(CanteFormPage(diaInicial: dia));
            },
          ),
          FilaEnlace(
            icono: Icons.event_available_outlined,
            titulo: 'Reservar clase con mi preparador',
            subtitulo: vinculos.isEmpty
                ? 'Primero conecta con tu preparador con su código (en Mi preparador).'
                : conHuecos.isEmpty
                    ? 'Tu preparador no tiene abiertas las reservas: habla con él para fijar la clase.'
                    : 'Eliges uno de sus huecos libres y él la confirma.',
            onTap: () {
              Navigator.pop(d);
              if (vinculos.isEmpty) {
                context.go('/mas/mi-preparador');
              } else if (conHuecos.isNotEmpty) {
                ir(ReservarPage(preparador: conHuecos.first));
              } else {
                context.go('/mas/mi-preparador');
              }
            },
          ),
          if (firebase)
            FilaEnlace(
              icono: Icons.campaign_outlined,
              titulo: 'Pedir una clase suelta',
              subtitulo: usuario == null
                  ? 'Inicia sesión con Google para pedirla a los preparadores verificados de ${Oposiciones.actual.siglas}.'
                  : 'Si te cancelan o quieres un cante extra: la ven los preparadores verificados y uno te la coge.',
              onTap: () {
                Navigator.pop(d);
                usuario == null ? context.go('/mas/cuenta') : ir(const PedirSustitucionPage());
              },
            ),
        ]),
      ),
    ),
  );
}

/// Tarjeta de ayuda de una subpestaña de Cantes: se puede cerrar y vuelve a
/// salir desde el icono de ayuda de la barra.
class TarjetaAyudaCantes extends ConsumerWidget {
  const TarjetaAyudaCantes({super.key, required this.clave, required this.icono, required this.titulo, required this.texto});
  final String clave;
  final IconData icono;
  final String titulo;
  final String texto;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(ayudaVistaProvider(clave))) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Tarjeta(
        color: context.colores.dorado.withValues(alpha: 0.12),
        padding: const EdgeInsets.fromLTRB(14, 10, 4, 10),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icono, color: context.colores.dorado),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(titulo, style: context.textos.titleSmall),
              Text(texto, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
            ]),
          ),
          IconButton(tooltip: 'Entendido', icon: const Icon(Icons.close, size: 18), onPressed: () => ref.read(ayudaVistaProvider(clave).notifier).marcar()),
        ]),
      ),
    );
  }
}

/// Textos de ayuda de cada subpestaña de Cantes, por papel.
const ayudasCantes = {
  'agenda': ('Tu agenda de cantes', 'Aquí están tus cantes y las clases que te programa tu preparador, con cuenta atrás y aviso la víspera. Con «+» apuntas un cante, reservas clase o pides una clase suelta.'),
  'cantar': ('Cantar un tema', 'Saca bola (como en el examen o de tu bolsa), haz el esquema con el cronómetro, expón, grábate para escucharte y guarda cómo fue en el diario. En una clase, tu preparador manda los temas y podéis compartir el cronómetro y la pizarra.'),
  'diario': ('Tu diario', 'Cada cante que guardas: qué tema, cuánto tardaste y cómo fue. Aquí ves tus temas flojos y las valoraciones de tu preparador.'),
  'clases': ('Tus clases', 'Tu semana con tus alumnos. Toca una clase para cambiarla al momento (hora, duración, enlace de la reunión), mandar los temas antes o sortearlos en clase.'),
  'cantar_preparador': ('Cantar con un alumno', 'Desde la ficha de una clase: sorteas los temas que lleva el alumno, cronometras el esquema y la exposición y guardas la valoración en su ficha. Con el alumno enlazado, compartís cronómetro y pizarra.'),
};

/// Vuelve a mostrar todas las tarjetas de ayuda de Cantes.
void mostrarAyudasCantes(WidgetRef ref) {
  for (final k in ayudasCantes.keys) {
    ref.read(ayudaVistaProvider(k).notifier).reponer();
  }
}
