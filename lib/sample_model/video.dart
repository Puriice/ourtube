import 'user.dart';

class Video {
  final String id;
  final User author;
  final String title;
  final String thumbnailUrl;
  final String type;
  final String duration;
  final DateTime timestamp;
  final int viewCount;
  final String likes;
  final String dislikes;

  const Video({
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
}

final List<Video> sampleVideos = [
  Video(
    id: 'Z7PlUGbsXlQ',
    author: sampleUser.singleWhere((user) => user.username == 'BBC'),
    title: 'Penguin chicks rescued by unlikely hero | Spy in the Snow - BBC',
    thumbnailUrl:
        'https://i.ytimg.com/vi/Z7PlUGbsXlQ/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLB3BCT4s2LdalXLgfmyjWzPMStmgA',
    type: 'Animal',
    duration: '1:58',
    timestamp: DateTime(2018, 12, 26),
    viewCount: 28000000,
    likes: '631K',
    dislikes: '4',
  ),
  Video(
    author: sampleUser.singleWhere((user) => user.username == '(G)I-DLE (여자)아이들 (Official YouTube Channel)'),
    id: 'ATK7gAaZTOM',
    title: '(여자)아이들((G)I-DLE) - 나는 아픈 건 딱 질색이니까(Fate) LIVE CLIP',
    thumbnailUrl:
        'https://i.ytimg.com/vi/ATK7gAaZTOM/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBpcGINyJ4TX0JVbwg_JLpis-OqDg',
    type: 'Music',
    duration: '2:53',
    timestamp: DateTime(2024, 3, 13),
    viewCount: 27000000,
    likes: '225K',
    dislikes: '8',
  ),
  Video(
    id: 'kgrV3_g9rYY',
    author: sampleUser.singleWhere((user) => user.username == 'BBC'),
    title: 'World’s Grumpiest Cat I Frozen Planet II I BBC',
    thumbnailUrl:
        'https://i.ytimg.com/vi/kgrV3_g9rYY/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAFdIiZ2DYtyh2nO7DSqtbkWlpeLg',
    type: 'Animal',
    duration: '2:59',
    timestamp: DateTime(2022, 8, 24),
    viewCount: 4600000,
    likes: '97k',
    dislikes: '4',
  ),
  Video(
    id: 'jqYkSPIbaEA',
    author: sampleUser.singleWhere((user) => user.username == 'ABC News'),
    title:
        'ABC World News Tonight with David Muir Full Broadcast - April 11, 2024',
    thumbnailUrl:
        'https://i.ytimg.com/vi/jqYkSPIbaEA/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAJOCGUgO9OUMbaKuSV_gN5rFzfsg',
    type: 'News',
    duration: '19:51',
    timestamp: DateTime(2024, 4, 12),
    viewCount: 326000,
    likes: '4k',
    dislikes: '4',
  ),
];
