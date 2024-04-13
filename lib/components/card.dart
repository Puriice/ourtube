import 'package:flutter/material.dart';

import 'package:wetube/sample_model/video.dart';

//format
import 'package:wetube/components/time_pass_calculation_format.dart';
import 'package:wetube/components/number_format.dart';

class VideoCard extends StatelessWidget {
  final Video video;

  const VideoCard({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CalculateTimesPass calculator = CalculateTimesPass(video: video);
    String resultTimePassed = calculator.calculateTimePass();

    FormatNumberUnitView viewFormat = FormatNumberUnitView(num: video.viewCount);
    String resultViewFormat = viewFormat.getFormatNumber();

    return Card(
        color: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 8,
        child: Container(
          height: 342,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(12.0), // Add rounded corners here
                    child: Image.network(
                      video.thumbnailUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    right: 10.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        color: Colors.black.withOpacity(0.7),
                        child: Text(
                          'Total Time: ${video.duration}', // Replace with your total time
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          50.0), // Add rounded corners here
                      child: Image.network(
                        video.author.profileImageUrl,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                video.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Wrap(
                                children: <Widget>[
                                  Text(
                                    video.author.username.length > 16
                                        ? video.author.username.substring(0, 16)
                                        : video.author.username,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                  Text(
                                    ' . ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                  Text(
                                    resultViewFormat,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                  Text(
                                    ' . ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                  Text(
                                    resultTimePassed,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
