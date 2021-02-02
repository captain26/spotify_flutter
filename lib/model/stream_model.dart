import 'dart:async';

import 'package:spotify/model/song_model.dart';

class StreamModel {
  final StreamController<Song> _controller = StreamController<Song>.broadcast();
  Stream<Song> get outString =>_controller.stream;
  Sink<Song> get inString => _controller.sink;

  void dispose() {
    _controller.close();
  }
}