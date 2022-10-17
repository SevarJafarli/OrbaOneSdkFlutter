import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'orba_one_sdk_flutter_platform_interface.dart';

/// An implementation of [OrbaOneSdkFlutterPlatform] that uses method channels.
class MethodChannelOrbaOneSdkFlutter extends OrbaOneSdkFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('orba_one_sdk_flutter');

  @override
  Future<bool> initialize({required String apiKey, required String appId}) async {
    final bool isInitialized = await methodChannel.invokeMethod('initialize', {
      'apiKey': apiKey,
      'appId': appId
    }); 

    return isInitialized;
  }
}
