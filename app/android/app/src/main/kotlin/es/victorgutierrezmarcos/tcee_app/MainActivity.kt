package es.victorgutierrezmarcos.tcee_app

import android.content.ComponentName
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
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
