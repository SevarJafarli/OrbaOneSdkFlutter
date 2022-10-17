package com.example.orba_one_sdk_flutter;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.orbaone.orba_one_capture_sdk_core.OrbaOne;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;

/** OrbaOneSdkFlutterPlugin */
public class OrbaOneSdkFlutterPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native
  /// Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine
  /// and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "orba_one_sdk_flutter");
    channel.setMethodCallHandler(this);

  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("initialize")) {
      String apiKey = call.argument("apiKey");
      String appId = call.argument("appId");
      try {
        OrbaOne oneSdk = new OrbaOne.Builder().setApiKey(apiKey).setApplicantId(appId).create();
        oneSdk.startVerification(this);
        result.success(true);
      } catch (Exception err) {
        result.success(false);
      }

    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
