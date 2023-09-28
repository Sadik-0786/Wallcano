import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PhotographerInfoPage extends StatelessWidget {
  const PhotographerInfoPage({super.key, required this.photographerInfoUrl});
  final String photographerInfoUrl;

  WebViewController getLinkInController(){
    var controller=WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(photographerInfoUrl));
    return controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: WebViewWidget(
          controller:getLinkInController() ,
        ),
      ) ,
    );
  }
}
