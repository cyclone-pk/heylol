import 'package:flutter/cupertino.dart';

class VideoPlayerProvider extends ChangeNotifier {
  bool _isVideoPlaying = true;

  set isVideoPlaying(bool status) {
    _isVideoPlaying = status;
    notifyListeners();
  }

  get isVideoPlaying => _isVideoPlaying;
}
