import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/core/dictado.dart';
import 'package:tcee_app/features/cantar/transcripcion.dart';

/// La transcripción del cante que se manda a la IA (formato de
/// claude/prepara-con-claude/references/datos-app.md, §1).
void main() {
  test('una marca por minuto de exposición, también los minutos en silencio', () {
    final t = Transcripcion()
      ..anadir('¿Puede una teoría explicar lo que elegimos?', const Duration(seconds: 3))
      ..anadir('Marshall definía la economía…', const Duration(seconds: 40))
      ..anadir('  ', const Duration(seconds: 50))
      ..anadir('y en lo macroeconómico es la base del consumo', const Duration(minutes: 2, seconds: 5));
    expect(t.porMinutos(), '[00:00] ¿Puede una teoría explicar lo que elegimos? Marshall definía la economía…\n[01:00]\n[02:00] y en lo macroeconómico es la base del consumo\n');
    expect(t.palabras, 20);
    expect(Transcripcion().vacia, isTrue);
  });

  test('con varios temas, cada uno desde cero bajo su título', () {
    final t = Transcripcion()
      ..anadir('Intro del primero', Duration.zero, tema: '3.A.8')
      ..anadir('Intro del segundo', const Duration(seconds: 10), tema: '3.B.1');
    expect(t.porMinutos(), '## Tema 3.A.8\n\n[00:00] Intro del primero\n\n## Tema 3.B.1\n\n[00:00] Intro del segundo\n');
  });

  test('el fichero lleva la cabecera que lee la IA', () {
    final t = Transcripcion()..anadir('Hola', Duration.zero);
    final f = t.fichero(
      oposicion: 'TCEE',
      ejercicio: 'Tercer ejercicio',
      tema: '3.A.8',
      tituloTema: 'Teoría de la demanda del consumidor (I)',
      fecha: DateTime(2026, 11, 3, 18, 2),
      exposicion: const Duration(minutes: 29, seconds: 41),
      exposicionPrevista: const Duration(minutes: 30),
      esquema: const Duration(minutes: 44, seconds: 10),
      esquemaPrevisto: const Duration(minutes: 45),
      sorteados: ['3.A.8', '3.A.11'],
      cantados: ['3.A.8'],
    );
    expect(f.split('\n').take(5).toList(), [
      '# Cante · Oposición TCEE · Tercer ejercicio · Tema 3.A.8 · Teoría de la demanda del consumidor (I)',
      'Fecha: 2026-11-03 18:02 · Exposición: 29:41 (prevista 30:00) · Esquema: 44:10 (previsto 45:00)',
      'Sorteados: 3.A.8, 3.A.11 · Cantado: 3.A.8',
      'Transcripción automática del móvil: puede tener errores de reconocimiento (nombres propios, fórmulas, números).',
      '',
    ]);
    expect(f, endsWith('[00:00] Hola\n'));
    // Sin esquema no sale esa parte.
    expect(t.fichero(oposicion: 'DCE', ejercicio: 'Tercer ejercicio', fecha: DateTime(2026, 11, 3), exposicion: Duration.zero, exposicionPrevista: const Duration(minutes: 20)).split('\n')[1], 'Fecha: 2026-11-03 00:00 · Exposición: 00:00 (prevista 20:00)');
  });

  test('nombre del fichero', () {
    expect(codigoParaFichero('3.A.8'), '3A08');
    expect(codigoParaFichero('4.B.12'), '4B12');
    expect(nombreFicheroTranscripcion('3.A.8', DateTime(2026, 11, 3, 18)), 'cante_3A08_2026-11-03.txt');
    expect(nombreFicheroTranscripcion(null, DateTime(2026, 11, 3)), 'cante_tema_2026-11-03.txt');
  });

  test('fuera de Android y del navegador no hay dictado', () async {
    final d = crearDictado();
    expect(d.posible, isFalse);
    expect(await d.disponible(), isFalse);
  });
}
