import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:news_app/helper/category%20model.dart';
import 'package:news_app/helper/country%20list.dart';
import 'package:news_app/helper/country%20model.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news%20model.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/views/category_news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'article_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  String countryName;
  bool countryistrue;
  String countryCode;
  Home({this.countryName, this.countryistrue = true, this.countryCode});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Categorymodel> categories = new List<Categorymodel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  List<CountryModel> countries = new List<CountryModel>();

  bool _loading = true;
  String countryname = "India";

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    countries = getCountry(widget.countryistrue);
    getNews();
  }

  getNews() async {
    News newsClass = new News(countryCode: widget.countryCode);
    await newsClass.getnews();
    articles = newsClass.news;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Widely',
              style: GoogleFonts.bitter(
                fontSize: 22,
              ),
            ),
            Text(
              'News',
              style: GoogleFonts.bitter(
                fontSize: 22,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: _loading
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ExpansionTile(
                      title: Row(
                        children: [
                          Text(
                            "Top News of ",
                            style: GoogleFonts.roboto(
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.countryistrue
                                ? countryname
                                : widget.countryName,
                            style: GoogleFonts.roboto(
                              fontSize: 25,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        ListView.builder(
                            itemCount: countries.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CountryListTile(
                                countryFlag: countries[index].countryFlag,
                                countryName: countries[index].countryName,
                                countryCode: countries[index].countryCode,
                              );
                            })
                      ],
                    ),
                    ListView.builder(
                        itemCount: articles.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Articleblog(
                            imgurl: articles[index].urlToImage,
                            title: articles[index].title,
                            description: articles[index].description,
                            weburl: articles[index].url,
                          );
                        }),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                color: Colors.black12,
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Categorycard(
                        cardName: categories[index].categorycardname,
                        cardUrl: categories[index].categorycardurl,
                        countryCode: widget.countryCode,
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Categorycard extends StatelessWidget {
  final String cardName;
  final String cardUrl;
  final String countryCode;
  Categorycard({this.cardName, this.cardUrl, this.countryCode});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                  category: cardName.toLowerCase(),
                  countryCode: countryCode,
                )));
      },
      child: Container(
        margin: EdgeInsets.only(left: 13),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                cardUrl,
                width: 130,
                height: 65,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 130,
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black.withOpacity(0.4),
              ),
              child: Text(
                cardName,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Articleblog extends StatelessWidget {
  final String imgurl;
  final String title;
  final String description;
  final String weburl;
  Articleblog({this.description, this.imgurl, this.title, this.weburl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                  blogurl: weburl,
                )));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: imgurl),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              title,
              style: GoogleFonts.slabo13px(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              description,
              style: GoogleFonts.rajdhani(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
            Divider(
              color: Colors.black12,
            ),
          ],
        ),
      ),
    );
  }
}

class CountryListTile extends StatelessWidget {
  final String countryFlag;
  final String countryName;
  final String countryCode;
  CountryListTile({this.countryFlag, this.countryName, this.countryCode});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                  countryName: countryName.trim(),
                  countryistrue: false,
                  countryCode: countryCode,
                )));
      },
      child: Container(
        //  margin: EdgeInsets.only(right: 20,top: 5,bottom: 5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                minRadius: 8,
                backgroundImage: AssetImage(countryFlag),
              ),
              Text(countryName),
            ],
          ),
        ),
      ),
    );
  }
}
