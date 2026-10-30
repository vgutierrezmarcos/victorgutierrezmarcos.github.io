package es.victorgutierrezmarcos.tcee_app

import android.Manifest
import android.content.ComponentName
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.PowerManager
import android.provider.Settings
import android.speech.RecognitionListener
import android.speech.RecognizerIntent
import android.speech.SpeechRecognizer
import com.android.installreferrer.api.InstallReferrerClient
import com.android.installreferrer.api.InstallReferrerStateListener
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    // Enlaces de invitación que llegan con la app ya abierta (core/enlaces_io.dart).
    private var enlaces: EventChannel.EventSink? = null

    // Ajustes del sistema que la app no puede cambiar por sí misma: los abre
    // para que el usuario active los avisos o quite la optimización de batería.
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "es.victorgutierrezmarcos.tcee_app/enlaces").setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) { enlaces = events }
            override fun onCancel(arguments: Any?) { enlaces = null }
        })
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "es.victorgutierrezmarcos.tcee_app/sistema").setMethodCallHandler { call, result ->
            when (call.method) {
                // El enlace con el que se abrió la app (App Links), si fue así.
                "enlaceInicial" -> result.success(if (intent?.action == Intent.ACTION_VIEW) intent?.dataString else null)
                "referrerInstalacion" -> leerReferrer(result)
                "ajustesNotificaciones" -> result.success(abrir(ajustesNotificaciones()))
                "ajustesBateria" -> result.success(abrir(Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS)))
                "pedirSinRestriccionBateria" -> result.success(pedirSinRestriccionBateria())
                "fabricante" -> result.success(Build.MANUFACTURER.lowercase())
                "ajustesFabricante" -> result.success(abrirAjustesFabricante())
                "ignoraBateria" -> {
                    val pm = getSystemService(POWER_SERVICE) as PowerManager
                    result.success(pm.isIgnoringBatteryOptimizations(packageName))
                }
                else -> result.notImplemented()
            }
        }
        configurarDictado(flutterEngine)
    }

    // ------------------------------------------------------------------
    // Transcripción del cante (core/dictado_io.dart): SpeechRecognizer en
    // es-ES con resultados parciales y preferencia por el reconocimiento en
    // el dispositivo. Android corta la escucha en cada silencio, así que se
    // vuelve a lanzar sola hasta que Flutter dice «parar»: aguanta los 30
    // minutos (o más) del cante. Cada resultado va con el instante en que se
    // empezó a decir, para la marca de minuto. Nada se guarda aquí.

    private var dictadoEventos: EventChannel.EventSink? = null
    private var reconocedor: SpeechRecognizer? = null
    private var dictando = false
    private var idiomaDictado = "es-ES"
    private var soloDispositivo = true
    private var inicioFrase = 0L
    private val principal = Handler(Looper.getMainLooper())

    private fun configurarDictado(flutterEngine: FlutterEngine) {
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "es.victorgutierrezmarcos.tcee_app/dictado/eventos").setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) { dictadoEventos = events }
            override fun onCancel(arguments: Any?) { dictadoEventos = null }
        })
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "es.victorgutierrezmarcos.tcee_app/dictado").setMethodCallHandler { call, result ->
            when (call.method) {
                "disponible" -> result.success(SpeechRecognizer.isRecognitionAvailable(this))
                "empezar" -> {
                    if (!SpeechRecognizer.isRecognitionAvailable(this)) {
                        result.error("sin_reconocimiento", "Este móvil no tiene reconocimiento de voz.", null)
                    } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && checkSelfPermission(Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
                        result.error("sin_permiso", "Sin permiso de micrófono.", null)
                    } else {
                        idiomaDictado = call.argument<String>("idioma") ?: "es-ES"
                        soloDispositivo = true
                        dictando = true
                        escuchar()
                        result.success(null)
                    }
                }
                "parar" -> {
                    pararDictado()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun enviarDictado(tipo: String, texto: String = "", desde: Long = System.currentTimeMillis()) {
        principal.post { dictadoEventos?.success(mapOf("tipo" to tipo, "texto" to texto, "desde" to desde)) }
    }

    private fun intencionDictado(): Intent = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH).apply {
        putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM)
        putExtra(RecognizerIntent.EXTRA_LANGUAGE, idiomaDictado)
        putExtra(RecognizerIntent.EXTRA_PARTIAL_RESULTS, true)
        putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, 1)
        // En el dispositivo si se puede (sin enviar la voz a ningún servidor);
        // si no tiene el idioma descargado, Android usa su servicio de voz.
        putExtra(RecognizerIntent.EXTRA_PREFER_OFFLINE, soloDispositivo)
        // Pausas largas sin cortar (algunos reconocedores lo ignoran).
        putExtra(RecognizerIntent.EXTRA_SPEECH_INPUT_COMPLETE_SILENCE_LENGTH_MILLIS, 4000L)
        putExtra(RecognizerIntent.EXTRA_SPEECH_INPUT_POSSIBLY_COMPLETE_SILENCE_LENGTH_MILLIS, 4000L)
        putExtra(RecognizerIntent.EXTRA_CALLING_PACKAGE, packageName)
    }

    private fun escuchar() {
        if (!dictando) return
        try {
            if (reconocedor == null) {
                reconocedor = SpeechRecognizer.createSpeechRecognizer(this).apply { setRecognitionListener(oyente) }
            }
            inicioFrase = 0L
            reconocedor?.startListening(intencionDictado())
        } catch (e: Exception) {
            reintentarDictado(500)
        }
    }

    private fun reintentarDictado(ms: Long) {
        if (!dictando) return
        principal.postDelayed({ escuchar() }, ms)
    }

    /// Se rehace el reconocedor (tras un error del cliente o del servicio).
    private fun rehacerReconocedor() {
        try { reconocedor?.destroy() } catch (e: Exception) {}
        reconocedor = null
    }

    private fun pararDictado() {
        dictando = false
        principal.removeCallbacksAndMessages(null)
        try { reconocedor?.stopListening() } catch (e: Exception) {}
        rehacerReconocedor()
        enviarDictado("parado")
    }

    private val oyente = object : RecognitionListener {
        override fun onReadyForSpeech(params: Bundle?) {}
        override fun onBeginningOfSpeech() {
            if (inicioFrase == 0L) inicioFrase = System.currentTimeMillis()
        }
        override fun onRmsChanged(rmsdB: Float) {}
        override fun onBufferReceived(buffer: ByteArray?) {}
        override fun onEndOfSpeech() {}
        override fun onEvent(eventType: Int, params: Bundle?) {}

        override fun onPartialResults(partialResults: Bundle?) {
            val texto = partialResults?.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION)?.firstOrNull() ?: return
            if (texto.isBlank()) return
            if (inicioFrase == 0L) inicioFrase = System.currentTimeMillis()
            enviarDictado("parcial", texto, inicioFrase)
        }

        override fun onResults(results: Bundle?) {
            val texto = results?.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION)?.firstOrNull() ?: ""
            if (texto.isNotBlank()) enviarDictado("definitivo", texto, if (inicioFrase == 0L) System.currentTimeMillis() else inicioFrase)
            // Silencio: se vuelve a escuchar enseguida.
            reintentarDictado(50)
        }

        override fun onError(error: Int) {
            if (!dictando) return
            when (error) {
                SpeechRecognizer.ERROR_INSUFFICIENT_PERMISSIONS -> {
                    dictando = false
                    rehacerReconocedor()
                    enviarDictado("error", "Sin permiso de micrófono.")
                }
                // Sin el idioma en el dispositivo (Android 12+): con el servicio de voz.
                12, 13 -> {
                    if (soloDispositivo) {
                        soloDispositivo = false
                        reintentarDictado(100)
                    } else {
                        dictando = false
                        rehacerReconocedor()
                        enviarDictado("error", "El reconocimiento de voz no tiene el español.")
                    }
                }
                // Nada reconocido o silencio largo: se sigue escuchando.
                SpeechRecognizer.ERROR_NO_MATCH, SpeechRecognizer.ERROR_SPEECH_TIMEOUT -> reintentarDictado(50)
                // Ocupado, cliente o servicio caídos, red: se rehace y se reintenta.
                else -> {
                    rehacerReconocedor()
                    reintentarDictado(if (error == SpeechRecognizer.ERROR_RECOGNIZER_BUSY) 600 else 300)
                }
            }
        }
    }

    override fun onDestroy() {
        dictando = false
        principal.removeCallbacksAndMessages(null)
        rehacerReconocedor()
        super.onDestroy()
    }

    // Enlace tocado con la app abierta (launchMode singleTop): a Flutter.
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        if (intent.action == Intent.ACTION_VIEW) intent.dataString?.let { enlaces?.success(it) }
    }

    // El «referrer» con el que Google Play instaló la app (API Install
    // Referrer, sin permisos): lleva el código del preparador si la
    // instalación salió de su enlace de invitación. Null si no hay o falla.
    private fun leerReferrer(result: MethodChannel.Result) {
        val cliente = try {
            InstallReferrerClient.newBuilder(this).build()
        } catch (e: Exception) {
            result.success(null)
            return
        }
        var contestado = false
        fun contestar(valor: String?) {
            if (contestado) return
            contestado = true
            runOnUiThread { result.success(valor) }
            try { cliente.endConnection() } catch (e: Exception) {}
        }
        try {
            cliente.startConnection(object : InstallReferrerStateListener {
                override fun onInstallReferrerSetupFinished(codigo: Int) {
                    contestar(
                        if (codigo == InstallReferrerClient.InstallReferrerResponse.OK) {
                            try { cliente.installReferrer.installReferrer } catch (e: Exception) { null }
                        } else null
                    )
                }

                override fun onInstallReferrerServiceDisconnected() = contestar(null)
            })
        } catch (e: Exception) {
            contestar(null)
        }
    }

    // Diálogo del sistema «¿Permitir que la app se ejecute siempre en segundo
    // plano?». Si no existe en este móvil, la lista de optimización de batería.
    private fun pedirSinRestriccionBateria(): Boolean {
        val pm = getSystemService(POWER_SERVICE) as PowerManager
        if (pm.isIgnoringBatteryOptimizations(packageName)) return true
        return try {
            startActivity(Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS, Uri.parse("package:$packageName")).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
            true
        } catch (e: Exception) {
            abrir(Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS))
        }
    }

    // Ajustes del ahorro de batería propio del fabricante (inicio automático,
    // actividad en segundo plano), si se conocen; si no, los de la app.
    private fun abrirAjustesFabricante(): Boolean {
        val pantallas = listOf(
            "com.miui.securitycenter" to "com.miui.permcenter.autostart.AutoStartManagementActivity",
            "com.huawei.systemmanager" to "com.huawei.systemmanager.startupmgr.ui.StartupNormalAppListActivity",
            "com.huawei.systemmanager" to "com.huawei.systemmanager.optimize.process.ProtectActivity",
            "com.hihonor.systemmanager" to "com.hihonor.systemmanager.startupmgr.ui.StartupNormalAppListActivity",
            "com.coloros.safecenter" to "com.coloros.safecenter.permission.startup.StartupAppListActivity",
            "com.oplus.safecenter" to "com.oplus.safecenter.permission.startup.StartupAppListActivity",
            "com.vivo.permissionmanager" to "com.vivo.permissionmanager.activity.BgStartUpManagerActivity",
            "com.iqoo.secure" to "com.iqoo.secure.ui.phoneoptimize.BgStartUpManager",
            "com.samsung.android.lool" to "com.samsung.android.sm.battery.ui.BatteryActivity",
        )
        for ((paquete, actividad) in pantallas) {
            try {
                startActivity(Intent().setComponent(ComponentName(paquete, actividad)).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
                return true
            } catch (e: Exception) {
                // No es este fabricante (o la pantalla ha cambiado de nombre): la siguiente.
            }
        }
        return abrir(Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:$packageName")))
    }

    private fun ajustesNotificaciones(): Intent =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS).putExtra(Settings.EXTRA_APP_PACKAGE, packageName)
        } else {
            Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:$packageName"))
        }

    private fun abrir(intent: Intent): Boolean = try {
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivity(intent)
        true
    } catch (e: Exception) {
        // Sin pantalla para ese ajuste en este dispositivo: la de la app.
        try {
            startActivity(Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:$packageName")).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
            true
        } catch (e2: Exception) {
            false
        }
    }
}
