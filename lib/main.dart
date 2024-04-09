import 'package:flutter/material.dart';
import 'nav_bar.dart';
import 'custom_nav_bar.dart'; // Import ContentContainer from separate file

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
      'Game',
      'Cartoon'
    ];
    List<double> sizes = [40, 40, 80, 80, 80, 80, 80];

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: MyAppBar(
          title: appTitle,
        ),
        body: ContentContainer(
          titles: titles,
          sizes: sizes,
        ),
      ),
    );
  }
}
