import 'package:flutter_test/flutter_test.dart';
import 'package:orba_one_sdk_flutter/orba_one_sdk_flutter.dart';
import 'package:orba_one_sdk_flutter/orba_one_sdk_flutter_platform_interface.dart';
import 'package:orba_one_sdk_flutter/orba_one_sdk_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOrbaOneSdkFlutterPlatform with MockPlatformInterfaceMixin implements OrbaOneSdkFlutterPlatform {
  @override
  Future<bool> initialize({required String apiKey, required String appId}) => Future.value(true);
}

void main() {
  final OrbaOneSdkFlutterPlatform initialPlatform = OrbaOneSdkFlutterPlatform.instance;

  test('$MethodChannelOrbaOneSdkFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOrbaOneSdkFlutter>());
  });

  test('getPlatformVersion', () async {
    OrbaOneSdkFlutter orbaOneSdkFlutterPlugin = OrbaOneSdkFlutter();
    MockOrbaOneSdkFlutterPlatform fakePlatform = MockOrbaOneSdkFlutterPlatform();
    OrbaOneSdkFlutterPlatform.instance = fakePlatform;

    expect(await orbaOneSdkFlutterPlugin.initialize(apiKey: "", appId: ""), false);
  });
}
