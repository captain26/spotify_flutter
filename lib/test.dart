import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/screens/all_playlist.dart';
import 'package:spotify/screens/all_songs.dart';
import 'package:spotify/screens/login_page.dart';
import 'package:spotify/screens/playpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;

  List<Widget> screens = [Songs(),Playlist()];
  var tabbarController;
  // var selectIndex = 0;

  List<dynamic> _list;
  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onTap: () async {
              await _auth.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
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
        ],
      ),
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





