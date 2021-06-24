import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:news_app/helper/category%20model.dart';
import 'package:news_app/helper/country%20list.dart';
import 'package:news_app/helper/country%20model.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news%20model.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/views/category_news.dart';
import 'package:news_app/views/countryList.dart';
import 'article_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  String countryName;
  bool countryistrue;
  String countryCode;
  String countryFlag;
  Home(
      {this.countryFlag,
      this.countryName,
      this.countryistrue = true,
      this.countryCode});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Categorymodel> categories = new List<Categorymodel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  List<CountryModel> countries = new List<CountryModel>();
  bool countryTab = false;

  bool _loading = true;
  String countryFlag = "image/country flag/india.png";

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
    return SafeArea(
      child: DefaultTabController(
        length: 6,
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.amber[200],
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '           Widely',
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
                  actions: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          countryTab = countryTab ? false : true;
                        });
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: !countryTab
                              ? Container(
                                  height: 33,
                                  width: 33,
                                  child: Image.asset(!widget.countryistrue
                                      ? widget.countryFlag
                                      : countryFlag))
                              : Icon(Icons.arrow_back_ios_new_sharp, size: 33)),
                    )
                  ],
                  bottom: TabBar(isScrollable: true, tabs: [
                    Tab(child: Text("Business")),
                    Tab(child: Text("Science")),
                    Tab(child: Text("Health")),
                    Tab(child: Text("Technology")),
                    Tab(child: Text("sports")),
                    Tab(child: Text("Entertainment")),
                  ])),
              body: _loading
                  ? Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      child: TabBarView(
                        physics: ClampingScrollPhysics(),
                        children: [
                          CategoryNews(
                            category: "business",
                            countryCode: widget.countryCode,
                          ),
                          CategoryNews(
                            category: "science",
                            countryCode: widget.countryCode,
                          ),
                          CategoryNews(
                            category: "health",
                            countryCode: widget.countryCode,
                          ),
                          CategoryNews(
                            category: "technology",
                            countryCode: widget.countryCode,
                          ),
                          CategoryNews(
                            category: "sports",
                            countryCode: widget.countryCode,
                          ),
                          CategoryNews(
                            category: "entertainment",
                            countryCode: widget.countryCode,
                          ),
                        ],
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 40, bottom: 20),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInQuint,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.black.withOpacity(0.7),
                ),
                transform: Matrix4.translationValues(
                    countryTab ? 0 : 400, countryTab ? 0 : -1000, 0),
                child: GridView.builder(
                    itemCount: countries.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return CountryTile(
                        countryCode: countries[index].countryCode,
                        countryFlag: countries[index].countryFlag,
                        countryName: countries[index].countryName,
                      );
                    }),
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
                  placeholder: kTransparentImage, image: imgurl),
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
