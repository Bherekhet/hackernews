import 'package:flutter/material.dart';

import '../constants.dart' as Constants;
import '../screens/webview_screen.dart';

class NewItem extends StatelessWidget {
  final int id;
  final int comment;
  final String title;
  final int score;
  final String by;
  final int time;
  final String url;

  NewItem(
      {@required this.id,
      @required this.comment,
      @required this.title,
      @required this.score,
      @required this.by,
      @required this.time,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('true');
        Navigator.push(context, MaterialPageRoute(builder: (context) => HNWebView(title: title, url: url)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Constants.tNewsItemColor,
          border: Border(bottom: BorderSide(color: Constants.tAppBarColor)),
        ),
        child: ListTile(
          leading: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Icon(
                Icons.mode_comment,
                color: Constants.tAppBarColor,
                size: Constants.tCommentIconSize,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  '$comment',
                  style: Constants.tCommentTextStyle,
                ),
              ),
            ],
          ),
          title: Text('$title'),
          subtitle: Text(
              '$score points by $by ${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(time * 1000))} minutes ago'),
        ),
      ),
    );
  }
}
