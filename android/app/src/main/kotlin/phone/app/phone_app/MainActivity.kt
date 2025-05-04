package phone.app.phone_app

import android.content.Intent
import android.os.Bundle
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.phone.app/call"

    override fun configureFlutterEngine(@NonNull flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "liftCall") {
                liftCall()
                result.success("Lift attempt sent")
            }
        }
    }

    private fun liftCall() {
        // ❗️WORKS ON ROOTED DEVICES ONLY or CUSTOM ROMS
        try {
            val command = "input keyevent KEYCODE_HEADSETHOOK"
            Runtime.getRuntime().exec(arrayOf("su", "-c", command))
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
