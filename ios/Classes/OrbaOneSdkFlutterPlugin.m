#import "OrbaOneSdkFlutterPlugin.h"
#if __has_include(<orba_one_sdk_flutter/orba_one_sdk_flutter-Swift.h>)
#import <orba_one_sdk_flutter/orba_one_sdk_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "orba_one_sdk_flutter-Swift.h"
#endif

@implementation OrbaOneSdkFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOrbaOneSdkFlutterPlugin registerWithRegistrar:registrar];
}
@end
