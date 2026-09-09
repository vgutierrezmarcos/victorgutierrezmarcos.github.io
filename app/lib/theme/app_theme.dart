import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Paleta y tipografías tomadas de styles.css de la web.
/// Claro: :root · Oscuro: [data-theme="dark"].
class Paleta {
  Paleta._();

  // Claro
  static const primario = Color(0xFF5F2987);
  static const primarioOscuro = Color(0xFF4A1F6B);
  static const primarioClaro = Color(0xFF7A3CA8);
  static const primarioPalido = Color(0xFFF3EEF7);
  static const fondo = Color(0xFFE2EFD9);
  static const fondoClaro = Color(0xFFEDF5E7);
  static const crema = Color(0xFFFAF9F6);
  static const texto = Color(0xFF2D2D2D);
  static const textoSuave = Color(0xFF555555);
  static const textoClaro = Color(0xFF777777);
  static const borde = Color(0xFFC8D8C0);
  static const bordeClaro = Color(0xFFDDE8D6);
  static const dorado = Color(0xFFB8860B);
  static const doradoClaro = Color(0xFFDAA520);

  // Oscuro
  static const dPrimario = Color(0xFF9B6BC7);
  static const dPrimarioOscuro = Color(0xFF7A4FAD);
  static const dPrimarioClaro = Color(0xFFB48FDA);
  static const dPrimarioPalido = Color(0xFF2A2040);
  static const dFondo = Color(0xFF1A1A2E);
  static const dFondoClaro = Color(0xFF1E1E34);
  static const dCrema = Color(0xFF222240);
  static const dSuperficie = Color(0xFF252545);
  static const dTexto = Color(0xFFE0E0E0);
  static const dTextoSuave = Color(0xFFB0B0B0);
  static const dTextoClaro = Color(0xFF888888);
  static const dBorde = Color(0xFF3A3A5C);
  static const dBordeClaro = Color(0xFF2E2E4A);
  static const dDorado = Color(0xFFD4A520);

  // Semánticos (simulador)
  static const acierto = Color(0xFF2E7D32);
  static const fallo = Color(0xFFC62828);
  static const blanco = Color(0xFF9E9E9E);
}

/// Colores de superficie que no cubre ColorScheme, accesibles vía Theme.
class ColoresExtra extends ThemeExtension<ColoresExtra> {
  const ColoresExtra({
    required this.superficie,
    required this.fondoClaro,
    required this.crema,
    required this.borde,
    required this.bordeClaro,
    required this.textoSuave,
    required this.textoClaro,
    required this.dorado,
    required this.primarioPalido,
  });

  final Color superficie;
  final Color fondoClaro;
  final Color crema;
  final Color borde;
  final Color bordeClaro;
  final Color textoSuave;
  final Color textoClaro;
  final Color dorado;
  final Color primarioPalido;

  static const claro = ColoresExtra(
    superficie: Colors.white,
    fondoClaro: Paleta.fondoClaro,
    crema: Paleta.crema,
    borde: Paleta.borde,
    bordeClaro: Paleta.bordeClaro,
    textoSuave: Paleta.textoSuave,
    textoClaro: Paleta.textoClaro,
    dorado: Paleta.dorado,
    primarioPalido: Paleta.primarioPalido,
  );

  static const oscuro = ColoresExtra(
    superficie: Paleta.dSuperficie,
    fondoClaro: Paleta.dFondoClaro,
    crema: Paleta.dCrema,
    borde: Paleta.dBorde,
    bordeClaro: Paleta.dBordeClaro,
    textoSuave: Paleta.dTextoSuave,
    textoClaro: Paleta.dTextoClaro,
    dorado: Paleta.dDorado,
    primarioPalido: Paleta.dPrimarioPalido,
  );

  @override
  ColoresExtra copyWith({Color? superficie}) => this;

  @override
  ColoresExtra lerp(ThemeExtension<ColoresExtra>? other, double t) {
    if (other is! ColoresExtra) return this;
    return ColoresExtra(
      superficie: Color.lerp(superficie, other.superficie, t)!,
      fondoClaro: Color.lerp(fondoClaro, other.fondoClaro, t)!,
      crema: Color.lerp(crema, other.crema, t)!,
      borde: Color.lerp(borde, other.borde, t)!,
      bordeClaro: Color.lerp(bordeClaro, other.bordeClaro, t)!,
      textoSuave: Color.lerp(textoSuave, other.textoSuave, t)!,
      textoClaro: Color.lerp(textoClaro, other.textoClaro, t)!,
      dorado: Color.lerp(dorado, other.dorado, t)!,
      primarioPalido: Color.lerp(primarioPalido, other.primarioPalido, t)!,
    );
  }
}

extension ThemeX on BuildContext {
  ColoresExtra get colores => Theme.of(this).extension<ColoresExtra>()!;
  ColorScheme get esquema => Theme.of(this).colorScheme;
  TextTheme get textos => Theme.of(this).textTheme;
}

class AppTheme {
  AppTheme._();

  /// Serif para títulos y cuerpo (Palatino en la web; Gentium Book Plus
  /// es la alternativa libre más cercana disponible en Google Fonts).
  static TextStyle _serif(TextStyle base) => GoogleFonts.gentiumBookPlus(textStyle: base);

  /// Sans para UI (Source Sans 3, igual que la web).
  static TextStyle _sans(TextStyle base) => GoogleFonts.sourceSans3(textStyle: base);

  static TextTheme _textos(TextTheme base, Color texto, Color suave) {
    return base.copyWith(
      displayLarge: _serif(base.displayLarge!).copyWith(color: texto),
      displayMedium: _serif(base.displayMedium!).copyWith(color: texto),
      displaySmall: _serif(base.displaySmall!).copyWith(color: texto),
      headlineLarge: _serif(base.headlineLarge!).copyWith(color: texto, fontWeight: FontWeight.w700),
      headlineMedium: _serif(base.headlineMedium!).copyWith(color: texto, fontWeight: FontWeight.w700),
      headlineSmall: _serif(base.headlineSmall!).copyWith(color: texto, fontWeight: FontWeight.w700),
      titleLarge: _serif(base.titleLarge!).copyWith(color: texto, fontWeight: FontWeight.w700),
      titleMedium: _serif(base.titleMedium!).copyWith(color: texto, fontWeight: FontWeight.w600),
      titleSmall: _sans(base.titleSmall!).copyWith(color: texto, fontWeight: FontWeight.w600),
      bodyLarge: _serif(base.bodyLarge!).copyWith(color: texto, height: 1.5),
      bodyMedium: _serif(base.bodyMedium!).copyWith(color: texto, height: 1.5),
      bodySmall: _sans(base.bodySmall!).copyWith(color: suave),
      labelLarge: _sans(base.labelLarge!).copyWith(color: texto, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      labelMedium: _sans(base.labelMedium!).copyWith(color: suave, letterSpacing: 0.8),
      labelSmall: _sans(base.labelSmall!).copyWith(color: suave, letterSpacing: 1),
    );
  }

  static ThemeData _build({required Brightness brillo}) {
    final oscuro = brillo == Brightness.dark;
    final extra = oscuro ? ColoresExtra.oscuro : ColoresExtra.claro;
    final primario = oscuro ? Paleta.dPrimario : Paleta.primario;
    final fondo = oscuro ? Paleta.dFondo : Paleta.fondo;
    final texto = oscuro ? Paleta.dTexto : Paleta.texto;

    final esquema = ColorScheme(
      brightness: brillo,
      primary: primario,
      onPrimary: Colors.white,
      primaryContainer: extra.primarioPalido,
      onPrimaryContainer: oscuro ? Paleta.dPrimarioClaro : Paleta.primarioOscuro,
      secondary: extra.dorado,
      onSecondary: Colors.white,
      secondaryContainer: extra.fondoClaro,
      onSecondaryContainer: texto,
      error: Paleta.fallo,
      onError: Colors.white,
      surface: extra.superficie,
      onSurface: texto,
      surfaceContainerHighest: extra.crema,
      onSurfaceVariant: extra.textoSuave,
      outline: extra.borde,
      outlineVariant: extra.bordeClaro,
      tertiary: Paleta.acierto,
      onTertiary: Colors.white,
    );

    final base = ThemeData(brightness: brillo, useMaterial3: true, colorScheme: esquema);
    final textos = _textos(base.textTheme, texto, extra.textoSuave);

    return base.copyWith(
      scaffoldBackgroundColor: fondo,
      textTheme: textos,
      extensions: [extra],
      appBarTheme: AppBarTheme(
        backgroundColor: fondo,
        foregroundColor: texto,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textos.titleLarge?.copyWith(fontSize: 22),
      ),
      cardTheme: CardThemeData(
        color: extra.superficie,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: extra.bordeClaro),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: extra.superficie,
        indicatorColor: extra.primarioPalido,
        labelTextStyle: WidgetStatePropertyAll(textos.labelMedium?.copyWith(fontSize: 11)),
        iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(color: s.contains(WidgetState.selected) ? primario : extra.textoSuave),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primario,
          foregroundColor: Colors.white,
          textStyle: textos.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primario,
          side: BorderSide(color: primario),
          textStyle: textos.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primario, textStyle: textos.labelLarge),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: extra.fondoClaro,
        selectedColor: extra.primarioPalido,
        side: BorderSide(color: extra.bordeClaro),
        labelStyle: textos.labelMedium?.copyWith(color: texto),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: extra.superficie,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: extra.borde),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: extra.borde),
        ),
      ),
      dividerTheme: DividerThemeData(color: extra.bordeClaro),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: oscuro ? Paleta.dPrimarioOscuro : Paleta.primarioOscuro,
        contentTextStyle: textos.bodyMedium?.copyWith(color: Colors.white),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static ThemeData get claro => _build(brillo: Brightness.light);
  static ThemeData get oscuro => _build(brillo: Brightness.dark);
}
