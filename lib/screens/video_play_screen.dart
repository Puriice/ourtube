import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:wetube/sample_model/video.dart';
import 'package:wetube/components/time_pass_calculation.dart';

class VideoPlayScreen extends StatefulWidget {
  final Video video;

  const VideoPlayScreen({Key? key, required this.video}) : super(key: key);

  @override
  VideoPlayScreenState createState() => VideoPlayScreenState();
}

class VideoPlayScreenState extends State<VideoPlayScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    CalculateTimesPass calculator = CalculateTimesPass(video: widget.video);
    String resultTimePassed = calculator.calculateTimePass();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.title),
      ),
      body: Column(
        children: [
          YoutubePlayer(
            width: screenWidth,
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            progressColors: const ProgressBarColors(
              playedColor: Colors.purple,
              handleColor: Colors.deepPurple,
            ),
          ),
          Container(
            height: 50,
            width: screenWidth,
            child: Row(
              children: [
                Text('${widget.video.viewCount} views  '),
                Text(resultTimePassed),
                const Text('more'),
              ],
            ),
          ),
          Container(
            height: 50,
            width: screenWidth,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(50.0), // Add rounded corners here
                  child: Image.network(
                    widget.video.author.profileImageUrl,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(widget.video.author.username),
                Text('  ${widget.video.author.subscribers}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
