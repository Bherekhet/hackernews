import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants.dart' as Constants;
import '../models/news.dart';

class ApiProvider with ChangeNotifier {
  String baseUrl = Constants.baseUrl;
  List<int> topStoriesId = [];
  List<News> _news = [];

  List<News> get news {
    return [..._news];
  }

  void fetchStoriesIds(String ePoint) async {
    _news = [];
    String endPoint = ePoint+'.json';
    try {
      final response = await http.get(baseUrl+endPoint);
      // final responseData = response.body;
      final responseData = jsonDecode(response.body);
      //print('true');
      topStoriesId = responseData.cast<int>();

      _fetchStoresForIds(topStoriesId);
    } catch(error) {
      print('error from new stories $error');
    }
  }

  void _fetchStoresForIds(List<int> idList) {
    idList.forEach((id) {
      _fetchStores(id);
    });
  }

  void _fetchStores(int id) async{
    String endPoint = Constants.tItemEndPoint + '$id.json';

    try {
      final response = await http.get(baseUrl+endPoint);
      if(response.statusCode == 200) {
        //print('test');
        print(response.body);
        _news.add(News.fromJson(jsonDecode(response.body)));
      } else {
        print(response.statusCode);
      }

    } catch(error) {
      print('error from fetching item story $error');
    }

    notifyListeners();
  }

}