import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'orba_one_sdk_flutter_method_channel.dart';

abstract class OrbaOneSdkFlutterPlatform extends PlatformInterface {
  /// Constructs a OrbaOneSdkFlutterPlatform.
  OrbaOneSdkFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static OrbaOneSdkFlutterPlatform _instance = MethodChannelOrbaOneSdkFlutter();

  /// The default instance of [OrbaOneSdkFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelOrbaOneSdkFlutter].
  static OrbaOneSdkFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OrbaOneSdkFlutterPlatform] when
  /// they register themselves.
  static set instance(OrbaOneSdkFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Returns true if the Naurt SDK is initialized
  Future<bool> initialize({required String apiKey, required String appId}) async {
    throw UnimplementedError('OrbaOne initialize() has not been implemented.');
  }
}
