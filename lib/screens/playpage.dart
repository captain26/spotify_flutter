import 'dart:ui';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/model/song_model.dart';
import 'package:spotify/model/song_player.dart';

class PlayPage extends StatefulWidget {
<<<<<<< HEAD
  final Song songInfo;

  PlayPage({this.songInfo});
=======
  final String songId;
  final String songName;
  final String artistName;
  PlayPage({this.songId, this.songName, this.artistName});
>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e
  @override
  _PlayPageState createState() => _PlayPageState();
}

<<<<<<< HEAD
class _PlayPageState extends State<PlayPage>{

  AudioPlayer audioPlayer = new AudioPlayer();
=======
class _PlayPageState extends State<PlayPage> {
  AudioPlayer _player;
  AudioCache cache;
>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e

  Duration position = new Duration();
  Duration duration = new Duration();



  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

  }

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<SongPlayer>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: ListView(
          children: [

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
                    "${widget.songInfo.Name}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.songInfo.Artist}",
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
                  color: Colors.black54,
                ),
                SizedBox(
                  width: 20,
                ),
<<<<<<< HEAD
                Consumer<checkBool>(
                  builder: (context,myCheck,child) {
                    return InkWell(
                      onTap: () async {
                        print(widget.songInfo.uid);
                        await getAudio();
                        myCheck.tryBool();
                      },
                      child: Icon(
                        myCheck.playing == false
                            ? Icons.play_circle_outline
                            : Icons.pause_circle_outline,
                        size: 70,
                        color: Colors.black54,
                      ),
                    );
                  }
=======
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
>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e
                ),

                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.arrow_right,
                  size: 50,
                  color: Colors.black54,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  void getAudio() async {
    String uid = widget.songInfo.uid;
    final player = Provider.of<SongPlayer>(context);
    if(uid == null){
      return null;
    }else {
      var url = "https://ancient-spire-46177.herokuapp.com/tracks/${uid}";
      // var url = "https://assets.mixkit.co/music/preview/mixkit-trip-hop-vibes-149.mp3";
      if (player.playing) {
        var res = await player.audioPlayer.pause();
        if (res == 1) {
          setState(() {
            player.playing = false;
          });
        }

      } else {
        var res = await player.audioPlayer.play(url, isLocal: true);
        if (res == 1) {
          setState(() {
            player.playing = true;
          });
        }

      }
     player.audioPlayer.durationHandler = (d) {
            setState(() {
             duration = d;
            });
           };
      player.audioPlayer.positionHandler = (p){
        setState(() {
          position = p;
        });
      };
    }



  }
  Widget slider(){
    return Slider.adaptive(
        min: 0.0,
        value:position.inSeconds.toDouble(),
        max: 60.0,
        onChanged: (value){
          setState(() {
              seekToSec(value.toInt());
          });
        }
    );
  }
  void seekToSec(int sec){
    final player = Provider.of<SongPlayer>(context);

=======
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
>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e
    Duration newPos = Duration(seconds: sec);
      player.audioPlayer.seek(newPos);
  }
<<<<<<< HEAD

  }


=======
}
>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e
