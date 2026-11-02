import 'dart:io' as io;

import 'package:wetube/database/database_connect.dart';
import 'package:wetube/database/service/profile_service.dart';
import 'package:wetube/model/user.dart';
import 'package:wetube/model/video.dart';

// The Video table only stores the author's username (or myChannelId for the
// user's own uploads), so look up the full User here.
User _findAuthor(String username, User me) {
  if (username == myChannelId) return me;
  return sampleUser.firstWhere(
    (user) => user.username == username,
    orElse: () => User(username: username, profileImageUrl: '', subscribers: '0'),
  );
}

Video _videoFromMap(Map<String, dynamic> map, User me) {
  return Video(
    id: map['id'],
    author: _findAuthor(map['author'], me),
    title: map['title'],
    thumbnailUrl: map['thumbnailUrl'],
    type: map['type'],
    duration: map['duration'],
    timestamp: DateTime.parse(map['timestamp']),
    viewCount: map['viewCount'],
    likes: map['likes'],
    dislikes: map['dislikes'].toString(),
    source: map['source'] ?? 'youtube',
    localPath: map['localPath'],
  );
}

// Returns false if a video with the same id already exists.
Future<bool> insertVideo(Video video) async {
  final db = await DatabaseHelper().db;
  final existing =
      await db.query('Video', where: 'id = ?', whereArgs: [video.id]);
  if (existing.isNotEmpty) return false;

  await db.insert('Video', {
    'id': video.id,
    'author': video.author.isMe ? myChannelId : video.author.username,
    'title': video.title,
    'thumbnailUrl': video.thumbnailUrl,
    'type': video.type,
    'duration': video.duration,
    'timestamp': video.timestamp.toIso8601String(),
    'viewCount': video.viewCount,
    'likes': video.likes,
    'dislikes': video.dislikes,
    'source': video.source,
    'localPath': video.localPath,
  });
  return true;
}

// Deletes the row and, for videos uploaded from the phone, the copied file.
Future<void> deleteVideo(Video video) async {
  final db = await DatabaseHelper().db;
  await db.delete('Video', where: 'id = ?', whereArgs: [video.id]);
  if (video.localPath != null) {
    final file = io.File(video.localPath!);
    if (await file.exists()) await file.delete();
  }
}

// Deletes every video, including the copied files of phone uploads.
Future<void> deleteAllVideos() async {
  final db = await DatabaseHelper().db;
  final localVideos = await db.query('Video',
      columns: ['localPath'], where: 'localPath IS NOT NULL');
  for (final row in localVideos) {
    final file = io.File(row['localPath'] as String);
    if (await file.exists()) await file.delete();
  }
  await db.delete('Video');
}

Future<List<Video>> fetchVideosFromDatabase() async {
  final db = await DatabaseHelper().db;
  final me = await fetchProfile();
  final maps = await db.query('Video', orderBy: 'timestamp DESC');
  return maps.map((map) => _videoFromMap(map, me)).toList();
}

Future<List<Video>> searchVideosFromDatabase(String keyword) async {
  final db = await DatabaseHelper().db;
  final me = await fetchProfile();
  final maps = await db.query(
    'Video',
    where: 'title LIKE ?',
    whereArgs: ['%$keyword%'],
    orderBy: 'timestamp DESC',
  );
  return maps.map((map) => _videoFromMap(map, me)).toList();
}
