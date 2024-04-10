import 'package:flutter/material.dart';
import 'top_bar.dart';
import 'second_top_bar.dart';
import 'nav_bar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'OurTube';
    List<String> titles = [
      '',
      'All',
      'Music',
      'News',
      'Live',
      'Gaming',
      'Sport'
    ];
    List<double> sizes = [40, 40, 80, 80, 80, 80, 80];
    const Color textColor = Colors.white;
    var backgroundColor = Colors.blueGrey[900];

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: FirstTopBar(title: appTitle, color: textColor, bgColor:backgroundColor),
        body: SecondTopBar(titles: titles, sizes: sizes, color: textColor, bgColor:backgroundColor),
        bottomNavigationBar: NavBar(color: textColor, bgColor:backgroundColor),
      ),
    );
  }
}
