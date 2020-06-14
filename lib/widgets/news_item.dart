import 'package:flutter/material.dart';

import '../constants.dart' as Constants;
import 'package:time_formatter/time_formatter.dart';
import '../screens/webview_screen.dart';

class NewItem extends StatelessWidget {
  final int id;
  final int comment;
  final String title;
  final int score;
  final String by;
  final int time;
  final String url;
  final String type;

  NewItem(
      {@required this.id,
      @required this.comment,
      @required this.title,
      @required this.type,
      @required this.score,
      @required this.by,
      @required this.time,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    print('$id, $comment, $title, $score, $by, $time, $url');
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HNWebView(title: title, url: url)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Constants.tNewsItemColor,
          border: Border(bottom: BorderSide(color: Constants.tAppBarColor)),
        ),
        child: ListTile(
          leading: comment == null && type == 'job'
              ? null
              : Stack(
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
                        comment != null ? '$comment' : '0',
                        style: Constants.tCommentTextStyle,
                      ),
                    ),
                  ],
                ),
          title: Text('$title'),
          subtitle: Text(
              '$score points by $by ${formatTime(time*1000)}'),
        ),
      ),
    );
  }
}
