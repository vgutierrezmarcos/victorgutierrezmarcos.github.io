import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Firebase (proyecto web-vgm): sin google-services.json la app compila y
// funciona igualmente, pero sin inicio de sesión ni sincronización.
if (file("google-services.json").exists()) {
    apply(plugin = "com.google.gms.google-services")
}

// Firma: android/key.properties (fuera del repositorio) apunta al almacén de
// claves. Con él se firman también las compilaciones de depuración, para que
// la huella SHA-1 registrada en Firebase sea siempre la misma y funcione el
// inicio de sesión con Google. Sin él se usa la clave de depuración de la máquina.
val claves = Properties().apply {
    val f = rootProject.file("key.properties")
    if (f.exists()) f.inputStream().use { load(it) }
}

android {
    namespace = "es.victorgutierrezmarcos.tcee_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // flutter_local_notifications necesita "desugaring" de las API de Java 8+.
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    signingConfigs {
        if (claves.containsKey("storeFile")) {
            create("tcee") {
                storeFile = rootProject.file(claves.getProperty("storeFile"))
                storePassword = claves.getProperty("storePassword")
                keyAlias = claves.getProperty("keyAlias")
                keyPassword = claves.getProperty("keyPassword")
            }
        }
    }

    defaultConfig {
        applicationId = "es.victorgutierrezmarcos.tcee_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        val firma = signingConfigs.findByName("tcee") ?: signingConfigs.getByName("debug")
        release {
            signingConfig = firma
        }
        debug {
            signingConfig = firma
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
