import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import '../models/sort_time.dart';
import '../providers/api.dart';
import '../constants.dart' as Constants;
import '../widgets/news_item.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String selectedPopupRoute = Constants.tPopupMenu[0];
  String endPointRoute = Constants.tNewStoriesEndPoint;
  ScrollController _scrollController = ScrollController();
  bool tabSelected = false;

  @override
  void initState() {
    super.initState();
    _performAPICallForIds(endPointRoute);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _performAPICallForEachNews();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _performAPICallForIds(String identifier) {
    Provider.of<ApiProvider>(context, listen: false)
        .fetchStoriesIds(identifier);
  }

  _performAPICallForEachNews() {
    Provider.of<ApiProvider>(context, listen: false).fetchStoresForIds();
  }

  _selectd(String selected) {
    if (selected != null) {
      setState(() {
        selectedPopupRoute = selected;
        switch (selectedPopupRoute) {
          case 'New Stories':
            _performAPICallForIds(Constants.tNewStoriesEndPoint);
            break;
          case 'Top Stories':
            _performAPICallForIds(Constants.tTopStoriesEndPoint);
            break;
          default:
            _performAPICallForIds(Constants.tJobStoriesEndPoint);
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('running newsscreen');
    final _news = Provider.of<ApiProvider>(context).cachedNews;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Constants.tAppBarColor,
          title: Container(
            child: Text('HNews - $selectedPopupRoute'),
          ),
          bottom: buildPreferredSize()),
      body: (_news.length == 0 || _news == null)
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
                    comment: _news.values.toList()[i].comment,
                    by: _news.values.toList()[i].by,
                    score: _news.values.toList()[i].score,
                    time: _news.values.toList()[i].time,
                    url: _news.values.toList()[i].url,
                  );
                }
              },
            ),
    );
  }

  PreferredSize buildPreferredSize() {
    return PreferredSize(
      child: Container(
        color: Constants.tAppBarButtonNavColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Constants.tPopMenu
              .map((i, tab) => FlatButton(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.new_releases, color: tabSelected ? Colors.white : null,),
                        Text(tab),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        tabSelected = !tabSelected;
                      });
                    },
                  )).toList()
        ),
      ),
      preferredSize: Size.fromHeight(50),
    );
  }
}
