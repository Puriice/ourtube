import 'package:flutter/material.dart';

//page
import 'screens/home_screen.dart';

import 'package:provider/provider.dart';
import 'providers/current_type_index_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CurrentTypeIndexProvider(),
      child: const MainApp(),
    ),
  );
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
