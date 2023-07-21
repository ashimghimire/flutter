import 'package:flutter/material.dart';
import 'package:news/src/screens/NewsList.dart';
import 'package:news/src/provider/StoriesProvider.dart';
import 'package:news/src/screens/NewsList.dart';
import 'src/app.dart';

void main() {
  runApp(App());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(context) {
      return StoriesProvider(
          key:GlobalKey(debugLabel: "Lolipop123"),
          child:const MaterialApp(
          home: NewsList(),
            title: 'Hacker News',
      ));
  }
}
