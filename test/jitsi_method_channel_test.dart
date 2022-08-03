import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jitsi/jitsi_method_channel.dart';

void main() {
  MethodChannelJitsi platform = MethodChannelJitsi();
  const MethodChannel channel = MethodChannel('jitsi');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
