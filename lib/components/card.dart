import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 8,
        child: Container(
          height: 300,
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(12.0), // Add rounded corners here
                    child: Image.asset(
                      'assets/video_picture_sample/one.jpeg',
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
                        padding: EdgeInsets.all(5.0),
                        color: Colors.black.withOpacity(0.7),
                        child: Text(
                          'Total Time: 00:00', // Replace with your total time
                          style: TextStyle(
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
                      child: Image.asset(
                        'assets/video_picture_sample/one.jpeg',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Title',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Channel Name',
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
                                  '1.2M views',
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
                                  '1 day ago',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[200],
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
