import 'package:flutter/foundation.dart';
import 'package:wetube/database/service/vdo_service.dart';
import 'package:wetube/model/video.dart';

class VideoProvider with ChangeNotifier {
  List<Video> _videos = [];
  bool _isLoading = true;

  List<Video> get videos => _videos;
  bool get isLoading => _isLoading;

  Future<void> loadVideos() async {
    _isLoading = true;
    notifyListeners();
    _videos = await fetchVideosFromDatabase();
    _isLoading = false;
    notifyListeners();
  }
}
