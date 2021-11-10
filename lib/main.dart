import 'package:flutter/material.dart';
import 'package:newsapp/provider/news_article_provider.dart';
import 'package:newsapp/screen/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsArticleProvider(),
      child: const MaterialApp(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
