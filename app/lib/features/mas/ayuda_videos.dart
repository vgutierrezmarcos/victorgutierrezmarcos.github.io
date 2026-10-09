import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants.dart';
import '../../core/providers.dart';
import '../../data/models/preparador.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Vídeo de ayuda de menos de un minuto: está en la página de la app
/// (app/index.html, sección «Cómo se usa») y se monta con
/// scripts/montar-videos-ayuda.py (guiones en app/promo/ayuda/GUIONES.md).
class VideoAyuda {
  const VideoAyuda(this.id, this.titulo, this.texto, this.papel);
  final String id;
  final String titulo;
  final String texto;
  final Papel papel;
}

const videosAyuda = [
  VideoAyuda('reservar-clase', 'Reserva clase con tu preparador', 'Elige un hueco libre de tu preparador y pídele la clase', Papel.opositor),
  VideoAyuda('clase-suelta', '¿Te cancelan? Pide una clase suelta', 'Otro preparador verificado te coge el cante', Papel.opositor),
  VideoAyuda('conectar-preparador', 'Conecta con tu preparador', 'Su código de seis letras, y qué ve y qué no', Papel.opositor),
  VideoAyuda('buscar-preparador', 'Busca preparador', 'Quién admite alumnos y cómo contar lo que buscas', Papel.opositor),
  VideoAyuda('cronograma', 'Tu cronograma', 'Planifica la vuelta y mira cada semana lo que te toca', Papel.opositor),
  VideoAyuda('clase', 'La clase con tu preparador', 'Meet, los temas mandados, el cronómetro compartido y la pizarra', Papel.opositor),
  VideoAyuda('empezar-preparador', 'Empieza como preparador', 'Date de alta, verifícate y pasa tu código', Papel.preparador),
  VideoAyuda('huecos-reservas', 'Abre huecos y acepta reservas', 'Ofrece tus huecos libres y acepta lo que te piden', Papel.preparador),
  VideoAyuda('programar-clase', 'Programa una clase y manda los temas', 'La clase, la reunión de Meet y los temas antes, a su hora', Papel.preparador),
  VideoAyuda('coger-clase', 'Coge una clase suelta', 'El tablón de clases sueltas y cómo coger una', Papel.preparador),
  VideoAyuda('materiales', 'Comparte materiales', 'Enlaces de Drive, PDF o vídeos para tus alumnos', Papel.preparador),
];

/// Abre el vídeo [id] en la página de la app.
Future<void> verVideoAyuda(BuildContext context, String id) => abrirUrl(context, Urls.videoAyuda(id));

/// Botón de la cabecera de una pantalla que abre su vídeo de ayuda.
class BotonVideoAyuda extends StatelessWidget {
  const BotonVideoAyuda(this.id, {super.key});
  final String id;

  @override
  Widget build(BuildContext context) =>
      IconButton(tooltip: 'Ver el vídeo: cómo se hace', icon: const Icon(Icons.play_circle_outline), onPressed: () => verVideoAyuda(context, id));
}

/// Más → Ayuda en vídeo: todos los vídeos, primero los del papel del usuario.
class AyudaVideosPage extends ConsumerWidget {
  const AyudaVideosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final papel = ref.watch(papelProvider);
    final otro = papel == Papel.opositor ? Papel.preparador : Papel.opositor;
    String titulo(Papel p) => p == Papel.opositor ? 'Si te preparas la oposición' : 'Si preparas a opositores';
    List<Widget> grupo(Papel p) => [
          TituloSeccion(titulo(p)),
          for (final v in videosAyuda.where((v) => v.papel == p))
            FilaEnlace(icono: Icons.play_circle_outline, titulo: v.titulo, subtitulo: v.texto, onTap: () => verVideoAyuda(context, v.id)),
        ];
    return Scaffold(
      appBar: const BarraWeb(title: Text('Ayuda en vídeo')),
      body: ListaAdaptable(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          Text('Cada cosa, en un vídeo de menos de un minuto. Se abren en la página de la app.', style: context.textos.bodySmall),
          ...grupo(papel),
          ...grupo(otro),
        ],
      ),
    );
  }
}
