import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/models/articulo.dart';
import '../data/models/pregunta.dart';
import '../data/models/temario.dart';
import '../data/repos/contenido_repo.dart';
import '../data/repos/descargas_repo.dart';
import '../data/repos/usuario_repo.dart';
import '../features/test/leitner.dart';
import 'cache_http.dart';
import 'notificaciones.dart';

/// Servicios creados en main() antes de arrancar la app.
class Servicios {
  const Servicios({
    required this.http,
    required this.contenido,
    required this.usuario,
    required this.descargas,
    required this.firebaseDisponible,
  });
  final CacheHttp http;
  final ContenidoRepo contenido;
  final UsuarioRepo usuario;
  final DescargasRepo descargas;
  /// false si no hay google-services.json / GoogleService-Info.plist (modo sin cuenta).
  final bool firebaseDisponible;
}

final serviciosProvider = Provider<Servicios>((ref) => throw UnimplementedError('Se inyecta en main()'));

final contenidoProvider = Provider((ref) => ref.watch(serviciosProvider).contenido);
final usuarioRepoProvider = Provider((ref) => ref.watch(serviciosProvider).usuario);
final descargasProvider = Provider((ref) => ref.watch(serviciosProvider).descargas);

// ------------------------------------------------------------------ Contenido

final preguntasProvider = FutureProvider<BancoPreguntas>((ref) => ref.watch(contenidoProvider).preguntas());
final bloquesProvider = FutureProvider<Bloques>((ref) => ref.watch(contenidoProvider).bloques());
final temarioProvider = FutureProvider<Temario>((ref) => ref.watch(contenidoProvider).temario());
final enlacesProvider = FutureProvider<List<CategoriaEnlaces>>((ref) => ref.watch(contenidoProvider).enlaces());
final articulosProvider = FutureProvider<List<Articulo>>((ref) => ref.watch(contenidoProvider).articulos());
final configProvider = FutureProvider<AppConfig>((ref) => ref.watch(contenidoProvider).config());

// ------------------------------------------------------------------ Sesión

final authStateProvider = StreamProvider<User?>((ref) {
  if (!ref.watch(serviciosProvider).firebaseDisponible) return Stream.value(null);
  return FirebaseAuth.instance.authStateChanges();
});

final usuarioActualProvider = Provider<User?>((ref) => ref.watch(authStateProvider).value);

class SesionNotifier extends Notifier<bool> {
  @override
  bool build() => false; // ocupado

  Future<String?> iniciarConGoogle() async {
    state = true;
    try {
      final google = await GoogleSignIn(scopes: const ['email']).signIn();
      if (google == null) return null; // cancelado
      final auth = await google.authentication;
      final cred = GoogleAuthProvider.credential(accessToken: auth.accessToken, idToken: auth.idToken);
      await FirebaseAuth.instance.signInWithCredential(cred);
      await ref.read(usuarioRepoProvider).sincronizarTodo();
      ref.invalidate(leitnerProvider);
      ref.invalidate(ajustesProvider);
      ref.invalidate(historialProvider);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? e.code;
    } catch (e) {
      return e.toString();
    } finally {
      state = false;
    }
  }

  Future<void> cerrarSesion() async {
    try {
      await GoogleSignIn().signOut();
    } catch (_) {}
    await FirebaseAuth.instance.signOut();
    ref.invalidate(historialProvider);
  }
}

final sesionProvider = NotifierProvider<SesionNotifier, bool>(SesionNotifier.new);

// ------------------------------------------------------------------ Usuario

final historialProvider = FutureProvider((ref) {
  ref.watch(authStateProvider);
  return ref.watch(usuarioRepoProvider).historial();
});

class LeitnerNotifier extends Notifier<EstadoLeitner> {
  @override
  EstadoLeitner build() => ref.read(usuarioRepoProvider).leitner();

  Future<void> registrarExamen(Map<int, bool> resultados) async {
    final e = EstadoLeitner.fromJson(state.toJson())..registrarExamen(resultados);
    state = e;
    await ref.read(usuarioRepoProvider).guardarLeitner(e);
  }

  Future<void> reiniciar() async {
    state = EstadoLeitner();
    await ref.read(usuarioRepoProvider).guardarLeitner(state);
  }
}

final leitnerProvider = NotifierProvider<LeitnerNotifier, EstadoLeitner>(LeitnerNotifier.new);

class AjustesNotifier extends Notifier<Ajustes> {
  @override
  Ajustes build() => ref.read(usuarioRepoProvider).ajustes();

  Future<void> actualizar(Ajustes Function(Ajustes) f) async {
    final nuevo = f(state);
    state = nuevo;
    await ref.read(usuarioRepoProvider).guardarAjustes(nuevo);
  }

  Future<void> registrarActividad() => actualizar((a) => a.conActividadHoy());

  Future<void> alternarEstudiado(String codigo) => actualizar((a) {
        final s = {...a.temasEstudiados};
        s.contains(codigo) ? s.remove(codigo) : s.add(codigo);
        return a.copyWith(temasEstudiados: s);
      });

  Future<void> alternarRepaso(String codigo) => actualizar((a) {
        final s = {...a.temasEnRepaso};
        s.contains(codigo) ? s.remove(codigo) : s.add(codigo);
        return a.copyWith(temasEnRepaso: s);
      });

  Future<void> fijarRecordatorio(int minutos) async {
    await actualizar((a) => a.copyWith(horaRecordatorio: minutos));
    await Notificaciones.programarRecordatorio(minutos);
  }
}

final ajustesProvider = NotifierProvider<AjustesNotifier, Ajustes>(AjustesNotifier.new);

final modoTemaProvider = Provider<ThemeMode>((ref) {
  final t = ref.watch(ajustesProvider.select((a) => a.temaOscuro));
  return t == null ? ThemeMode.system : (t ? ThemeMode.dark : ThemeMode.light);
});

/// Marca de "test diario hecho hoy" (según historial local).
final testDiarioHechoProvider = Provider<bool>((ref) {
  ref.watch(historialProvider);
  final hoy = Ajustes.claveDia(DateTime.now());
  return ref
      .read(usuarioRepoProvider)
      .resultadosLocales()
      .any((r) => r.tipo == 'diario' && Ajustes.claveDia(r.timestamp) == hoy);
});
