import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'jitsi_listener.dart';
import 'jitsi_options.dart';
import 'jitsi_platform_interface.dart';
import 'jitsi_response.dart';

/// An implementation of [JitsiPlatform] that uses method channels.
class MethodChannelJitsi extends JitsiPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('jitsi');

  @visibleForTesting
  final eventChannel = const EventChannel('jitsi_events');

  final List<JitsiListener> _listeners = <JitsiListener>[];
  final Map<String, JitsiListener> _perMeetingListeners = {};

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<JitsiResponse> joinMeeting(
    JitsiOptions options, {
    JitsiListener? listener,
  }) async {
    // Attach a listener if it exists. The key is based on the serverURL + room
    if (listener != null) {
      String serverURL = options.serverURL ?? "https://meet.jit.si";
      String key;
      if (serverURL.endsWith("/")) {
        key = "$serverURL${options.room}";
      } else {
        key = "$serverURL/${options.room}";
      }

      _perMeetingListeners.update(key, (oldListener) => listener,
          ifAbsent: () => listener);
      initialize();
    }

    return await methodChannel
        .invokeMethod<String>('joinMeeting', {
          'room': options.room.trim(),
          'serverURL': options.serverURL?.trim(),
          'subject': options.subject,
          'token': options.token,
          'featureFlags': options.getFeatureFlags(),
          'userDisplayName': options.userDisplayName,
          'userEmail': options.userEmail,
          'iosAppBarRGBAColor': options.iosAppBarRGBAColor,
        })
        .then((message) => JitsiResponse(isSuccess: true, message: message))
        .catchError(
          (error) {
            return JitsiResponse(
                isSuccess: true, message: error.toString(), error: error);
          },
        );
  }

  @override
  closeMeeting() {
    methodChannel.invokeMethod('closeMeeting');
  }

  @override
  addListener(JitsiListener listener) {
    _listeners.add(listener);
    initialize();
  }

  @override
  removeListener(JitsiListener listener) {
    _listeners.remove(listener);
  }

  @override
  removeAllListeners() {
    _listeners.clear();
  }

  @override
  void initialize() {
    eventChannel.receiveBroadcastStream().listen((dynamic message) {
      _broadcastToGlobalListeners(message);
      _broadcastToPerMeetingListeners(message);
    }, onError: (dynamic error) {
      print('Jitsi Meet broadcast error: $error');
      for (var listener in _listeners) {
        if (listener.onError != null) listener.onError!(error);
      }
      _perMeetingListeners.forEach((key, listener) {
        if (listener.onError != null) listener.onError!(error);
      });
    });
  }

  /// Sends a broadcast to global listeners added using addListener
  void _broadcastToGlobalListeners(message) {
    for (var listener in _listeners) {
      switch (message['event']) {
        case "onConferenceWillJoin":
          if (listener.onConferenceWillJoin != null) {
            listener.onConferenceWillJoin!(message);
          }
          break;
        case "onConferenceJoined":
          if (listener.onConferenceJoined != null) {
            listener.onConferenceJoined!(message);
          }
          break;
        case "onConferenceTerminated":
          if (listener.onConferenceTerminated != null) {
            listener.onConferenceTerminated!(message);
          }
          break;
      }
    }
  }

  /// Sends a broadcast to per meeting listeners added during joinMeeting
  void _broadcastToPerMeetingListeners(message) {
    String? url = message['url'];
    final listener = _perMeetingListeners[url];
    if (listener != null) {
      switch (message['event']) {
        case "onConferenceWillJoin":
          if (listener.onConferenceWillJoin != null) {
            listener.onConferenceWillJoin!(message);
          }
          break;
        case "onConferenceJoined":
          if (listener.onConferenceJoined != null) {
            listener.onConferenceJoined!(message);
          }
          break;
        case "onConferenceTerminated":
          if (listener.onConferenceTerminated != null) {
            listener.onConferenceTerminated!(message);
          }

          // Remove the listener from the map of _perMeetingListeners on terminate
          _perMeetingListeners.remove(listener);
          break;
      }
    }
  }
}
