import 'package:flutter/foundation.dart';
import 'package:wetube/database/service/profile_service.dart';
import 'package:wetube/database/service/vdo_service.dart';
import 'package:wetube/model/user.dart';
import 'package:wetube/model/video.dart';

class VideoProvider with ChangeNotifier {
  List<Video> _videos = [];
  User _me = const User(
      username: defaultProfileName,
      profileImageUrl: '',
      subscribers: '0',
      isMe: true);
  bool _isLoading = true;

  List<Video> get videos => _videos;
  List<Video> get myVideos =>
      _videos.where((video) => video.author.isMe).toList();
  User get me => _me;
  bool get isLoading => _isLoading;

  Future<void> loadVideos() async {
    _isLoading = true;
    notifyListeners();
    _me = await fetchProfile();
    _videos = await fetchVideosFromDatabase();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfile(String username, String? imagePath) async {
    await saveProfile(username, imagePath);
    await loadVideos();
  }

  Future<void> removeVideo(Video video) async {
    await deleteVideo(video);
    await loadVideos();
  }

  Future<void> removeAllVideos() async {
    await deleteAllVideos();
    await loadVideos();
  }
}
