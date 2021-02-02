import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/model/song_model.dart';
import 'package:spotify/model/song_player.dart';

class BottomPanel extends StatefulWidget {
  final Song songInfo;
  BottomPanel({this.songInfo});
  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {

  @override
  void initState() {
    // TODO: implement initState
    getAudio();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final player = Provider.of<SongPlayer>(context);

    return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.decelerate,
            // color: Color(colors[0]),
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Consumer<checkBool>(
                builder: (context, mycheck, child) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 20, left: 5),
                              child: Image.asset("assets/p1.jpg"),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      '${widget.songInfo.Name}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${widget.songInfo.Artist}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 11,
                                      // color: Color(colors[1]).withOpacity(.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {

                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: InkWell(
                                  onTap: () async{
                                    await getAudio();
                                    mycheck.tryBool();
                                  },
                                  child: Icon(
                                    mycheck.playing == false ? Icons.play_arrow : Icons.pause,
                                    color: Colors.black54,
                                    // color: Color(colors[1]).withOpacity(.7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
            ),
    );
  }

  // getBottomPanelLayout() {
  //   return
  // }

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
    }

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
    // Widget slider() {
    //   return Container(
    //     width: 300.0,
    //     child: Slider.adaptive(
    //         activeColor: Colors.blue[800],
    //         inactiveColor: Colors.grey[350],
    //         value: position.inSeconds.toDouble(),
    //         max: musicLength.inSeconds.toDouble(),
    //         onChanged: (value) {
    //           seekToSec(value.toInt());
    //         }),
    //   );
    // }
    // void seekToSec(int sec) {
    //   Duration newPos = Duration(seconds: sec);
    //   _player.seek(newPos);
    // }

  }
}
