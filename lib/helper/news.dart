

import 'dart:convert';

import 'package:NewsMania/Models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=bcb1927ba43145c5b38651c997e61e54";
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    if (data["status"] == "ok") {
      data['articles'].forEach((element) {
        if (element["urlToImage"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element['author'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=bcb1927ba43145c5b38651c997e61e54";
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    if (data["status"] == "ok") {
      data['articles'].forEach((element) {
        if (element["urlToImage"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element['author'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
