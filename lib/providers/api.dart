import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants.dart' as Constants;
import '../models/news.dart';

class ApiProvider with ChangeNotifier {
  String baseUrl = Constants.baseUrl;

  List<int> topStoriesId = [];
  Map<int, News> _cached = {};
  int currentPage = 0;

  Map<int, News> get cachedNews {
    _sortNewBasedOnTime();
    return {..._cached};
  }

  void _sortNewBasedOnTime() {
    _cached.values.toList().sort((a, b) => b.time.compareTo(a.time));
  }

  void fetchStoriesIds(String ePoint) async {
    print(ePoint);
    currentPage = 0;
    topStoriesId = [];
    _cached.clear();
    String endPoint = ePoint + '.json';
    try {
      final response = await http.get(baseUrl + endPoint);
      final responseData = jsonDecode(response.body);
      topStoriesId = responseData.cast<int>();
      print(responseData.length);
      fetchStoresForIds();
    } catch (error) {
      print('error from new stories $error');
      Future.value(false);
    }
  }

  void fetchStoresForIds() {
    //print('currentPage $currentPage and length ${topStoriesId.length}');
    if (currentPage < topStoriesId.length) {
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
