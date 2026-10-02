import 'package:flutter/material.dart';

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
  static const dDoradoClaro = Color(0xFFE0B840);

  // Semánticos (simulador): tono oscuro para texto e iconos…
  static const acierto = Color(0xFF2E7D32);
  static const fallo = Color(0xFFC62828);
  static const blanco = Color(0xFF9E9E9E);
  // …y los de simulador.html para bordes y fondos de las opciones.
  static const aciertoWeb = Color(0xFF4CAF50);
  static const falloWeb = Color(0xFFF44336);
  static const avisoWeb = Color(0xFFFF9800);
}

/// Familias incluidas en assets/fonts. La web usa Palatino Linotype, que no
/// existe en Android ni iOS: TeX Gyre Pagella es su equivalente libre (deriva
/// de URW Palladio, que está en la lista de fuentes de styles.css).
class Fuentes {
  Fuentes._();
  static const serif = 'Pagella';
  static const sans = 'SourceSans3';
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
  bool get temaOscuro => Theme.of(this).brightness == Brightness.dark;

  /// Degradado morado de la cabecera, los grupos de temas y los botones de la web.
  LinearGradient get degradadoPrimario => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: temaOscuro ? const [Paleta.dPrimario, Paleta.dPrimarioOscuro] : const [Paleta.primario, Paleta.primarioOscuro],
      );

  /// Línea dorada que cierra la cabecera de la web (.site-header::after).
  LinearGradient get degradadoDorado {
    final oro = temaOscuro ? Paleta.dDorado : Paleta.dorado;
    final claro = temaOscuro ? Paleta.dDoradoClaro : Paleta.doradoClaro;
    return LinearGradient(colors: [oro.withValues(alpha: 0), oro, claro, oro, oro.withValues(alpha: 0)], stops: const [0, 0.2, 0.5, 0.8, 1]);
  }

  /// Sombra suave de las tarjetas (--shadow-sm).
  List<BoxShadow> get sombraSuave => [BoxShadow(color: Colors.black.withValues(alpha: temaOscuro ? 0.3 : 0.08), blurRadius: 3, offset: const Offset(0, 1))];
}

class AppTheme {
  AppTheme._();

  /// Serif para títulos y cuerpo (--font-display y --font-body de la web).
  static TextStyle _serif(TextStyle base) => base.copyWith(fontFamily: Fuentes.serif);

  /// Sans para la interfaz (--font-ui: Source Sans 3, igual que la web).
  static TextStyle _sans(TextStyle base) => base.copyWith(fontFamily: Fuentes.sans);

  static TextTheme _textos(TextTheme base, Color texto, Color suave) {
    return base.copyWith(
      displayLarge: _serif(base.displayLarge!).copyWith(color: texto),
      displayMedium: _serif(base.displayMedium!).copyWith(color: texto),
      displaySmall: _serif(base.displaySmall!).copyWith(color: texto),
      headlineLarge: _serif(base.headlineLarge!).copyWith(color: texto, fontWeight: FontWeight.w700),
      headlineMedium: _serif(base.headlineMedium!).copyWith(color: texto, fontWeight: FontWeight.w700),
      headlineSmall: _serif(base.headlineSmall!).copyWith(color: texto, fontWeight: FontWeight.w700),
      titleLarge: _serif(base.titleLarge!).copyWith(color: texto, fontWeight: FontWeight.w700),
      titleMedium: _serif(base.titleMedium!).copyWith(color: texto, fontWeight: FontWeight.w700, fontSize: 17, letterSpacing: 0),
      titleSmall: _sans(base.titleSmall!).copyWith(color: texto, fontWeight: FontWeight.w600, fontSize: 14.5, letterSpacing: 0),
      bodyLarge: _serif(base.bodyLarge!).copyWith(color: texto, height: 1.55, fontSize: 17, letterSpacing: 0),
      bodyMedium: _serif(base.bodyMedium!).copyWith(color: texto, height: 1.5, fontSize: 15.5, letterSpacing: 0),
      bodySmall: _sans(base.bodySmall!).copyWith(color: suave, fontSize: 13.5, height: 1.4, letterSpacing: 0),
      labelLarge: _sans(base.labelLarge!).copyWith(color: texto, fontWeight: FontWeight.w600, letterSpacing: 0.3),
      labelMedium: _sans(base.labelMedium!).copyWith(color: suave, fontSize: 12.5, letterSpacing: 0.5),
      labelSmall: _sans(base.labelSmall!).copyWith(color: suave, fontSize: 12, letterSpacing: 0.4),
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
      secondaryContainer: extra.primarioPalido,
      onSecondaryContainer: oscuro ? Paleta.dPrimarioClaro : Paleta.primarioOscuro,
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

    final base = ThemeData(brightness: brillo, useMaterial3: true, colorScheme: esquema, fontFamily: Fuentes.sans);
    final textos = _textos(base.textTheme, texto, extra.textoSuave);
    final forma6 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(6));

    return base.copyWith(
      scaffoldBackgroundColor: fondo,
      textTheme: textos,
      extensions: [extra],
      // Cabecera morada con el título en blanco y serif, como .site-header.
      // El degradado y la línea dorada los pone BarraWeb (widgets/comunes.dart).
      appBarTheme: AppBarTheme(
        backgroundColor: primario,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: textos.titleLarge?.copyWith(fontSize: 21, color: Colors.white, letterSpacing: 0.3),
      ),
      cardTheme: CardThemeData(
        color: extra.superficie,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: extra.borde)),
      ),
      // Menú de la web (.main-nav): fondo blanco, etiquetas en mayúsculas y la
      // sección activa en blanco sobre morado.
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: extra.superficie,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 66,
        indicatorColor: primario,
        indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (s) => TextStyle(
            fontFamily: Fuentes.sans,
            fontSize: 10.5,
            fontWeight: s.contains(WidgetState.selected) ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: 0.7,
            color: s.contains(WidgetState.selected) ? primario : texto,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(size: 22, color: s.contains(WidgetState.selected) ? Colors.white : extra.textoSuave),
        ),
      ),
      // En pantallas anchas (ordenador) el mismo menú va en un raíl a la izquierda.
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: extra.superficie,
        elevation: 0,
        indicatorColor: primario,
        indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        selectedIconTheme: const IconThemeData(size: 22, color: Colors.white),
        unselectedIconTheme: IconThemeData(size: 22, color: extra.textoSuave),
        selectedLabelTextStyle: TextStyle(fontFamily: Fuentes.sans, fontSize: 10.5, fontWeight: FontWeight.w700, letterSpacing: 0.7, color: primario),
        unselectedLabelTextStyle: TextStyle(fontFamily: Fuentes.sans, fontSize: 10.5, fontWeight: FontWeight.w500, letterSpacing: 0.7, color: texto),
      ),
      // Botones de la web (.download-btn, .btn-comenzar): morado, radio 6, sans.
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primario,
          foregroundColor: Colors.white,
          textStyle: textos.labelLarge?.copyWith(fontSize: 14.5),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
          elevation: 1,
          shape: forma6,
        ),
      ),
      // .btn-nav: borde morado de 2 px.
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primario,
          backgroundColor: extra.superficie,
          side: BorderSide(color: primario, width: 2),
          textStyle: textos.labelLarge?.copyWith(fontSize: 14.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          shape: forma6,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primario, textStyle: textos.labelLarge),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(forma6),
          side: WidgetStatePropertyAll(BorderSide(color: extra.borde)),
          backgroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? primario : extra.superficie),
          foregroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? Colors.white : texto),
          textStyle: WidgetStatePropertyAll(textos.labelLarge?.copyWith(fontSize: 13)),
        ),
      ),
      // Casillas de la web (.tema-checkbox): fondo claro y, al elegirlas, morado pálido con borde morado.
      chipTheme: ChipThemeData(
        backgroundColor: extra.fondoClaro,
        selectedColor: extra.primarioPalido,
        checkmarkColor: primario,
        showCheckmark: false,
        side: WidgetStateBorderSide.resolveWith((s) => BorderSide(color: s.contains(WidgetState.selected) ? primario : extra.bordeClaro)),
        labelStyle: textos.labelMedium?.copyWith(color: texto, fontSize: 13, letterSpacing: 0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: extra.superficie,
        hintStyle: textos.bodySmall?.copyWith(color: extra.textoClaro),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: extra.borde)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: extra.borde)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: primario, width: 2)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primario,
        foregroundColor: Colors.white,
        extendedTextStyle: textos.labelLarge?.copyWith(color: Colors.white),
        shape: forma6,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: extra.superficie,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        titleTextStyle: textos.titleLarge?.copyWith(fontSize: 20),
        contentTextStyle: textos.bodyMedium,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: extra.superficie,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
      ),
      listTileTheme: ListTileThemeData(iconColor: extra.textoSuave, titleTextStyle: textos.titleSmall, subtitleTextStyle: textos.labelSmall),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: primario, linearTrackColor: extra.fondoClaro),
      dividerTheme: DividerThemeData(color: extra.bordeClaro),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: oscuro ? Paleta.dPrimarioOscuro : Paleta.primarioOscuro,
        contentTextStyle: textos.bodySmall?.copyWith(color: Colors.white, fontSize: 14),
        behavior: SnackBarBehavior.floating,
        shape: forma6,
      ),
    );
  }

  static ThemeData get claro => _build(brillo: Brightness.light);
  static ThemeData get oscuro => _build(brillo: Brightness.dark);
}
