import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'cronograma_manual_page.dart';
import 'interprete_cronograma.dart';
import 'lector_ficheros.dart';

/// Traer un cronograma hecho por tu cuenta: pegando el texto o eligiendo un
/// Excel, un Word, un PDF o un CSV. La app busca las fechas de cante y los
/// temas y los deja para revisar antes de crearlo.
class ImportarCronogramaPage extends ConsumerStatefulWidget {
  const ImportarCronogramaPage({super.key});
  @override
  ConsumerState<ImportarCronogramaPage> createState() => _ImportarCronogramaPageState();
}

class _ImportarCronogramaPageState extends ConsumerState<ImportarCronogramaPage> {
  final _texto = TextEditingController();
  int? _ejercicio;
  bool _leyendo = false;

  @override
  void dispose() {
    _texto.dispose();
    super.dispose();
  }

  Set<String> get _codigos => {for (final t in ref.read(temarioProvider).valueOrNull?.todosLosTemas ?? const []) t.codigo};

  void _revisar(CronogramaLeido? leido, {required String origen}) {
    if (leido == null || leido.vacio) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 6),
        content: Text(leido == null
            ? 'No he sabido abrir $origen. Prueba a copiar su texto y pegarlo aquí, o hazlo semana a semana.'
            : 'No he encontrado temas en $origen. Los temas tienen que ir con su código (por ejemplo, 3A7 o 3.A.7).'),
      ));
      return;
    }
    final hoy = DateTime.now();
    final s = semanasDesdeLeido(leido, primerCante: DateTime(hoy.year, hoy.month, hoy.day + 7));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CronogramaManualPage(
        titulo: 'Revisa tu cronograma',
        semanas: s.semanas,
        primerCante: s.semanas.isEmpty ? null : s.semanas.first.domingo,
        noReconocidas: leido.noReconocidas,
      ),
    ));
  }

  Future<void> _elegirFichero() async {
    final f = await FilePicker.pickFile(type: FileType.custom, allowedExtensions: extensionesCronograma);
    if (f == null || !mounted) return;
    setState(() => _leyendo = true);
    final bytes = await f.readAsBytes();
    final leido = leerFicheroCronograma(f.name, bytes, codigos: _codigos, ejercicioPorDefecto: _ejercicio);
    if (!mounted) return;
    setState(() => _leyendo = false);
    _revisar(leido, origen: f.name);
  }

  @override
  Widget build(BuildContext context) {
    final ejercicios = Oposiciones.actual.conCronograma;
    return Scaffold(
      appBar: const BarraWeb(title: Text('Traer tu cronograma')),
      body: ListaAdaptable(children: [
        const SizedBox(height: 10),
        Text('Si ya tienes tu cronograma en un Excel, un Word o un PDF (o te lo ha hecho tu preparador), la app busca en él las fechas de cante y los temas de cada una. Antes de crearlo lo revisas y lo corriges.', style: context.textos.bodyMedium),
        const SizedBox(height: 6),
        Text('Funciona mejor si cada fila o línea lleva la fecha del cante (o «Semana 1», «Semana 2»…) y los códigos de los temas (3A7, 3.A.7 o A7).', style: context.textos.bodySmall),
        const TituloSeccion('Si los temas van sin ejercicio («A7»)'),
        Wrap(spacing: 8, children: [
          ChoiceChip(label: const Text('Que lo deduzca'), selected: _ejercicio == null, onSelected: (_) => setState(() => _ejercicio = null)),
          for (final e in ejercicios) ChoiceChip(label: Text('Del ${e.corto}'), selected: _ejercicio == e.numero, onSelected: (_) => setState(() => _ejercicio = e.numero)),
        ]),
        const TituloSeccion('Desde un fichero'),
        FilledButton.icon(
          onPressed: _leyendo ? null : _elegirFichero,
          icon: const Icon(Icons.upload_file),
          label: Text(_leyendo ? 'Leyendo…' : 'Elegir un Excel, Word, PDF o CSV'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 6, 4, 0),
          child: Text('Los PDF escaneados (fotos) no tienen texto: con esos, mejor pegar el texto o hacerlo semana a semana.', style: context.textos.labelSmall),
        ),
        const TituloSeccion('O pega el texto'),
        TextField(
          controller: _texto,
          minLines: 6,
          maxLines: 14,
          decoration: const InputDecoration(hintText: '13/10: 3A1, 3A2\n20/10: 3B4\n…', alignLabelWithHint: true),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: _texto.text.trim().isEmpty ? null : () => _revisar(interpretarCronograma(_texto.text, codigos: _codigos, ejercicioPorDefecto: _ejercicio), origen: 'el texto'),
            icon: const Icon(Icons.auto_fix_high_outlined),
            label: const Text('Leer el texto'),
          ),
        ),
        const SizedBox(height: 24),
      ]),
    );
  }
}
