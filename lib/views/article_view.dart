import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


class ArticleView extends StatefulWidget {
  String blogurl;
  ArticleView({this.blogurl});
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer= Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.black12,
        title: Padding(
          padding: const EdgeInsets.only(left: 40.0,right: 40),
          child: Row(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Widely', style: GoogleFonts.bitter(
                fontSize: 22,
              ),
              ),
              Text('News',
                style:GoogleFonts.bitter(
                  fontSize: 22,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.blogurl ,
          onWebViewCreated: ((WebViewController webviewcontroler){
            _completer.complete(webviewcontroler);
          }),
        ),
      ),
    );

  }
}

