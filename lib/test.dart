import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spotify/screens/all_playlist.dart';
import 'package:spotify/screens/all_songs.dart';
import 'package:spotify/screens/playlist.dart';
import 'package:http/http.dart' as http;

import 'service/auth.dart';

class Test extends StatefulWidget {
  final userId;
  Test({this.userId});

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // addingUser();
  }

  int _selectedIndex = 0;
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
    } catch (e) {
      print(e);
    }
  }

  List<Widget> screens = [Songs(), Playlist()];
  var tabbarController;
  // var selectIndex = 0;

  List<dynamic> _list;
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
            onTap: () {
              signOut();
            },
          ),
        ],
        title: Text(
          'Spotify',
          style: GoogleFonts.raleway(
            textStyle: TextStyle(fontSize: 40),
          ),
        ),
      ),
      body: Column(
        children: [
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
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      backgroundColor: Colors.black54,
      minWidth: 1.0,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      groupAlignment: -0.1,
      labelType: NavigationRailLabelType.all,
      selectedLabelTextStyle: GoogleFonts.raleway(
          textStyle: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15)),
      unselectedLabelTextStyle: GoogleFonts.raleway(
          textStyle: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
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
