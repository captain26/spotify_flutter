import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spotify/model/song_model.dart';
import 'package:spotify/model/song_player.dart';
import 'package:spotify/model/stream_model.dart';
import 'package:spotify/screens/all_playlist.dart';
import 'package:spotify/screens/all_songs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/screens/bottom_panel.dart';
import 'package:spotify/screens/playing_second.dart';
import 'package:spotify/screens/playlist.dart';
import 'package:spotify/screens/playpage.dart';
import 'package:spotify/service/auth.dart';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget {
  final userId;
  Test({this.userId});

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin, ChangeNotifier {


  final _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  AudioPlayer audioPlayer = new AudioPlayer();

  List<Widget> screens = [Songs(),Playlist()];
  var tabbarController;
  // var selectIndex = 0;
  Future<void> addingUser() async {
    var url = 'https://ancient-spire-46177.herokuapp.com/tracks/user';
    Map<String, String> header = new Map();

    header['Content-Type'] = 'application/json';
    var body = json.encode({
      'first_name': 'vasu bansal',
      '_id': widget.userId.toString(),
    });
    var response = await http.post(url, headers: header, body: body);
    print('Response body: ${response.body}');
  }

  Future<void> signOut() async {
    final auth = Provider.of<Auth>(context, listen: false);

    try {
      auth.signOut();
      print('hello');
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    final model = Provider.of<StreamModel>(context, listen: false);

    return StreamBuilder<Song>(
      stream: model.outString,
      builder: (context, snapshot) {
        return ChangeNotifierProvider(
          create: (context) => checkBool(),
          child: SlidingUpPanel(
            panel: PlayPage(songInfo: snapshot.data,),
            minHeight: 60,
            maxHeight: MediaQuery.of(context).size.height,
            backdropEnabled: true,
            backdropOpacity: 0.5,
            parallaxEnabled: true,
            collapsed: BottomPanel(songInfo: snapshot.data,),
            body: Scaffold(
              backgroundColor: Colors.black54,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.black54,
                actions: [
                  GestureDetector(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "SignOut",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap:   () async {
                      await Provider.of<Auth>(context, listen: false);
                    },
                  ),
                ],
                title: Text(
                    'Spotify',
                    style: GoogleFonts.raleway(textStyle: TextStyle(fontSize: 40))
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .headline4
                  //     .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              body: Column(
                children: [
                  // TabBar(
                  //   controller: tabbarController,
                  //   indicatorColor: Colors.pink,
                  //   indicatorSize: TabBarIndicatorSize.label,
                  //   indicatorWeight: 5,
                  //   tabs: [
                  //     Tab(
                  //       child: Text("Songs"),
                  //     ),
                  //     Tab(
                  //       child: Text("Playlists"),
                  //     )
                  //   ],
                  // ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [_buildNavigationRail(), screens[_selectedIndex]],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyPlaylist(userId: widget.userId),
                            ),
                          );
                        },
                        child: Text(
                          'My Playlist',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Text(
                        'Search',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget _buildNavigationRail() {
    return NavigationRail(
      backgroundColor: Colors.black54,
        minWidth: 1.0 ,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      groupAlignment: -0.1,
      labelType: NavigationRailLabelType.all,
      selectedLabelTextStyle:
          GoogleFonts.raleway(textStyle: TextStyle(color: Colors.red , fontWeight: FontWeight.bold,fontSize: 15) ),
      unselectedLabelTextStyle:
      GoogleFonts.raleway(textStyle: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold,fontSize: 12) ),
      // leading: Column(
      //   children: [
      //     Icon(
      //       Icons.playlist_play,
      //       color: Color(0xff0968B0),
      //     ),
      //     SizedBox(height: 5.0),
      //     RotatedBox(
      //       quarterTurns: -1,
      //       child: Text(
      //         'Your playlists',
      //         style:
      //         TextStyle(color: Color(0xff0968B0), fontWeight: FontWeight.bold),
      //       ),
      //     )
      //   ],
      // ),
      destinations: [
        NavigationRailDestination(
          icon: SizedBox.shrink(),
          label: RotatedBox(
            quarterTurns: -1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('All Songs'),
            ),
          ),
        ),
        NavigationRailDestination(
          icon: SizedBox.shrink(),
          label: RotatedBox(
            quarterTurns: -1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(' All Playlists'),
            ),
          ),
        )
      ],
    );
  }

}





