import 'package:entertainpoint/utils/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TvShowsScreenView extends StatefulWidget {
  const TvShowsScreenView({super.key});

  @override
  State<TvShowsScreenView> createState() => _TvShowsScreenViewState();
}

class _TvShowsScreenViewState extends State<TvShowsScreenView> {
  bool showWebView = false;
  late WebViewController webViewController;
  String webLink = '';

  setWebLink(link) {
    setState(() {
      webLink = link;
    });
  }

  setWebViewController() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(tvShows[0]['link']));

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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          webViewController.reload();
        },
        child: const Icon(
          CupertinoIcons.refresh_circled,
          size: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: showWebView
                      ? WebViewWidget(
                          controller: webViewController,
                        )
                      : const CircularProgressIndicator(),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tvShows.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setWebLink(tvShows[index]['link']);
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        child: Image.network(
                          tvShows[index]['image'],
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
