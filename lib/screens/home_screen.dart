import 'package:flutter/material.dart';
import '../top_bar.dart';
import '../second_top_bar.dart';
import '../nav_bar.dart';
import '../components/card.dart';

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
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              FirstTopBar(
                  title: widget.appTitle,
                  color: textColor,
                  bgColor: backgroundColor),
              SliverToBoxAdapter(
                child: SecondTopBar(
                    titles: titles,
                    sizes: sizes,
                    color: textColor,
                    bgColor: backgroundColor),
              ),
            ];
          },
          body: Container(
            margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 4.0),
                        child: VideoCard(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: NavBar(color: textColor, bgColor: backgroundColor),
      ),
    );
  }
}
