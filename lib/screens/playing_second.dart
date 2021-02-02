import 'package:flutter/material.dart';

class PlayingSecond extends StatefulWidget {
  @override
  _PlayingSecondState createState() => _PlayingSecondState();
}

class _PlayingSecondState extends State<PlayingSecond> {


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: MediaQuery.of(context).padding,
      duration: Duration(milliseconds: 500),
      curve: Curves.decelerate,
      // color: Color(colors[0]),
      child: getPlayinglayout(),
    );
  }

  getPlayinglayout() {
    final _screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
            constraints: BoxConstraints(
                maxHeight: _screenHeight / 2, minHeight: _screenHeight / 2),
            padding: const EdgeInsets.all(10),
            child: Dismissible(
              key: UniqueKey(),
              background:Image.asset("assets/p1.jpg"),

              secondaryBackground: Image.asset("assets/p1.jpg"),

              movementDuration: Duration(milliseconds: 500),
              resizeDuration: Duration(milliseconds: 2),
              dismissThresholds: const {
                DismissDirection.endToStart: 0.3,
                DismissDirection.startToEnd: 0.3
              },
              direction: DismissDirection.horizontal,
              onDismissed: (DismissDirection direction) {

              },
              child: Image.asset("assets/p1.jpg"),
            )),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                    // color: Color(colors[0]),
                    blurRadius: 50,
                    spreadRadius: 50,
                    offset: new Offset(0, -20)),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'TITLE SONG',
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              // color: Color(colors[1]).withOpacity(.7),
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Artist Name',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                // color: Color(colors[1]).withOpacity(.7),
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                // NowPlayingSlider(colors),
                // MusicBoardControls(colors),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
