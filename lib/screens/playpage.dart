import 'dart:ui';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayPage extends StatefulWidget {
  final String songId;
  final String songName;
  final String artistName;
  PlayPage({this.songId,this.songName,this.artistName});
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {

  AudioPlayer _player;
  AudioCache cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  bool playing = true;

  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);
    //now let's handle the audioplayer time

    //this function will allow you to get the music duration
    _player.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
    };
    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _player.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.black,
        child: ListView(
          children: [
            Row(
              children: [Icon(Icons.add), Spacer(), Icon(Icons.send)],
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Hero(
                tag: "album",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "assets/p2.jpg",
                    fit: BoxFit.cover,
                    height: 400,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    "${widget.songName}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.artistName}",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Text("1:03"),
                Flexible(
                  fit: FlexFit.tight,
                  child: slider(),
                ),
                Text("4:12")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_left,
                  size: 50,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    // getAudio();
                  },
                  child: Icon(
                      playing == false
                                ? Icons.play_circle_outline
                                : Icons.pause_circle_outline,
                            size: 70,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.arrow_right,
                  size: 50,
                  color: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // void getAudio() async {
  //   var url = "https://ancient-spire-46177.herokuapp.com/tracks/${widget.songId}";
  //   // var url = "https://assets.mixkit.co/music/preview/mixkit-trip-hop-vibes-149.mp3";
  //   if (playing) {
  //     var res = await audioPlayer.pause();
  //     if (res == 1) {
  //       setState(() {
  //         playing = false;
  //       });
  //     }
  //   } else {
  //     var res = await audioPlayer.play(url, isLocal: true);
  //     if (res == 1) {
  //       setState(() {
  //         playing = true;
  //       });
  //     }
  //   }
  //   cache = AudioCache(fixedPlayer: audioPlayer);
  //   audioPlayer.durationHandler = (d)  {
  //     setState(() {
  //       duration = d;
  //     });
  //   };
  //   audioPlayer.positionHandler = (p){
  //     setState(() {
  //       position = p;
  //     });
  //   };
    // audioPlayer.onDurationChanged.listen((Duration dd) {
    //   setState(() {
    //     duration = dd;
    //   });
    // });
    // audioPlayer.onAudioPositionChanged.listen((Duration dd) {
    //   setState(() {
    //     position = dd;
    //   });
    // });
  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          activeColor: Colors.blue[800],
          inactiveColor: Colors.grey[350],
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

}





