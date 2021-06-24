import 'package:flutter/material.dart';
import 'package:news_app/helper/news%20model.dart';
import 'package:news_app/helper/news.dart';
import 'home.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CategoryNews extends StatefulWidget {
  final String category;
  String countryCode;
  CategoryNews({this.category, this.countryCode});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass =
        new CategoryNewsClass(countryCode: widget.countryCode);
    await newsClass.getnews(widget.category);
    articles = newsClass.news;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Articleblog(
                        imgurl: articles[index].urlToImage,
                        title: articles[index].title,
                        description: articles[index].description,
                        weburl: articles[index].url,
                      );
                    }),
              ),
            ),
    );
  }
}
