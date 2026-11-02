import 'package:flutter/material.dart';

//components
import 'package:wetube/components/top_bar.dart';
import 'package:wetube/components/second_top_bar.dart';
import 'package:wetube/components/nav_bar.dart';
import 'package:wetube/components/card.dart';

//page
import 'video_play_screen.dart';

import 'package:wetube/model/video.dart';

//provider
import 'package:provider/provider.dart';
import 'package:wetube/providers/current_type_index_provider.dart';
import 'package:wetube/providers/video_provider.dart';

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
                Expanded(child:
                    Consumer2<CurrentTypeIndexProvider, VideoProvider>(
                  builder: (context, currentIndexProvider, videoProvider,
                      child) {
                    if (videoProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    List<Video> videos = videoProvider.videos;
                    if (currentIndexProvider.current > 1) {
                      videos = videos
                          .where((video) =>
                              video.type == types[currentIndexProvider.current])
                          .toList();
                    }

                    if (videos.isEmpty) {
                      return const Center(
                        child: Text(
                          'No videos yet. Tap + to add videos.',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }

                    return ListView.builder(
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 4.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoPlayScreen(
                                            video: videos[index],
                                          )),
                                );
                              },
                              child: VideoCard(video: videos[index]),
                            ),
                          );
                        });
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
