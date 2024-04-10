import 'package:flutter/material.dart';
import 'top_bar.dart';
import 'second_top_bar.dart';
import 'nav_bar.dart';
import 'components/card.dart';

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

class MainHome extends StatefulWidget {
  final String appTitle;

  const MainHome({Key? key, required this.appTitle}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  List<String> titles = ['', 'All', 'Music', 'News', 'Live', 'Gaming', 'Sport'];
  List<double> sizes = [40, 40, 80, 80, 80, 80, 80];
  Color textColor = Colors.white;
  var backgroundColor = Colors.blueGrey[900];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: FirstTopBar(
          title: widget.appTitle, color: textColor, bgColor: backgroundColor),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          children: [
            SecondTopBar(
                titles: titles,
                sizes: sizes,
                color: textColor,
                bgColor: backgroundColor),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.752,
                            child: ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin:
                                      EdgeInsets.only(top: 2.0, bottom: 2.0),
                                  child: VedioCard(),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(color: textColor, bgColor: backgroundColor),
    );
  }
}
