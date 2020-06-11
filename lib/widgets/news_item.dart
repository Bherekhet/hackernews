import 'package:flutter/material.dart';

import '../constants.dart' as Constants;

class NewItem extends StatelessWidget {
  final int id;
  final int comment;
  final String title;
  final int score;
  final String by;
  final int time;

  NewItem(
      {@required this.id,
      @required this.comment,
      @required this.title,
      @required this.score,
      @required this.by,
      @required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        subtitle: Text('$score points by $by $time minutes ago'),
      ),
    );
  }
}
