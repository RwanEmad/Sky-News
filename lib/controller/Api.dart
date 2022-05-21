
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sky_news/model/ArticlesModel.dart';

class Api{
 static String APIKEY="d71b2155ead4473797610ba623a81fd6";
  static Future<List<ArticlesModel>> fetchArtiles()async{
    List<ArticlesModel> ListModel=[];
    var url=Uri.parse("https://newsapi.org/v2/top-headlines?country=eg&apiKey=$APIKEY");
    var respons= await http.get(url);
    var responsbody=jsonDecode(respons.body)["articles"];


    for( var i in responsbody)
      {
            ListModel.add(ArticlesModel(
            title:i["title"],
            description:i["description"],
            url:i["url"],
            urlToImage: i["urlToImage"],
            publishedAt: i["publishedAt"],
            auther:i["auther"]));

      }

    return ListModel;
  }
  static Future<List<ArticlesModel>> fetchCategoryArtiles(String category)async{
    List<ArticlesModel> ListModel=[];
    var url=Uri.parse("https://newsapi.org/v2/top-headlines?country=eg&category=$category&apiKey=$APIKEY");
    var respons= await http.get(url);
    var responsbody=jsonDecode(respons.body)["articles"];


    for( var i in responsbody)
      {
            ListModel.add(ArticlesModel(
            title:i["title"],
            description:i["description"],
            url:i["url"],
            urlToImage: i["urlToImage"],
            publishedAt: i["publishedAt"],
            auther:i["auther"]));

      }

    return ListModel;
  }


}