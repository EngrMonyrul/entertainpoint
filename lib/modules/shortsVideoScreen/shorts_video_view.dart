import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShortsVideoScreenView extends StatefulWidget {
  final String webLink;
  final String type;
  const ShortsVideoScreenView({Key? key, required this.webLink, required this.type}) : super(key: key);

  @override
  State<ShortsVideoScreenView> createState() => _ShortsVideoScreenViewState();
}

class _ShortsVideoScreenViewState extends State<ShortsVideoScreenView> {
  bool showWebView = false;
  late WebViewController webViewController;

  setWebViewController() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.webLink));

    setState(() {
      showWebView = true;
    });
  }

  @override
  void initState() {
    setWebViewController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              Text(
                widget.type,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              if (showWebView)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: WebViewWidget(
                      controller: webViewController,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
