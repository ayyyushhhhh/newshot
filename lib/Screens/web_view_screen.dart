import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/models/Providers/bookmark_provider.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final NewsModel newsModel;
  const WebViewScreen({super.key, required this.newsModel});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.newsModel.url.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.newsModel.title.toString(),
            ),
          ),
          body: Stack(children: [
            WebViewWidget(
              controller: _webViewController,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50.h,
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await Share.share(
                              "Check out the article \n ${widget.newsModel.url}");
                        },
                        icon: const Icon(Icons.share),
                      ),
                      Consumer<BookMarkProvider>(
                        builder:
                            (BuildContext context, bookmarks, Widget? child) {
                          if (bookmarks.bookMarks.contains(widget.newsModel)) {
                            return IconButton(
                                onPressed: () {
                                  bookmarks.removeBookMark(widget.newsModel);
                                },
                                icon: const Icon(
                                  Icons.bookmark,
                                  color: Colors.blueAccent,
                                ));
                          } else {
                            return IconButton(
                                onPressed: () {
                                  bookmarks.addBookMark(widget.newsModel);
                                },
                                icon: const Icon(Icons.bookmark));
                          }
                        },
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.whatsapp),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.telegram),
                      )
                    ],
                  ),
                ))
          ])),
    );
  }
}
