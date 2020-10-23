import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider_impl/models/articles.dart';
import 'package:http/http.dart' as http;

class NewsProvider extends ChangeNotifier {
  NewsProvider() {
    getData().then((value) => null);
  }
  final String apiKey = 'e742ca8e371542759d4f0ad78decbddb';
  List<Articles> _articles = [];
  // List<Articles> get articles {
  //   return [..._articles];
  // }
  UnmodifiableListView<Articles> get articles =>
      UnmodifiableListView(_articles);
  bool isLoading = false;

  Future<void> getData() async {
    isLoading = true;
    notifyListeners();
    List<Articles> extractedData = [];
    final url =
        'https://newsapi.org/v2/top-headlines?country=eg&apiKey=e742ca8e371542759d4f0ad78decbddb';

    try {
      final respons = await http.get(url);

      var data = json.decode(respons.body)['articles'];

      data.forEach((element) {
        _articles.add(Articles.fromJson(element));
      });
      // _articles = extractedData;
      print(articles.length);
      isLoading = false;
      // notifyListeners();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
