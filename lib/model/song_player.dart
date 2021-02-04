import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SongPlayer {
  AudioPlayer audioPlayer = new AudioPlayer();
  bool playing = false;
}

class checkBool with ChangeNotifier {
  bool playing = false;

  void tryBool() {
    if (playing) {
      playing = false;
      notifyListeners();
    } else {
      playing = true;
      notifyListeners();
    }
  }
}
