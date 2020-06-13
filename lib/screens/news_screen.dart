import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import '../providers/api.dart';
import '../constants.dart' as Constants;
import '../widgets/news_item_builder.dart';
import '../widgets/top_navigation.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Constants.tAppBarColor,
          title: Container(child: const Text('Hacker-News')),
          bottom: TopNavigation()),
      body: NewsItemBuilder(),
    );
  }
}
