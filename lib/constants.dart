library globals;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const baseUrl = 'https://hacker-news.firebaseio.com/';

const Color tAppBarColor = Color(0xff654062);
const Color tNewsItemColor = Color(0xfff2f3e8);

const double tCommentIconSize = 40;

const TextStyle tCommentTextStyle = TextStyle(color: Colors.white);

const List<String> tPopupMenu = ['New Stories', 'Top Stories', 'Job Stories'];

const String tNewStoriesEndPoint = '/v0/newstories';
const String tTopStoriesEndPoint = '/v0/topstories';
const String tJobStoriesEndPoint = '/v0/jobstories';
const String tItemEndPoint = '/v0/item/';



