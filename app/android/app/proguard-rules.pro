# Firebase en la compilación de Play (R8). Firebase distingue sus ejecutores
# con anotaciones (@Background, @Blocking, @Lightweight, @UiThread) que R8
# renombraba o fusionaba; Crashlytics dejaba de registrarse y Firebase no
# arrancaba: «FirebaseCrashlytics component is not present» y sin inicio de
# sesión en las versiones 1.19.2 a 1.20.4 de Google Play (27 oct. 2026).
-keep class com.google.firebase.** { *; }
-keep interface com.google.firebase.** { *; }
-keep class io.flutter.plugins.firebase.** { *; }
-keepattributes *Annotation*, Signature, InnerClasses, EnclosingMethod
