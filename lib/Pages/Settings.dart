import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: "https://nahvino.com/blog/",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}