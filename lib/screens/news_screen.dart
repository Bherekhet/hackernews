import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    _performAPICall(endPointRoute);
    super.initState();
  }

  _performAPICall(String identifier) {
    Provider.of<ApiProvider>(context, listen: false)
        .fetchStoriesIds(identifier);
  }

  @override
  Widget build(BuildContext context) {
    final _news = Provider.of<ApiProvider>(context).news;
    print('news ${_news.length}');
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text('HNews'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () async {
              String selected = await showMenu(
                context: context,
                initialValue: selectedPopupRoute,
                items: Constants.tPopupMenu.map((popuproute) {
                  return new PopupMenuItem(
                    child: Text(popuproute),
                    value: popuproute,
                  );
                }).toList(),
                position: const RelativeRect.fromLTRB(60, 0, 0, 600),
              );

              if (selected != null) {
                setState(() {
                  selectedPopupRoute = selected;
                  switch (selectedPopupRoute) {
                    case 'New Stories':
                      _performAPICall(Constants.tNewStoriesEndPoint);
                      break;
                    case 'Top Stories':
                      _performAPICall(Constants.tTopStoriesEndPoint);
                      break;
                    default:
                      _performAPICall(Constants.tJobStoriesEndPoint);
                      break;
                  }
                });
              }
            },
          ),
        ],
        backgroundColor: Constants.tAppBarColor,
      ),
      body: _news.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _news.length,
              itemBuilder: (_, i) {
                return NewItem(
                  id: _news[i].id,
                  title: _news[i].title,
                  comment: _news[i].comment,
                  by: _news[i].by,
                  score: _news[i].score,
                  time: _news[i].time,
                );
              },
            ),
    );
  }
}
