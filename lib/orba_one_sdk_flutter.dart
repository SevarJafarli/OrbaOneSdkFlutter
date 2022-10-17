
import 'orba_one_sdk_flutter_platform_interface.dart';

class OrbaOneSdkFlutter extends OrbaOneSdkFlutterPlatform {
 
 @override
  Future<bool> initialize({required String apiKey, required String appId}) async {
   return OrbaOneSdkFlutterPlatform.instance.initialize(apiKey: apiKey, appId: appId);
  }
}
