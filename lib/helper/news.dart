import 'dart:convert';
import 'package:news_app/helper/news%20model.dart';
import 'package:http/http.dart' as http;

class News{
  String countryCode;
  News({this.countryCode});
  List<ArticleModel> news=[];

  Future<void> getnews() async {
    if(countryCode != null )
      {
         countryCode= countryCode;
      }
    else {
      countryCode="in";
    }
    String url = "http://newsapi.org/v2/top-headlines?country=$countryCode&apiKey=4cfc90eee6594b8593126a7cc80239e6";
    var response = await http.get(url);
    var jsondata = jsonDecode(response.body);
    if (jsondata["status"] == "ok") {
      jsondata["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articlemodel = ArticleModel(
            title: element["title"],
            description: element["description"],
            author: element["author"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          news.add(articlemodel);
        }
      });
    }
  }
}

class CategoryNewsClass{
  String countryCode;
  CategoryNewsClass({this.countryCode});
  List<ArticleModel> news=[];

  Future<void> getnews(String category ) async {

    if(countryCode==null)
    {
      countryCode="in";
    }
    else {
      countryCode = countryCode;
    }

    String url = "http://newsapi.org/v2/language=en&top-headlines?country=$countryCode&category=$category&apiKey=4cfc90eee6594b8593126a7cc80239e6";
    var response = await http.get(url);
    var jsondata = jsonDecode(response.body);
    if (jsondata["status"] == "ok") {
      jsondata["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articlemodel = ArticleModel(
            title: element["title"],
            description: element["description"],
            author: element["author"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          news.add(articlemodel);
        }
      });
    }
  }
}