package es.victorgutierrezmarcos.tcee_app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale
import java.util.concurrent.TimeUnit

/**
 * Widget de la pantalla de inicio. La app deja los datos (fechas en
 * milisegundos y textos) con home_widget; aquí se calculan los días que
 * faltan y el «hoy»/«mañana», para que siga bien al cambiar de día aunque
 * no se abra la app. Cada zona abre su pantalla.
 */
class WidgetTcee : HomeWidgetProvider() {

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        for (id in appWidgetIds) {
            appWidgetManager.updateAppWidget(id, vista(context, widgetData))
        }
    }

    private fun vista(context: Context, datos: SharedPreferences): RemoteViews {
        val v = RemoteViews(context.packageName, R.layout.widget_tcee)
        val ahora = System.currentTimeMillis()
        v.setTextViewText(R.id.widget_siglas, datos.getString("siglas", "TCEE"))

        // Cuenta atrás.
        val examen = datos.getString("examen", null)?.toLongOrNull()
        val dias = examen?.let { diasEntre(ahora, it) }
        if (dias != null && dias >= 0) {
            v.setTextViewText(R.id.widget_dias, dias.toString())
            v.setTextViewText(R.id.widget_dias_texto, "${if (dias == 1L) "día" else "días"} para el ${datos.getString("examen_nombre", "examen")}")
        } else {
            v.setTextViewText(R.id.widget_dias, "—")
            v.setTextViewText(R.id.widget_dias_texto, "Pon la fecha del examen")
        }

        // Próximo cante o clase (si ya ha pasado, se oculta hasta que la app mande el siguiente).
        val cante = datos.getString("cante", null)?.toLongOrNull()
        val preparador = datos.getBoolean("preparador", false)
        v.setTextViewText(
            R.id.widget_cante,
            if (cante != null && cante > ahora - TimeUnit.HOURS.toMillis(1)) "${cuando(ahora, cante)} · ${datos.getString("cante_texto", "")}"
            else if (preparador) "Sin clases programadas" else "Sin cantes programados"
        )

        // Semana del cronograma y test diario.
        v.setTextViewText(R.id.widget_semana, datos.getString("semana", null) ?: "Sin cronograma")
        val hoy = SimpleDateFormat("yyyy-MM-dd", Locale.US).format(ahora)
        v.setTextViewText(R.id.widget_test, if (datos.getString("test_hecho", "") == hoy) "Test diario ✓" else "Test diario: te espera")

        v.setOnClickPendingIntent(R.id.widget_cabecera, abrir(context, "organizacion/convocatoria"))
        v.setOnClickPendingIntent(R.id.widget_cante, abrir(context, "cantes"))
        v.setOnClickPendingIntent(R.id.widget_semana, abrir(context, "organizacion/cronograma"))
        v.setOnClickPendingIntent(R.id.widget_test, abrir(context, "test-diario"))
        return v
    }

    private fun abrir(context: Context, ruta: String) =
        HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java, Uri.parse("tcee://widget/$ruta"))

    /** Días naturales entre hoy y ese día. */
    private fun diasEntre(desde: Long, hasta: Long): Long {
        fun dia(ms: Long) = Calendar.getInstance().apply {
            timeInMillis = ms
            set(Calendar.HOUR_OF_DAY, 12); set(Calendar.MINUTE, 0); set(Calendar.SECOND, 0); set(Calendar.MILLISECOND, 0)
        }.timeInMillis
        return Math.round((dia(hasta) - dia(desde)) / 86_400_000.0)
    }

    /** «Hoy 18:00», «Mañana 18:00» o «jue 15, 18:00». */
    private fun cuando(ahora: Long, ms: Long): String {
        val es = Locale.forLanguageTag("es-ES")
        val hora = SimpleDateFormat("HH:mm", es).format(ms)
        return when (diasEntre(ahora, ms)) {
            0L -> "Hoy $hora"
            1L -> "Mañana $hora"
            else -> SimpleDateFormat("EEE d, HH:mm", es).format(ms)
        }
    }
}
