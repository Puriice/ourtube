import 'package:flutter/material.dart';

//components
import '../top_bar.dart';
import '../second_top_bar.dart';
import '../nav_bar.dart';
import '../components/card.dart';

//page
import 'video_play_screen.dart';

// mock data import
import 'package:wetube/sample_model/video.dart';

//provider
import 'package:provider/provider.dart';
import 'package:wetube/providers/current_type_index_provider.dart';

class MainHome extends StatefulWidget {
  final String appTitle;

  const MainHome({Key? key, required this.appTitle}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  List<String> types = [
    '',
    'All',
    'Music',
    'News',
    'Animal',
    'Gaming',
    'Sport'
  ];
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
                    titles: types,
                    sizes: sizes,
                    color: textColor,
                    bgColor: backgroundColor),
              ),
            ];
          },
          body: Container(
            margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Column(
              children: <Widget>[
                Expanded(child: Consumer<CurrentTypeIndexProvider>(
                  builder: (context, currentIndexProvider, child) {
                    if (currentIndexProvider.current == 0 ||
                        currentIndexProvider.current == 1) {
                      return ListView.builder(
                          itemCount: sampleVideos.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 4.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoPlayScreen(
                                              video: sampleVideos[index],
                                            )),
                                  );
                                },
                                child: VideoCard(video: sampleVideos[index]),
                              ),
                            );
                          });
                    } else {
                      return ListView.builder(
                          itemCount: sampleVideos.length,
                          itemBuilder: (context, index) {
                            if (types[currentIndexProvider.current] ==
                                sampleVideos[index].type) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VideoPlayScreen(
                                                video: sampleVideos[index],
                                              )),
                                    );
                                  },
                                  child: VideoCard(video: sampleVideos[index]),
                                ),
                              );
                            }
                            return Container();
                          });
                    }
                  },
                )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: NavBar(color: textColor, bgColor: backgroundColor),
      ),
    );
  }
}
