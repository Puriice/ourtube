import 'package:flutter/material.dart';
import 'package:wetube/database/database_connect.dart';
import 'package:wetube/model/video.dart';

class add_video_screen extends StatefulWidget {
  @override
  _YourPageState createState() => _YourPageState();
}

class _YourPageState extends State<add_video_screen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> insertData() async {
    final dbConnect = DatabaseHelper();
    final db = await dbConnect.db;

    for (var video in sampleVideos) {
      final existingData =
          await db.rawQuery('SELECT * FROM Video WHERE id = ?', [video.id]);
      if (existingData.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showAlert(context);
        });
      } else {
        await db.rawInsert(
          'INSERT INTO Video(id, author, title, thumbnailUrl, type, duration, timestamp, viewCount, likes, dislikes) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
          [
            video.id,
            video.author.username,
            video.title,
            video.thumbnailUrl,
            video.type,
            video.duration,
            video.timestamp.toIso8601String(),
            video.viewCount,
            video.likes,
            video.dislikes
          ],
        );
      }
    }
  }

  Future<void> deleteAllData() async {
    final dbConnect = DatabaseHelper();
    final db = await dbConnect.db;
    await db.rawDelete('DELETE FROM Video');
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: textColor,
          ),
        ),
        title: Text(
          'Add Video Screen',
          style: TextStyle(
            color: textColor, // Change this to your desired color
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Insert Data'),
              onPressed: insertData,
            ),
            SizedBox(height: 20), // Add some spacing between the buttons
            ElevatedButton(
              child: Text('Delete All Data'),
              onPressed: deleteAllData,
            )
          ],
        ),
      ),
    );
  }
}

void _showAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text('Data with the same id already exists.'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
