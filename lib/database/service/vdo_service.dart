import 'package:wetube/database/database_connect.dart';
import 'package:wetube/model/user.dart';
import 'package:wetube/model/video.dart';

// The Video table only stores the author's username, so look up the full
// User (profile image, subscribers) from sampleUser.
User _findAuthor(String username) {
  return sampleUser.firstWhere(
    (user) => user.username == username,
    orElse: () => User(username: username, profileImageUrl: '', subscribers: '0'),
  );
}

Video _videoFromMap(Map<String, dynamic> map) {
  return Video(
    id: map['id'],
    author: _findAuthor(map['author']),
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
    'author': video.author.username,
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

Future<List<Video>> fetchVideosFromDatabase() async {
  final db = await DatabaseHelper().db;
  final maps = await db.query('Video', orderBy: 'timestamp DESC');
  return maps.map(_videoFromMap).toList();
}

Future<List<Video>> searchVideosFromDatabase(String keyword) async {
  final db = await DatabaseHelper().db;
  final maps = await db.query(
    'Video',
    where: 'title LIKE ?',
    whereArgs: ['%$keyword%'],
    orderBy: 'timestamp DESC',
  );
  return maps.map(_videoFromMap).toList();
}
