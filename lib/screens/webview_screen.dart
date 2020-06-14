import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:webview_flutter/webview_flutter.dart';

class HNWebView extends StatefulWidget {
  final String title;
  final String url;

  HNWebView({this.title, this.url});
  @override
  _HNWebViewState createState() => _HNWebViewState();
}

class _HNWebViewState extends State<HNWebView> {
  String newsTitle;
  bool isLoading = true;

  @override
  void initState() {
    newsTitle = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsTitle),
      ),
      body: Stack(children: <Widget>[
        WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (_) {
            setState(() {
              isLoading = false;
            });
          },
        ),
        isLoading ? Center(child: CupertinoActivityIndicator()) : Container(),
      ]),
    );
  }
}
