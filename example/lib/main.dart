import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:orba_one_sdk_flutter/orba_one_sdk_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isInitialized = false;
  final _orbaOneSdkFlutterPlugin = OrbaOneSdkFlutter();

  // Platform messages are asynchronous, so we initialize in an async method.
  void initOrbaOne() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      isInitialized = await _orbaOneSdkFlutterPlugin.initialize(apiKey: "0668412568a448b0be607cbd6aa3de82", appId: "08dab006-349f-4217-8882-24cf6a1bd50b");
    } on PlatformException {
      isInitialized = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: ElevatedButton(
                onPressed: () {
                  initOrbaOne();
                  debugPrint("init button pressed");
                },
                child: Text("Initialize")),
          )),
    );
  }
}
