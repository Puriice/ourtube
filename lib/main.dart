import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String appTitle = 'OurTube';
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: MainHome(appTitle: appTitle),
    );
  }
}
