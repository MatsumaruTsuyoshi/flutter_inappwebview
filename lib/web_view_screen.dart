import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();
  InAppWebViewController? webViewController;

  bool _isLoading = false;
  String _title = '';

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      // WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        if (_isLoading) const LinearProgressIndicator(),
        Expanded(
          child: _buildWebView(),
        ),
      ],
    );
  }

  Widget _buildWebView() {
    return InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse("https://blissful-murdock-135669.netlify.app")),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            mediaPlaybackRequiresUserGesture: false,
          ),
        ),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        androidOnPermissionRequest: (InAppWebViewController controller,
            String origin, List<String> resources) async {
          return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT);
        });
  }
}
// WebView(
// gestureNavigationEnabled: true,
// initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
// allowsInlineMediaPlayback: true,
// initialUrl: 'https://blissful-murdock-135669.netlify.app',
// // jsを有効化
// javascriptMode: JavascriptMode.unrestricted,
// // controllerを登録
// onWebViewCreated: _controller.complete,
// // ページの読み込み開始
// onPageStarted: (String url) {
// // ローディング開始
// setState(() {
// _isLoading = true;
// });
// },
// // ページ読み込み終了
// onPageFinished: (String url) async {
// // ローディング終了
// setState(() {
// _isLoading = false;
// });
// // ページタイトル取得
// final controller = await _controller.future;
// final title = await controller.getTitle();
// setState(() {
// if (title != null) {
// _title = title;
// }
// });
// },
// );
