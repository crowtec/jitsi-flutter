import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'jitsi_method_channel.dart';
import 'jitsi_listener.dart';
import 'jitsi_options.dart';
import 'jitsi_response.dart';

export 'jitsi_listener.dart';
export 'jitsi_options.dart';
export 'jitsi_response.dart';
export 'feature_flag_type.dart';

abstract class JitsiPlatform extends PlatformInterface {
  /// Constructs a JitsiPlatform.
  JitsiPlatform() : super(token: _token);

  static final Object _token = Object();

  static JitsiPlatform _instance = MethodChannelJitsi();

  /// The default instance of [JitsiPlatform] to use.
  ///
  /// Defaults to [MethodChannelJitsi].
  static JitsiPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [JitsiPlatform] when
  /// they register themselves.
  static set instance(JitsiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<JitsiResponse> joinMeeting(JitsiOptions options,
      {JitsiListener? listener}) async {
    throw UnimplementedError('joinMeeting has not been implemented.');
  }

  closeMeeting() {
    throw UnimplementedError('closeMeeting has not been implemented.');
  }

  addListener(JitsiListener listener) {
    throw UnimplementedError('addListener has not been implemented.');
  }

  removeListener(JitsiListener listener) {
    throw UnimplementedError('removeListener has not been implemented.');
  }

  removeAllListeners() {
    throw UnimplementedError('removeAllListeners has not been implemented.');
  }

  void initialize() {
    throw UnimplementedError('_initialize has not been implemented.');
  }
}
