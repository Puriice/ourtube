import 'package:flutter/material.dart';

//pub.dev
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:intl/intl.dart';

//sample data
import 'package:wetube/sample_model/video.dart';

//format
import 'package:wetube/components/time_pass_calculation_format.dart';

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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: screenWidth,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        widget.video.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: screenWidth,
                  child: Row(
                    children: [
                      Text(
                          "${NumberFormat('#,###').format(widget.video.viewCount)} ${widget.video.viewCount > 1 ? 'views' : 'view'}"),
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
                        borderRadius: BorderRadius.circular(
                            50.0), // Add rounded corners here
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
