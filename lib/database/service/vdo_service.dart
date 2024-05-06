// import 'package:flutter/material.dart';
// import 'package:wetube/database/database_connect.dart';
// import 'package:wetube/model/video_model.dart';
// import 'package:wetube/model/user.dart';


// Future<List<Video>> fetchVideosFromDatabase() async {
//   final dbConnect = DatabaseHelper();
//   final db = await dbConnect.db;
//   final List<Map<String, dynamic>> maps = await db.query('Video');

//   return List.generate(maps.length, (i) {
//     return Video(
//       id: maps[i]['id'],
//       authorId: sampleUser.singleWhere((user) => user.username == maps[i]['author']).username,,
//       title: maps[i]['title'],
//       thumbnailUrl: maps[i]['thumbnailUrl'],
//       type: maps[i]['type'],
//       duration: maps[i]['duration'],
//       timestamp: DateTime.parse(maps[i]['timestamp']),
//       viewCount: maps[i]['viewCount'],
//       likes: maps[i]['likes'],
//       dislikes: maps[i]['dislikes'],
//     );
//   });
// }

// Future<void> insertData() async {
//     final dbConnect = DatabaseHelper();
//     final db = await dbConnect.db;

//     for (var video in sampleVideos) {
//       final existingData =
//           await db.rawQuery('SELECT * FROM Video WHERE id = ?', [video.id]);
//       if (existingData.isNotEmpty) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           _showAlert(context);
//         });
//       } else {
//         await db.rawInsert(
//           'INSERT INTO Video(id, author, title, thumbnailUrl, type, duration, timestamp, viewCount, likes, dislikes) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
//           [
//             video.id,
//             video.author.username,
//             video.title,
//             video.thumbnailUrl,
//             video.type,
//             video.duration,
//             video.timestamp.toIso8601String(),
//             video.viewCount,
//             video.likes,
//             video.dislikes
//           ],
//         );
//       }
//     }
// }

// Future<void> deleteAllData() async {
//     final dbConnect = DatabaseHelper();
//     final db = await dbConnect.db;
//     await db.rawDelete('DELETE FROM Video');
// }

// void _showAlert(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Alert'),
//         content: Text('Data with the same id already exists.'),
//         actions: <Widget>[
//           TextButton(
//             child: Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }