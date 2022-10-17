import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orba_one_sdk_flutter/orba_one_sdk_flutter_method_channel.dart';

void main() {
  MethodChannelOrbaOneSdkFlutter platform = MethodChannelOrbaOneSdkFlutter();
  const MethodChannel channel = MethodChannel('orba_one_sdk_flutter');

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
    expect(await platform.initialize(apiKey: "apiKey", appId: "appId"), false);
  });
}
