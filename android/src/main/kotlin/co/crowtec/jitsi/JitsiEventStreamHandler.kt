package co.crowtec.jitsi
import android.util.Log
import co.crowtec.jitsi.JitsiPlugin.Companion.JITSI_PLUGIN_TAG
import io.flutter.plugin.common.EventChannel
import java.io.Serializable

class JitsiEventStreamHandler private constructor() : EventChannel.StreamHandler, Serializable {
    companion object  {
        val instance = JitsiEventStreamHandler()
    }

    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink?) {
        Log.d(JITSI_PLUGIN_TAG, "JitsiEventStreamHandler.onListen")
        this.eventSink = eventSink
    }

    override fun onCancel(arguments: Any?) {
        Log.d(JITSI_PLUGIN_TAG, "JitsiEventStreamHandler.onCancel")
        eventSink = null
    }

    fun onConferenceWillJoin(data: MutableMap<String, Any>?) {
        Log.d(JITSI_PLUGIN_TAG, "JitsiEventStreamHandler.onConferenceWillJoin")
        data?.put("event", "onConferenceWillJoin")
        eventSink?.success(data)
    }

    fun onConferenceJoined(data: MutableMap<String, Any>?) {
        Log.d(JITSI_PLUGIN_TAG, "JitsiEventStreamHandler.onConferenceJoined")
        data?.put("event", "onConferenceJoined")
        eventSink?.success(data)
    }

    fun onConferenceTerminated(data: MutableMap<String, Any>?) {
        Log.d(JITSI_PLUGIN_TAG, "JitsiEventStreamHandler.onConferenceTerminated")
        data?.put("event", "onConferenceTerminated")
        eventSink?.success(data)
    }

    fun onPictureInPictureWillEnter() {
        Log.d(JITSI_PLUGIN_TAG, "JitsiEventStreamHandler.onPictureInPictureWillEnter")
        var data: HashMap<String, String> = HashMap<String, String>()
        data?.put("event", "onPictureInPictureWillEnter")
        eventSink?.success(data)
    }

    fun onPictureInPictureTerminated() {
        Log.d(JITSI_PLUGIN_TAG, "JitsiEventStreamHandler.onPictureInPictureTerminated")
        var data: HashMap<String, String> = HashMap<String, String>()
        data?.put("event", "onPictureInPictureTerminated")
        eventSink?.success(data)
    }
}

