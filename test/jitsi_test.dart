import 'package:flutter_test/flutter_test.dart';
import 'package:jitsi/jitsi.dart';
import 'package:jitsi/jitsi_platform_interface.dart';
import 'package:jitsi/jitsi_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockJitsiPlatform
//     with MockPlatformInterfaceMixin
//     implements JitsiPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

void main() {
  final JitsiPlatform initialPlatform = JitsiPlatform.instance;

  test('$MethodChannelJitsi is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelJitsi>());
  });

  test('getPlatformVersion', () async {
    Jitsi jitsiPlugin = Jitsi();
    // MockJitsiPlatform fakePlatform = MockJitsiPlatform();
    // JitsiPlatform.instance = fakePlatform;

    expect(await jitsiPlugin.getPlatformVersion(), '42');
  });
}
