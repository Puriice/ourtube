class Video {
  final String id;
  final String author;
  final String title;
  final String thumbnailUrl;
  final String type;
  final String duration;
  final DateTime timestamp;
  final int viewCount;
  final int likes;
  final String dislikes;

  Video({
    required this.id,
    required this.author,
    required this.title,
    required this.thumbnailUrl,
    required this.type,
    required this.duration,
    required this.timestamp,
    required this.viewCount,
    required this.likes,
    required this.dislikes,
  });

  // Convert a Video object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'authorId': author,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'type': type,
      'duration': duration,
      'timestamp': timestamp.toIso8601String(),
      'viewCount': viewCount,
      'likes': likes,
      'dislikes': dislikes,
    };
  }

  // Convert a Map object into a Video object
  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      id: map['id'],
      author: map['author'],
      title: map['title'],
      thumbnailUrl: map['thumbnailUrl'],
      type: map['type'],
      duration: map['duration'],
      timestamp: DateTime.parse(map['timestamp']),
      viewCount: map['viewCount'],
      likes: map['likes'],
      dislikes: map['dislikes'],
    );
  }
}