import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wetube/components/card.dart';
import 'package:wetube/model/video.dart';
import 'package:wetube/database/service/vdo_service.dart';
import 'package:wetube/screens/video_play_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Video> _result = [];
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white70,
                    ),
                  ),
                  // Move Expanded here
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(
                        color: Colors.white,
                      ), // Set text color to white
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                          color: Colors.white70,
                        ), // Set hint text color to white
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          color: Colors.white,
                          onPressed: () {
                            _controller.clear();
                          },
                        ),
                      ),
                      onSubmitted: (String value) async {
                        final result = await searchVideosFromDatabase(value);
                        setState(() {
                          _result = result;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _result.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayScreen(
                              video: _result[index],
                            ),
                          ),
                        );
                      },
                      child: VideoCard(video: _result[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
