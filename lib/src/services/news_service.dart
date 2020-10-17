import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _urlNews = 'https://newsapi.org/v2';
final _apiKey = 'c933b33c9e054fd6adb22eeda8e8f474';

class NewsServices with ChangeNotifier {
  List<Article> headlines = [];

  Map<String, List<Article>> categoryArticles = {};

  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  NewsServices() {
    this.getTopHeadlines();

    categories.forEach((e) {
      categoryArticles[e.name] = new List();
    });

    this.getArticlesByCategory(this._selectedCategory);
  }

  get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  get getArticlesByCategorySelected => categoryArticles[_selectedCategory];

  getTopHeadlines() async {
    final url = '$_urlNews/top-headlines?country=us&apiKey=$_apiKey';
    final resp = await http.get(url);
    final newsReponse = newsReponseFromJson(resp.body);
    this.headlines.addAll(newsReponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category].length > 0) {
      return this.categoryArticles[category];
    }

    final url =
        '$_urlNews/top-headlines?country=us&category=$category&apiKey=$_apiKey';
    final resp = await http.get(url);
    final newsReponse = newsReponseFromJson(resp.body);
    this.categoryArticles[category].addAll(newsReponse.articles);
    notifyListeners();
  }
}
