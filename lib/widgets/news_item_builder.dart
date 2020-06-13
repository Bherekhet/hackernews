import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import '../providers/api.dart';
import '../widgets/news_item.dart';
import '../constants.dart' as Constants;

class NewsItemBuilder extends StatefulWidget {
  @override
  _NewsItemBuilderState createState() => _NewsItemBuilderState();
}

class _NewsItemBuilderState extends State<NewsItemBuilder> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false)
        .fetchStoriesIds(Constants.endPoints['new']);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provider.of<ApiProvider>(context, listen: false).fetchStoresForIds();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _news = Provider.of<ApiProvider>(context).cachedNews;
    return (_news.isEmpty)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemExtent: 80,
            controller: _scrollController,
            itemCount: _news.length + 1,
            itemBuilder: (_, i) {
              if (i == _news.length) {
                return CupertinoActivityIndicator();
              } else {
                return NewItem(
                  id: _news.values.toList()[i].id,
                  title: _news.values.toList()[i].title,
                  type: _news.values.toList()[i].type,
                  comment: _news.values.toList()[i].comment,
                  by: _news.values.toList()[i].by,
                  score: _news.values.toList()[i].score,
                  time: _news.values.toList()[i].time,
                  url: _news.values.toList()[i].url,
                );
              }
            },
          );
  }
}
