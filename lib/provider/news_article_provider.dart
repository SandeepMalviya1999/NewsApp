import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/constant/api.dart';
import 'package:newsapp/helper/log.dart';
import 'package:newsapp/model/news_article_model.dart';
import 'package:newsapp/model/source_model.dart';

class NewsArticleProvider with ChangeNotifier {
  List<Articles> _listNewsArticle = [];
  List<Sources> _listSource = [];

  List<Articles> get listNewsArticle {
    return [..._listNewsArticle];
  }

  List<Sources> get listSource {
    return [..._listSource];
  }

  Future<void> fetchTopHeadlines(int page, String source) async {
    try {
      String url = '';
      if (source != '') {
        url =
            "https://newsapi.org/v2/top-headlines?&pageSize=8&page=$page&sources=$source&apiKey=${ApiRes.newsApi}";
      } else {
        url =
            "https://newsapi.org/v2/top-headlines?country=in&pageSize=8&page=$page&apiKey=${ApiRes.newsApi}";
      }

      await _fetchNewsArticle(url);
    } catch (error) {
      printLog(title: 'ERROR', content: error);
    }
  }

  Future<void> fetchCustomSearchNews(String searchString) async {
    try {
      final url =
          "https://newsapi.org/v2/everything?q=${searchString.toLowerCase()}&language=en&sortBy=publishedAt&apiKey=${ApiRes.newsApi}";
      await _fetchNewsArticle(url);
    } catch (error) {
      printLog(title: 'ERROR', content: error);
    }
  }

  Future _fetchNewsArticle(String url) async {
    final response = await http.get(Uri.parse(url));

    printLog(title: 'REQUEST', content: response.request);
    printLog(title: 'BODY', content: json.encode(''));
    printLog(title: 'STATUS', content: response.statusCode);
    printLog(title: 'RESPONSE', content: response.body);

    final jsonBody = json.decode(response.body);

    if (jsonBody["status"] == "error") {
      print("JSON Status Error Message :${jsonBody["code"]}");
    } else if (jsonBody["status"] == "ok") {
      NewsArticleModel newsArticleModel = NewsArticleModel.fromJson(json.decode(response.body));

      if (newsArticleModel.articles != null) {
        _listNewsArticle = newsArticleModel.articles!;
      }
    }
  }

  Future<void> fetchSource() async {
    try {
      String url = "https://newsapi.org/v2/top-headlines/sources?apiKey=${ApiRes.newsApi}";
      await _fetchNewsSources(url);
    } catch (error) {
      printLog(title: 'ERROR', content: error);
    }
  }

  Future _fetchNewsSources(String url) async {
    final response = await http.get(Uri.parse(url));

    printLog(title: 'REQUEST', content: response.request);
    printLog(title: 'BODY', content: json.encode(''));
    printLog(title: 'STATUS', content: response.statusCode);
    printLog(title: 'RESPONSE', content: response.body);

    final jsonBody = json.decode(response.body);

    if (jsonBody["status"] == "error") {
      print("JSON Status Error Message :${jsonBody["code"]}");
    } else if (jsonBody["status"] == "ok") {
      SourceModel sourceModel = SourceModel.fromJson(json.decode(response.body));

      if (sourceModel.sources != null) {
        _listSource = sourceModel.sources!;
      }
    }
  }
}
