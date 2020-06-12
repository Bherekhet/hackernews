import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants.dart' as Constants;
import '../models/news.dart';

class ApiProvider with ChangeNotifier {
  String baseUrl = Constants.baseUrl;

  List<int> topStoriesId = [];
  List<News> _news = [];
  Map<int, News> _cached = {};
  int currentPage = 20;

  List<News> get news {
    _sortNewBasedOnTime();
    return [..._news];
  }

  Map<int, News> get cachedNews {
    return {..._cached};
  }

  void _sortNewBasedOnTime() {
    _cached.values.toList().sort((a, b) => b.time.compareTo(a.time));
    // _news.sort((a, b) => b.time.compareTo(a.time));
  }

  Future<bool> fetchStoriesIds(String ePoint) async {
    currentPage = 20;
    topStoriesId = [];
    _news = [];
    String endPoint = ePoint + '.json';
    try {
      final response = await http.get(baseUrl + endPoint);
      final responseData = jsonDecode(response.body);
      topStoriesId = responseData.cast<int>();

      fetchStoresForIds();
    } catch (error) {
      print('error from new stories $error');
      Future.value(false);
    }
    return Future.value(true);
  }

  void fetchStoresForIds() {
    //print('currentPage $currentPage and length ${topStoriesId.length}');
    if (currentPage < topStoriesId.length-20) {
      for (int i = 0; i < 20; i++) {
        print('current page confused $currentPage');
        _fetchStores(topStoriesId[currentPage + i]);

        // if (!_cached.containsKey(topStoriesId[currentPage + i])) {
        // }
      }
      currentPage += 20;
    } else {
      print('ooops');
    }
  }

  void _fetchStores(int id) async {
    String endPoint = Constants.tItemEndPoint + '$id.json';
    //print('check for id $id');

    try {
      final response = await http.get(baseUrl + endPoint);
      if (response.statusCode == 200) {
        //_news.add(News.fromJson(jsonDecode(response.body)));
        _cached.putIfAbsent(id, () => News.fromJson(jsonDecode(response.body)));
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print('error from fetching item story $error');
    }

    notifyListeners();
  }
}
