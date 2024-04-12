import 'package:flutter/foundation.dart';

class CurrentTypeIndexProvider with ChangeNotifier {
  int _current = 0;

  int get current => _current;

  set current(int value) {
    _current = value;
    notifyListeners();
  }
}
