import 'package:wetube/sample_model/video.dart';

//ไม่ตรงเป๊ะ แค่คร่าวๆ

class CalculateTimesPass {
  final Video video;

  CalculateTimesPass({required this.video});

  String calculateTimePass() {
    DateTime startDate = video.timestamp;
    DateTime now = DateTime.now();

    Duration timePass = now.difference(startDate);
    String resultTimePass = '';

    int timePassValue;
    if (timePass.inDays >= 365) {
      timePassValue = timePass.inDays ~/ 365;
      resultTimePass = timePassValue.toString() +
          (timePassValue > 1 ? ' years ago' : ' year ago');
    } else if (timePass.inDays >= 30) {
      timePassValue = timePass.inDays ~/ 30;
      resultTimePass = timePassValue.toString() +
          (timePassValue > 1 ? ' months ago' : ' month ago');
    } else if (timePass.inHours >= 24) {
      resultTimePass = timePass.inDays.toString() +
          (timePass.inDays > 1 ? ' days ago' : ' day ago');
    } else if (timePass.inMinutes >= 60) {
      resultTimePass = timePass.inHours.toString() +
          (timePass.inHours > 1 ? ' hours ago' : ' hour ago');
    } else if (timePass.inSeconds >= 60) {
      resultTimePass = timePass.inMinutes.toString() +
          (timePass.inMinutes > 1 ? ' minutes ago' : ' minute ago');
    } else {
      resultTimePass = timePass.inSeconds.toString() +
          (timePass.inSeconds > 1 ? ' seconds ago' : ' second ago');
    }

    return resultTimePass;
  }
}