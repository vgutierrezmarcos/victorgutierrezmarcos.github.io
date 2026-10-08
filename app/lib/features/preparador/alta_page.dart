import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/preparador.dart';
import '../../data/models/red.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Alta como preparador en un solo paso: qué es ser preparador en la app y el
/// formulario que fija el papel de preparador y pide la verificación a la vez.
/// Con [soloVerificacion] (ya es preparador pero no la ha pedido) solo pide la
/// verificación.
class AltaPreparadorPage extends ConsumerStatefulWidget {
  const AltaPreparadorPage({super.key, this.soloVerificacion = false});
  final bool soloVerificacion;

  @override
  ConsumerState<AltaPreparadorPage> createState() => _AltaPreparadorPageState();
}

class _AltaPreparadorPageState extends ConsumerState<AltaPreparadorPage> {
  late final TextEditingController _nombre;
  late final TextEditingController _telefono;
  late final TextEditingController _linkedin;
  final _presentacion = TextEditingController();
  late final TextEditingController _ciudad;
  String _modalidad = '';
  final _ejercicios = {for (final e in Oposiciones.actual.conTemasCantados) e.numero};
  /// A quién se pide la verificación: null = a cualquier verificado.
  PreparadorVerificado? _destinatario;
  bool _enviando = false;

  @override
  void initState() {
    super.initState();
    final perfil = ref.read(perfilPreparadorProvider);
    _nombre = TextEditingController(text: perfil.nombre.isNotEmpty ? perfil.nombre : (ref.read(usuarioActualProvider)?.displayName ?? ''));
    _telefono = TextEditingController(text: perfil.telefono);
    _linkedin = TextEditingController(text: perfil.linkedin);
    _ciudad = TextEditingController(text: perfil.ciudad);
    _modalidad = perfil.modalidad;
  }

  @override
  void dispose() {
    for (final c in [_nombre, _telefono, _linkedin, _presentacion, _ciudad]) {
      c.dispose();
    }
    super.dispose();
  }

  bool get _linkedinValido => _linkedin.text.trim().isEmpty || enlaceLinkedin(_linkedin.text) != null;
  bool get _completo => _nombre.text.trim().isNotEmpty && _ejercicios.isNotEmpty && _linkedinValido;

  /// Al pasar a preparador se deja de compartir con los preparadores propios.
  Future<bool> _confirmarVinculos() async {
    final vinculos = ref.read(misPreparadoresProvider);
    if (vinculos.isEmpty || widget.soloVerificacion) return true;
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: Text('Preparador en ${Oposiciones.actual.siglas}'),
        content: Text('En una misma oposición no se puede ser alumno y preparador. Dejarás de compartir tu progreso con ${vinculos.map((v) => v.nombre.isEmpty ? 'tu preparador' : v.nombre).join(', ')}. Tus temas, cantes y tests se quedan guardados.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Seguir')),
        ],
      ),
    );
    return ok == true;
  }

  Future<void> _enviar() async {
    if (!await _confirmarVinculos() || !mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final navegador = Navigator.of(context);
    setState(() => _enviando = true);
    try {
      final notifier = ref.read(perfilPreparadorProvider.notifier);
      await notifier.fijarPapel(Papel.preparador);
      final linkedin = _linkedin.text.trim().isEmpty ? '' : enlaceLinkedin(_linkedin.text)!;
      final ciudad = _modalidad == 'online' ? '' : _ciudad.text.trim();
      await notifier.guardar(ref.read(perfilPreparadorProvider).copyWith(telefono: _telefono.text.trim(), linkedin: linkedin, modalidad: _modalidad, ciudad: ciudad));
      if (_nombre.text.trim() != ref.read(perfilPreparadorProvider).nombre) await notifier.renombrar(_nombre.text);
      await ref.read(redRepoProvider).solicitar(
            nombre: _nombre.text,
            ejercicios: _ejercicios.toList()..sort(),
            presentacion: _presentacion.text,
            linkedin: linkedin,
            modalidad: _modalidad,
            ciudad: ciudad,
            destinatario: _destinatario?.uid,
            destinatarioNombre: _destinatario?.nombre ?? '',
          );
      ref.invalidate(estadoRedProvider);
      messenger.showSnackBar(const SnackBar(content: Text('Solicitud enviada. Te avisaremos cuando te verifiquen.')));
      navegador.pop();
    } catch (e) {
      if (mounted) setState(() => _enviando = false);
      messenger.showSnackBar(SnackBar(content: Text('No se pudo enviar: $e')));
    }
  }

  /// Sin cuenta: preparador solo en este dispositivo, sin verificación.
  Future<void> _sinCuenta() async {
    if (!await _confirmarVinculos() || !mounted) return;
    final navegador = Navigator.of(context);
    await ref.read(perfilPreparadorProvider.notifier).fijarPapel(Papel.preparador);
    navegador.pop();
  }

  @override
  Widget build(BuildContext context) {
    final firebase = ref.watch(serviciosProvider).firebaseDisponible;
    final usuario = ref.watch(usuarioActualProvider);
    final siglas = Oposiciones.actual.siglas;
    final candidatos = (ref.watch(verificadosProvider).valueOrNull ?? const <PreparadorVerificado>[]).where((v) => v.uid != usuario?.uid).toList();
    Widget paso(int n, String titulo, String texto) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(radius: 14, backgroundColor: context.esquema.primary, child: Text('$n', style: TextStyle(fontFamily: Fuentes.sans, fontWeight: FontWeight.w700, color: Colors.white, fontSize: 13))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(titulo, style: context.textos.titleSmall),
                Text(texto, style: context.textos.bodySmall),
              ]),
            ),
          ]),
        );

    return Scaffold(
      appBar: BarraWeb(title: Text(widget.soloVerificacion ? 'Pedir la verificación' : 'Alta de preparador')),
      body: ListaAdaptable(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          if (!widget.soloVerificacion) ...[
            Text('Prepara con la app', style: context.textos.headlineSmall),
            const SizedBox(height: 6),
            Text('Lleva a tus alumnos de $siglas desde el móvil o el ordenador, y coge clases sueltas de otros alumnos cuando su preparador no puede.', style: context.textos.bodyMedium),
            const SizedBox(height: 16),
            paso(1, 'Pones tu nombre y te verifica un compañero', 'Otro preparador de $siglas ya verificado te verifica desde la app. Así ningún alumno da sus datos a quien no es preparador.'),
            paso(2, 'Das tu código a tus alumnos', 'Al escribirlo en su app, ves sus temas y sus cantes, y las clases que les programas aparecen en su agenda.'),
            paso(3, 'Llevas tus clases', 'Tu semana, la ficha de cada alumno, sacar bola y cronometrar, valorar y enviar el informe, y el tablón de clases sueltas.'),
          ],
          if (!firebase || usuario == null) ...[
            const TituloSeccion('Antes, tu cuenta'),
            Tarjeta(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  !firebase
                      ? 'Esta versión no se conecta a la red de preparadores: puedes llevar a tus alumnos solo en este dispositivo.'
                      : 'Para verificarte, dar tu código y coger clases sueltas hace falta iniciar sesión con Google. Sin cuenta, puedes llevar a tus alumnos solo en este dispositivo.',
                  style: context.textos.bodySmall,
                ),
                const SizedBox(height: 10),
                Wrap(spacing: 10, runSpacing: 8, children: [
                  if (firebase) FilledButton.icon(onPressed: () => context.go('/mas/cuenta'), icon: const Icon(Icons.login, size: 18), label: const Text('Iniciar sesión')),
                  if (!widget.soloVerificacion) OutlinedButton(onPressed: _sinCuenta, child: const Text('Empezar sin cuenta')),
                ]),
              ]),
            ),
          ] else ...[
            const SizedBox(height: 8),
            Tarjeta(
              color: context.colores.primarioPalido,
              child: Text('Solo hace falta tu nombre: lo demás es opcional. Un compañero preparador de $siglas ya verificado te verificará desde la app y te llegará el aviso.', style: context.textos.bodyMedium),
            ),
            const TituloSeccion('Tus datos'),
            TextField(controller: _nombre, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Nombre y apellidos', helperText: 'Así te verán tus alumnos y los demás preparadores'), onChanged: (_) => setState(() {})),
            const SizedBox(height: 14),
            Text('Ejercicios que preparas', style: context.textos.labelMedium),
            Wrap(spacing: 8, children: [
              for (final e in ejerciciosPreparables)
                FilterChip(label: Text(etiquetaEjercicioCante(e)), selected: _ejercicios.contains(e), onSelected: (v) => setState(() => v ? _ejercicios.add(e) : _ejercicios.remove(e))),
            ]),
            const SizedBox(height: 14),
            GrupoDesplegable(
              titulo: 'Más datos (opcional)',
              subtitulo: 'Quién eres, LinkedIn, cómo das clase, teléfono y a quién pides la verificación',
              children: [
                const SizedBox(height: 10),
                TextField(
                  controller: _presentacion,
                  maxLines: 4,
                  decoration: const InputDecoration(labelText: 'Quién eres', hintText: 'Promoción y cuerpo, destino, desde cuándo preparas, quién te conoce…', helperText: 'Lo lee quien te verifica; ayuda si no te conoce'),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _linkedin,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    labelText: 'LinkedIn (opcional)',
                    hintText: 'linkedin.com/in/tu-perfil',
                    helperText: 'Ayuda a quien te verifica y sale en el directorio de preparadores',
                    errorText: _linkedinValido ? null : 'Pega el enlace a tu perfil (linkedin.com/in/…)',
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 14),
                Text('Cómo das clase (sale en el directorio)', style: context.textos.labelMedium),
                const SizedBox(height: 6),
                Wrap(spacing: 6, runSpacing: 6, children: [
                  for (final (m, t) in const [('online', 'Online'), ('presencial', 'Presencial'), ('ambas', 'Las dos'), ('', 'Sin indicar')])
                    ChoiceChip(label: Text(t), selected: _modalidad == m, onSelected: (_) => setState(() => _modalidad = m)),
                ]),
                if (_modalidad == 'presencial' || _modalidad == 'ambas')
                  TextField(controller: _ciudad, maxLength: 60, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Ciudad', hintText: 'Madrid')),
                const SizedBox(height: 8),
                TextField(controller: _telefono, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Teléfono para WhatsApp (opcional)', helperText: 'Se da solo al alumno cuya clase suelta coges')),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  initialValue: _destinatario?.uid ?? '',
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'A quién se la pides'),
                  items: [
                    const DropdownMenuItem(value: '', child: Text('A cualquier preparador verificado')),
                    for (final v in candidatos) DropdownMenuItem(value: v.uid, child: Text(v.nombre, overflow: TextOverflow.ellipsis)),
                  ],
                  onChanged: (u) => setState(() => _destinatario = candidatos.where((v) => v.uid == u).firstOrNull),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 6, 4, 0),
                  child: Text(
                    _destinatario == null ? 'La podrá revisar cualquier preparador verificado de $siglas.' : 'Se la enviamos a ${_destinatario!.nombre}, que recibirá un aviso.',
                    style: context.textos.labelSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: !_completo || _enviando ? null : _enviar,
              icon: const Icon(Icons.how_to_reg_outlined),
              label: Text(_enviando ? 'Enviando…' : (widget.soloVerificacion ? 'Pedir la verificación' : 'Darme de alta como preparador')),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(4, 10, 4, 0), child: AvisoLegal('Al darte de alta', conEncargo: true)),
            if (!widget.soloVerificacion)
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 10, 4, 0),
                child: Text('Mientras te verifican ya puedes llevar a tus alumnos a mano. En $siglas dejarás de ser opositor; tu temario, tus cantes y tus tests se quedan guardados, y puedes volver en Más → Ajustes.', style: context.textos.labelSmall),
              ),
          ],
        ],
      ),
    );
  }
}
