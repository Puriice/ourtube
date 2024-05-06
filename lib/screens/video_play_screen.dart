import 'package:flutter/material.dart';

//pub.dev
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:intl/intl.dart';

//sample data
import 'package:wetube/model/video.dart';

//format
import 'package:wetube/components/time_pass_calculation_format.dart';
import 'package:wetube/components/number_format.dart';

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

    FormatNumberNonUnit numFormat =
        FormatNumberNonUnit(num: widget.video.likes);
    String resultLikeFormat = numFormat.getFormatNumber();

    Color textColor = Colors.white;
    var backgroundColor = Colors.blueGrey[900];

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
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Flexible(
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
                ),
                Container(
                  height: 20,
                  width: screenWidth,
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                            "${NumberFormat('#,###').format(widget.video.viewCount)} ${widget.video.viewCount > 1 ? 'views' : 'view'}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(resultTimePassed),
                      ),
                      const Text(
                        'more',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: screenWidth,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              50.0), // Add rounded corners here
                          child: Image.network(
                            widget.video.author.profileImageUrl,
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          widget.video.author.username.length > 15
                              ? "${widget.video.author.username.substring(0, 15)}..."
                              : widget.video.author.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(widget.video.author.subscribers),
                      const Spacer(),
                      Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 95,
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(35.0)),
                          child: const Text(
                            'Subscriber',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  width: screenWidth,
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ElevatedButton(
                          onPressed: () {}, // This is needed but won't be used
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                backgroundColor, // This is the background color
                            foregroundColor:
                                textColor, // This is the color of the text and icon
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Icon(Icons.thumb_up_alt_outlined,
                                          size: 20),
                                    ),
                                    Text(resultLikeFormat),
                                  ],
                                ),
                              ),
                              const VerticalDivider(),
                              InkWell(
                                onTap: () {},
                                child: const Icon(Icons.thumb_down_alt_outlined,
                                    size: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                backgroundColor, // This is the background color
                            foregroundColor:
                                textColor, // This is the color of the text and icon
                          ),
                          icon: const Icon(Icons.share, size: 20),
                          label: const Text('Share'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                backgroundColor, // This is the background color
                            foregroundColor:
                                textColor, // This is the color of the text and icon
                          ),
                          icon: const Icon(Icons.download, size: 20),
                          label: const Text('Download'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                backgroundColor, // This is the background color
                            foregroundColor:
                                textColor, // This is the color of the text and icon
                          ),
                          icon:
                              const Icon(Icons.bookmark_add_outlined, size: 20),
                          label: const Text('Save'),
                        ),
                      ),
                    ],
                  ),
                )
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
