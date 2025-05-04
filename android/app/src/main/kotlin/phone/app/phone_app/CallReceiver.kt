package phone.app.phone_app

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.telephony.TelephonyManager
import android.util.Log
import androidx.core.app.NotificationCompat

class CallReceiver : BroadcastReceiver() {
    companion object {
        private var lastNotificationTime = 0L
    }

    override fun onReceive(context: Context, intent: Intent) {
        val currentTime = System.currentTimeMillis()
        if (currentTime - lastNotificationTime < 2000) return
        lastNotificationTime = currentTime
        val state = intent.getStringExtra(TelephonyManager.EXTRA_STATE)

        when (state) {
            TelephonyManager.EXTRA_STATE_RINGING -> {
                Log.d("CallReceiver", "Incoming call is ringing")
                showNotification(context, "Incoming Call", "Phone is ringing...")
            }
            TelephonyManager.EXTRA_STATE_OFFHOOK -> {
                Log.d("CallReceiver", "Call answered or outgoing")
                showNotification(context, "Call Active", "Call in progress")
            }
            TelephonyManager.EXTRA_STATE_IDLE -> {
                Log.d("CallReceiver", "Call ended or rejected")
                showNotification(context, "Call Ended", "Call was disconnected")
            }
        }

        if (intent.action == Intent.ACTION_NEW_OUTGOING_CALL) {
            val number = intent.getStringExtra(Intent.EXTRA_PHONE_NUMBER)
            Log.d("CallReceiver", "Outgoing call to: $number")
            showNotification(context, "Outgoing Call", "Calling $number")
        }
    }

    private fun showNotification(context: Context, title: String, message: String) {
        val channelId = "call_channel_id"
        val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(channelId, "Call Notifications", NotificationManager.IMPORTANCE_HIGH)
            notificationManager.createNotificationChannel(channel)
        }

        val builder = NotificationCompat.Builder(context, channelId)
            .setSmallIcon(android.R.drawable.sym_call_incoming)
            .setContentTitle(title)
            .setContentText(message)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)

        notificationManager.notify((System.currentTimeMillis() % 10000).toInt(), builder.build())
    }
}
