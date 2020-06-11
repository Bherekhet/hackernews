import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/news_screen.dart';
import './providers/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: ApiProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: NewsScreen(),
        ),
      ),
    );
  }
}
