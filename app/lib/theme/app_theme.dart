import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Colores de marca de una oposición. TCEE: los de styles.css de esta web
/// (claro, :root; oscuro, [data-theme="dark"]). DCE: los de la web de Manuel
/// Cabado García (manuelcabadogarcia.es): granate, crema y azul; en oscuro, el
/// verde menta de su web.
class PaletaMarca {
  const PaletaMarca({
    required this.primario,
    required this.primarioOscuro,
    required this.primarioClaro,
    required this.primarioPalido,
    required this.fondo,
    required this.fondoClaro,
    required this.crema,
    required this.texto,
    required this.textoSuave,
    required this.textoClaro,
    required this.borde,
    required this.bordeClaro,
    required this.dorado,
    required this.doradoClaro,
    required this.dPrimario,
    required this.dPrimarioOscuro,
    required this.dPrimarioClaro,
    required this.dPrimarioPalido,
    required this.dRelleno,
    required this.dRellenoOscuro,
    required this.dFondo,
    required this.dFondoClaro,
    required this.dCrema,
    required this.dSuperficie,
    required this.dTexto,
    required this.dTextoSuave,
    required this.dTextoClaro,
    required this.dBorde,
    required this.dBordeClaro,
    required this.dDorado,
    required this.dDoradoClaro,
    required this.dCabecera,
    required this.dCabeceraOscura,
    this.dSobreRelleno = const Color(0xFFFFFFFF),
    required this.serif,
    required this.sans,
  });

  final Color primario;
  final Color primarioOscuro;
  final Color primarioClaro;
  final Color primarioPalido;
  final Color fondo;
  final Color fondoClaro;
  final Color crema;
  final Color texto;
  final Color textoSuave;
  final Color textoClaro;
  final Color borde;
  final Color bordeClaro;
  final Color dorado;
  final Color doradoClaro;
  final Color dPrimario;
  final Color dPrimarioOscuro;
  final Color dPrimarioClaro;
  final Color dPrimarioPalido;
  final Color dRelleno;
  final Color dRellenoOscuro;
  final Color dFondo;
  final Color dFondoClaro;
  final Color dCrema;
  final Color dSuperficie;
  final Color dTexto;
  final Color dTextoSuave;
  final Color dTextoClaro;
  final Color dBorde;
  final Color dBordeClaro;
  final Color dDorado;
  final Color dDoradoClaro;
  /// Degradado de la cabecera en oscuro (y de los bloques que la imitan).
  final Color dCabecera;
  final Color dCabeceraOscura;
  /// Texto e iconos sobre [dRelleno] (botones, pestaña activa…).
  final Color dSobreRelleno;
  /// Familias de assets/fonts para títulos y texto, y para la interfaz.
  final String serif;
  final String sans;

  /// La de la oposición [id] ('tcee', 'dce').
  static PaletaMarca de(String id) => id == 'dce' ? dce : tcee;

  static const tcee = PaletaMarca(
    primario: Color(0xFF5F2987),
    primarioOscuro: Color(0xFF4A1F6B),
    primarioClaro: Color(0xFF7A3CA8),
    primarioPalido: Color(0xFFF1EBF6),
    fondo: Color(0xFFE2EFD9),
    fondoClaro: Color(0xFFEDF5E7),
    crema: Color(0xFFFBFAF6),
    texto: Color(0xFF2A2530),
    textoSuave: Color(0xFF5E5866),
    textoClaro: Color(0xFF7A7480),
    borde: Color(0xFFC8D8C0),
    bordeClaro: Color(0xFFDDE8D6),
    dorado: Color(0xFFB8860B),
    doradoClaro: Color(0xFFDAA520),
    // Oscuro: berenjena, como [data-theme="dark"] de la web. Los rellenos
    // (botones, pestaña activa) son lila claro con el texto oscuro encima.
    dPrimario: Color(0xFFC3A2E0),
    dPrimarioOscuro: Color(0xFFA57FCB),
    dPrimarioClaro: Color(0xFFD4BDEB),
    dPrimarioPalido: Color(0xFF2E2538),
    dRelleno: Color(0xFFC3A2E0),
    dRellenoOscuro: Color(0xFFA57FCB),
    dFondo: Color(0xFF16131A),
    dFondoClaro: Color(0xFF1B1820),
    dCrema: Color(0xFF26212B),
    dSuperficie: Color(0xFF211D26),
    dTexto: Color(0xFFECE6EF),
    dTextoSuave: Color(0xFFB3AABB),
    dTextoClaro: Color(0xFF8F8698),
    dBorde: Color(0xFF3A3342),
    dBordeClaro: Color(0xFF2E2935),
    dDorado: Color(0xFFD9AE45),
    dDoradoClaro: Color(0xFFE6C46E),
    dCabecera: Color(0xFF3E1B5B),
    dCabeceraOscura: Color(0xFF3E1B5B),
    dSobreRelleno: Color(0xFF1C1622),
    serif: 'Pagella',
    sans: 'SourceSans3',
  );

  // En oscuro, como el modo noche de su web (bootstrap-dark de
  // manuelcabadogarcia.es): fondo carbón #1e1d1b, texto crema #e6e0d2, bordes
  // #3b3934 y un solo acento, el verde menta #3ee6a8, para enlaces, iconos,
  // la línea de la cabecera y los botones (con el texto oscuro encima, como
  // sus .btn-primary). La cabecera es carbón, como su barra de navegación.
  static const dce = PaletaMarca(
    primario: Color(0xFF7A1F4B),
    primarioOscuro: Color(0xFF5C1638),
    primarioClaro: Color(0xFF9C3A68),
    primarioPalido: Color(0xFFF4E9EE),
    fondo: Color(0xFFF7F4EC),
    fondoClaro: Color(0xFFFBF9F4),
    crema: Color(0xFFFFFDF8),
    texto: Color(0xFF2B2A28),
    textoSuave: Color(0xFF57534B),
    textoClaro: Color(0xFF6F6B62),
    borde: Color(0xFFDDD6C6),
    bordeClaro: Color(0xFFE9E3D6),
    dorado: Color(0xFF234A6B),
    doradoClaro: Color(0xFF3A6A93),
    dPrimario: Color(0xFF3EE6A8),
    dPrimarioOscuro: Color(0xFF31B886),
    dPrimarioClaro: Color(0xFFA6F7D2),
    dPrimarioPalido: Color(0xFF213129),
    dRelleno: Color(0xFF3EE6A8),
    dRellenoOscuro: Color(0xFF31B886),
    dFondo: Color(0xFF1E1D1B),
    dFondoClaro: Color(0xFF24221F),
    dCrema: Color(0xFF2A2825),
    dSuperficie: Color(0xFF2E2C28),
    dTexto: Color(0xFFE6E0D2),
    dTextoSuave: Color(0xFFBDB6A6),
    dTextoClaro: Color(0xFFA39D90),
    dBorde: Color(0xFF3B3934),
    dBordeClaro: Color(0xFF34322E),
    dDorado: Color(0xFF3EE6A8),
    dDoradoClaro: Color(0xFFA6F7D2),
    dCabecera: Color(0xFF2E2C28),
    dCabeceraOscura: Color(0xFF262522),
    dSobreRelleno: Color(0xFF1E1D1B),
    // Latin Modern Roman, la de LaTeX, en toda la web de Manuel.
    serif: 'LMRoman',
    sans: 'LMRoman',
  );
}

/// Estética neutra, común a TCEE y DCE (pantalla de elegir oposición y vídeo
/// de la app): la de TCEE en lo fundamental (Pagella, Source Sans, línea
/// dorada), con un berenjena oscuro y una crema que casan con el morado de una
/// y el granate de la otra.
class PaletaNeutra {
  PaletaNeutra._();
  static const fondo = Color(0xFFF6F4EF);
  static const tinta = Color(0xFF2E2235);
  static const tintaClara = Color(0xFF43294F);
  static const texto = Color(0xFF2D2D2D);
  static const textoSuave = Color(0xFF5A5560);
  static const dorado = Color(0xFFB8860B);
  static const doradoClaro = Color(0xFFDAA520);
}

/// Paleta de la oposición que se está preparando ([usar] la cambia; el tema se
/// vuelve a construir al cambiar de oposición) y colores semánticos comunes.
class Paleta {
  Paleta._();

  static PaletaMarca _m = PaletaMarca.tcee;
  static PaletaMarca get marca => _m;

  /// Usa la paleta y las tipografías de la oposición [id] ('tcee', 'dce').
  static void usar(String id) => _m = PaletaMarca.de(id);

  static Color get primario => _m.primario;
  static Color get primarioOscuro => _m.primarioOscuro;
  static Color get primarioClaro => _m.primarioClaro;
  static Color get primarioPalido => _m.primarioPalido;
  static Color get fondo => _m.fondo;
  static Color get fondoClaro => _m.fondoClaro;
  static Color get crema => _m.crema;
  static Color get texto => _m.texto;
  static Color get textoSuave => _m.textoSuave;
  static Color get textoClaro => _m.textoClaro;
  static Color get borde => _m.borde;
  static Color get bordeClaro => _m.bordeClaro;
  static Color get dorado => _m.dorado;
  static Color get doradoClaro => _m.doradoClaro;
  static Color get dPrimario => _m.dPrimario;
  static Color get dPrimarioOscuro => _m.dPrimarioOscuro;
  static Color get dPrimarioClaro => _m.dPrimarioClaro;
  static Color get dPrimarioPalido => _m.dPrimarioPalido;
  static Color get dRelleno => _m.dRelleno;
  static Color get dRellenoOscuro => _m.dRellenoOscuro;
  static Color get dFondo => _m.dFondo;
  static Color get dFondoClaro => _m.dFondoClaro;
  static Color get dCrema => _m.dCrema;
  static Color get dSuperficie => _m.dSuperficie;
  static Color get dTexto => _m.dTexto;
  static Color get dTextoSuave => _m.dTextoSuave;
  static Color get dTextoClaro => _m.dTextoClaro;
  static Color get dBorde => _m.dBorde;
  static Color get dBordeClaro => _m.dBordeClaro;
  static Color get dDorado => _m.dDorado;
  static Color get dDoradoClaro => _m.dDoradoClaro;
  static Color get dCabecera => _m.dCabecera;
  static Color get dCabeceraOscura => _m.dCabeceraOscura;
  static Color get dSobreRelleno => _m.dSobreRelleno;

  // Semánticos de la marca (--color-success y --color-error de la web): verde
  // oliva y granate, con un tono medio que se lee en claro y en oscuro.
  static const acierto = Color(0xFF4A7D44);
  static const fallo = Color(0xFFA23A4C);
  static const blanco = Color(0xFF8F8698);
  // …y los de simulador.html para bordes y fondos de las opciones.
  static const aciertoWeb = Color(0xFF5E9156);
  static const falloWeb = Color(0xFFB4485A);
  static const avisoWeb = Color(0xFFB8860B);
}

/// Espacios (los de styles.css: --e1 … --e7).
class Espacio {
  Espacio._();
  static const e1 = 4.0, e2 = 8.0, e3 = 12.0, e4 = 16.0, e5 = 24.0, e6 = 32.0;
}

/// Radios: controles, tarjetas y píldoras (--radius-* de la web).
class Radios {
  Radios._();
  static const control = 4.0, boton = 6.0, tarjeta = 8.0, pildora = 999.0;
}

/// Versalitas de la serif (Pagella las tiene), en lugar de mayúsculas forzadas.
const versalitas = [FontFeature.enable('c2sc'), FontFeature.enable('smcp')];

/// Familias incluidas en assets/fonts. La web usa Palatino Linotype, que no
/// existe en Android ni iOS: TeX Gyre Pagella es su equivalente libre (deriva
/// de URW Palladio, que está en la lista de fuentes de styles.css).
class Fuentes {
  Fuentes._();
  static String get serif => Paleta.marca.serif;
  static String get sans => Paleta.marca.sans;
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

  static ColoresExtra get claro => ColoresExtra(
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

  static ColoresExtra get oscuro => ColoresExtra(
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

  /// Morado liso de la cabecera y de los bloques que la imitan (la web ya no
  /// usa degradados; se mantiene como degradado de un solo color por la API).
  LinearGradient get degradadoPrimario {
    final c = colorCabecera;
    return LinearGradient(colors: [c, c]);
  }

  Color get colorCabecera => temaOscuro ? Paleta.dCabecera : Paleta.primario;

  /// Color de los rellenos (en claro, el morado de la web) y del texto encima.
  Color get relleno => temaOscuro ? Paleta.dRelleno : Paleta.primario;
  Color get sobreRelleno => temaOscuro ? Paleta.dSobreRelleno : Colors.white;

  /// Filete dorado liso que cierra la cabecera (border-bottom de .site-header).
  LinearGradient get degradadoDorado {
    final oro = temaOscuro ? Paleta.dDorado : Paleta.dorado;
    return LinearGradient(colors: [oro, oro]);
  }

  /// Sombra de las tarjetas (--shadow-sm): apenas un punto de profundidad.
  List<BoxShadow> get sombraSuave => [BoxShadow(color: const Color(0xFF2A2530).withValues(alpha: temaOscuro ? 0.0 : 0.05), blurRadius: 2, offset: const Offset(0, 1))];
}

/// Borde de los botones de la web (.boton): fino alrededor y de 3 px abajo, más
/// oscuro, que da relieve; al pulsar se queda en 1 px (el botón «se hunde»).
class BordeImprenta extends OutlinedBorder {
  const BordeImprenta({this.color = Colors.transparent, this.abajo = 3, this.radio = 6, super.side});
  final Color color;
  final double abajo;
  final double radio;

  RRect _caja(Rect r) => RRect.fromRectAndRadius(r, Radius.circular(radio));

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: abajo);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path()..addRRect(_caja(Rect.fromLTRB(rect.left, rect.top, rect.right, rect.bottom - abajo + 1)));

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => Path()..addRRect(_caja(rect));

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (color.a == 0) return;
    final exterior = _caja(rect);
    final interior = RRect.fromRectAndCorners(
      Rect.fromLTRB(rect.left + 1, rect.top + 1, rect.right - 1, rect.bottom - abajo),
      topLeft: Radius.circular(radio - 1), topRight: Radius.circular(radio - 1),
      bottomLeft: Radius.circular(radio - 1), bottomRight: Radius.circular(radio - 1),
    );
    canvas.drawDRRect(exterior, interior, Paint()..color = color);
  }

  @override
  ShapeBorder scale(double t) => BordeImprenta(color: color, abajo: abajo * t, radio: radio * t);

  @override
  BordeImprenta copyWith({BorderSide? side, Color? color, double? abajo, double? radio}) =>
      BordeImprenta(color: color ?? this.color, abajo: abajo ?? this.abajo, radio: radio ?? this.radio);

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) =>
      a is BordeImprenta ? BordeImprenta(color: Color.lerp(a.color, color, t)!, abajo: a.abajo + (abajo - a.abajo) * t, radio: radio) : super.lerpFrom(a, t);

  @override
  bool operator ==(Object other) => other is BordeImprenta && other.color == color && other.abajo == abajo && other.radio == radio;

  @override
  int get hashCode => Object.hash(color, abajo, radio);
}

/// Forma de un botón según su estado: relieve de 3 px, o de 1 px al pulsarlo.
WidgetStateProperty<OutlinedBorder> formaImprenta(Color borde) => WidgetStateProperty.resolveWith(
      (s) => BordeImprenta(color: borde, abajo: s.contains(WidgetState.pressed) ? 1 : 3),
    );

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
    final relleno = oscuro ? Paleta.dRelleno : Paleta.primario;
    final sobre = oscuro ? Paleta.dSobreRelleno : Colors.white;
    final cabecera = oscuro ? Paleta.dCabecera : Paleta.primario;
    final fondo = oscuro ? Paleta.dFondo : Paleta.fondo;
    final texto = oscuro ? Paleta.dTexto : Paleta.texto;

    final esquema = ColorScheme(
      brightness: brillo,
      primary: primario,
      onPrimary: sobre,
      primaryContainer: extra.primarioPalido,
      onPrimaryContainer: oscuro ? Paleta.dPrimarioClaro : Paleta.primarioOscuro,
      secondary: extra.dorado,
      onSecondary: sobre,
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
        backgroundColor: cabecera,
        // La cabecera es siempre oscura: hora y batería en blanco.
        systemOverlayStyle: estiloBarrasSistema(arriba: cabecera, abajo: extra.superficie),
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
      // Menú (.main-nav de la web): fondo de papel, etiquetas en minúscula y la
      // sección activa en una píldora lila con el icono morado.
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: extra.superficie,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 68,
        indicatorColor: extra.primarioPalido,
        indicatorShape: const StadiumBorder(),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (s) => TextStyle(
            fontFamily: Fuentes.sans,
            fontSize: 11.5,
            fontWeight: s.contains(WidgetState.selected) ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: 0,
            color: s.contains(WidgetState.selected) ? primario : extra.textoSuave,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(size: 22, color: s.contains(WidgetState.selected) ? primario : extra.textoSuave),
        ),
      ),
      // En pantallas anchas (ordenador) el mismo menú va en un raíl a la izquierda.
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: extra.superficie,
        elevation: 0,
        indicatorColor: extra.primarioPalido,
        indicatorShape: const StadiumBorder(),
        selectedIconTheme: IconThemeData(size: 22, color: primario),
        unselectedIconTheme: IconThemeData(size: 22, color: extra.textoSuave),
        selectedLabelTextStyle: TextStyle(fontFamily: Fuentes.sans, fontSize: 12, fontWeight: FontWeight.w700, color: primario),
        unselectedLabelTextStyle: TextStyle(fontFamily: Fuentes.sans, fontSize: 12, fontWeight: FontWeight.w500, color: extra.textoSuave),
      ),
      // Botones de la web (.boton): principal de tinta y secundario de papel con
      // borde, los dos con el filete inferior que da relieve (BordeImprenta).
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: relleno,
          foregroundColor: sobre,
          textStyle: textos.labelLarge?.copyWith(fontSize: 15),
          padding: const EdgeInsets.fromLTRB(20, 11, 20, 13),
          minimumSize: const Size(64, 44),
          elevation: 0,
        ).copyWith(shape: formaImprenta(Color.lerp(relleno, Colors.black, oscuro ? 0.25 : 0.3)!)),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primario,
          backgroundColor: extra.superficie,
          side: BorderSide.none,
          textStyle: textos.labelLarge?.copyWith(fontSize: 15),
          padding: const EdgeInsets.fromLTRB(18, 11, 18, 13),
          minimumSize: const Size(64, 44),
        ).copyWith(shape: formaImprenta(oscuro ? const Color(0xFF544A5E) : const Color(0xFFA9BB9E))),
      ),
      // De texto: morado con el subrayado dorado de la marca.
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primario,
          textStyle: textos.labelLarge?.copyWith(decoration: TextDecoration.underline, decorationColor: extra.dorado, decorationThickness: 2),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(forma6),
          side: WidgetStatePropertyAll(BorderSide(color: extra.borde)),
          backgroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? relleno : extra.superficie),
          foregroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? sobre : texto),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radios.control)),
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
        backgroundColor: relleno,
        foregroundColor: sobre,
        elevation: 2,
        highlightElevation: 3,
        extendedTextStyle: textos.labelLarge?.copyWith(color: sobre, fontSize: 15),
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
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? relleno : null),
        checkColor: WidgetStatePropertyAll(sobre),
      ),
      badgeTheme: BadgeThemeData(backgroundColor: extra.dorado, textColor: sobre),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: primario, linearTrackColor: extra.fondoClaro),
      dividerTheme: DividerThemeData(color: extra.bordeClaro),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: oscuro ? const Color(0xFF2E2538) : Paleta.texto,
        contentTextStyle: textos.bodySmall?.copyWith(color: Colors.white, fontSize: 14),
        behavior: SnackBarBehavior.floating,
        shape: forma6,
        // Una ✕ para quitarlo sin esperar.
        showCloseIcon: true,
        closeIconColor: Colors.white70,
      ),
    );
  }

  static ThemeData get claro => _build(brillo: Brightness.light);
  static ThemeData get oscuro => _build(brillo: Brightness.dark);
}

/// Barras del sistema (hora, batería… arriba; botones o gesto abajo) con los
/// iconos en blanco o en negro según el fondo que tienen detrás.
SystemUiOverlayStyle estiloBarrasSistema({required Color arriba, required Color abajo}) {
  bool claro(Color c) => ThemeData.estimateBrightnessForColor(c) == Brightness.light;
  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: claro(arriba) ? Brightness.dark : Brightness.light,
    statusBarBrightness: claro(arriba) ? Brightness.light : Brightness.dark,
    systemNavigationBarColor: abajo,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: claro(abajo) ? Brightness.dark : Brightness.light,
    systemNavigationBarContrastEnforced: false,
  );
}
