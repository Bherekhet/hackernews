library globals;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const baseUrl = 'https://hacker-news.firebaseio.com/';

const Color tAppBarColor = Color(0xff654062);
const Color tAppBarButtonNavColor = Color(0xff8c5e88);
const Color tNewsItemColor = Color(0xffffffff);

const double tCommentIconSize = 40;

const TextStyle tCommentTextStyle = TextStyle(color: Colors.white);

const List<String> tPopupMenuNames = [
  'New Stories',
  'Top Stories',
  'Job Stories'
];
Map<String, String> tPopupMenu = {
  'new': 'New Stories',
  'top': 'Top Stories',
  'job': 'Job Stories'
};
const Map<String, IconData> tIcons = {
  'new': Icons.new_releases,
  'top': Icons.beenhere,
  'job': Icons.work,
};

const Map<String, String> endPoints = {
  'new': '/v0/newstories',
  'top': '/v0/topstories',
  'job': '/v0/jobstories',
};

const String tItemEndPoint = '/v0/item/';
