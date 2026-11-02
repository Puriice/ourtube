import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//page
import 'screens/home_screen.dart';

import 'package:provider/provider.dart';
import 'providers/current_type_index_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/video_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load settings before the first frame so the app opens in the right theme.
  final preferences = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentTypeIndexProvider()),
        ChangeNotifierProvider(
            create: (context) => VideoProvider()..loadVideos()),
        ChangeNotifierProvider(create: (context) => SettingsProvider(preferences)),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    String appTitle = 'OurTube';
    final darkMode = context.watch<SettingsProvider>().darkMode;
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      home: MainHome(appTitle: appTitle),
    );
  }
}
