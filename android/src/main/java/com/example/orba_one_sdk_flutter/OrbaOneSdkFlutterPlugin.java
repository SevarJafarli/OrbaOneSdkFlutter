package com.example.orba_one_sdk_flutter;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.orbaone.orba_one_capture_sdk_core.OrbaOne;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.android.FlutterActivity;
import android.app.Activity;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import androidx.appcompat.app.AppCompatActivity;
import io.flutter.embedding.android.FlutterFragmentActivity;
import android.content.Context;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;
// import io.flutter.plugin.common.PluginRegistry.Registrar;

/** OrbaOneSdkFlutterPlugin */
public class OrbaOneSdkFlutterPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native
  /// Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine
  /// and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Activity activity;
  private Context context;

  public void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "orba_one_sdk_flutter");
    final OrbaOneSdkFlutterPlugin plugin = new OrbaOneSdkFlutterPlugin();
    activity = registrar.activity();
    channel.setMethodCallHandler(plugin);

  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "orba_one_sdk_flutter");
    channel.setMethodCallHandler(this);
    this.context = flutterPluginBinding.getApplicationContext();

  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("initialize")) {
      String apiKey = call.argument("apiKey");
      String appId = call.argument("appId");
      try {
        OrbaOne oneSdk = new OrbaOne.Builder().setApiKey(apiKey).setApplicantId(appId).create();
        oneSdk.startVerification(activity);
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

  @Override
  public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
    this.activity = activityPluginBinding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    // TODO: the Activity your plugin was attached to was destroyed to change
    // configuration.
    // This call will be followed by onReattachedToActivityForConfigChanges().
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
    onAttachedToActivity(activityPluginBinding);
  }

  @Override
  public void onDetachedFromActivity() {
    // TODO: your plugin is no longer associated with an Activity. Clean up
    // references.
  }

}
