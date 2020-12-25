import 'package:flutter/material.dart';
import 'package:news_app/helper/category%20model.dart';
import 'package:news_app/helper/news%20model.dart';
import 'package:news_app/helper/news.dart';
import 'home.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  String countryCode;
  CategoryNews({this.category, this.countryCode});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles=List<ArticleModel>();
  bool _loading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async{
    CategoryNewsClass newsClass = new CategoryNewsClass(countryCode: widget.countryCode);
    await newsClass.getnews(widget.category);
    articles=newsClass.news;

    setState(() {
      _loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.black12,
        title: Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40),
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
      body: _loading ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Container(
          child: ListView.builder(
              itemCount: articles.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
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
