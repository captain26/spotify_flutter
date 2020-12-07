import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/screens/login_page.dart';
import 'package:spotify/screens/playpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;

  var tabbarController;
  var selectIndex = 0;
  Future<List<dynamic>> futureSong;
  Future<List<dynamic>> futurePlaylist;

  Future<List<dynamic>> fetchSong() async {
    final response = await http
        .get("https://ancient-spire-46177.herokuapp.com/tracks/all/tracks");
    // print(jsonDecode(response.body)[0]['playlist_name']);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body);
      // return SongData.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<dynamic>> fetchPlaylist() async {
    final response = await http
        .get("https://ancient-spire-46177.herokuapp.com/tracks/playlists/all");
    // print(jsonDecode(response.body)[0]['playlist_name']);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body);
      // return SongData.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  List<dynamic> _list;
  @override
  void initState() {
    super.initState();
    tabbarController = TabController(vsync: this, initialIndex: 0, length: 2);
    futureSong = fetchSong();
    futurePlaylist = fetchPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black54,
        centerTitle: true,
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
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: tabbarController,
            indicatorColor: Colors.pink,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 5,
            tabs: [
              Tab(
                child: Text("Songs"),
              ),
              Tab(
                child: Text("Playlists"),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: TabBarView(
                controller: tabbarController,
                children: [
                  FutureBuilder(
                      future: futureSong,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return SongCard(
                                  image: Random().nextInt(7) + 1,
                                  sname: snapshot.data[index]['name'],
                                  songId: snapshot.data[index]['track'],
                                  artistName: snapshot.data[index]
                                      ['artist_name'],
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text(
                            "${snapshot.error}",
                          ));
                        }
                        // By default, show a loading spinner.
                        return Column(
                          children: [
                            Spacer(),
                            CircularProgressIndicator(),
                            Spacer(),
                          ],
                        );
                      }),
                  FutureBuilder(
                      future: futurePlaylist,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return PlaylistCard(
                                  image: Random().nextInt(7) + 1,
                                  playlistName: snapshot.data[index]
                                      ['playlist_name'],
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text(
                            "${snapshot.error}",
                          ));
                        }

                        // By default, show a loading spinner.
                        return Column(
                          children: [
                            Spacer(),
                            CircularProgressIndicator(),
                            Spacer(),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SongCard extends StatelessWidget {
  final image;
  final String sname;
  final String songId;
  final String artistName;

  SongCard({this.image, this.sname, this.songId, this.artistName});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayPage(
                      songId: songId,
                      artistName: artistName,
                    )));
      },
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/p$image.jpg",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$sname",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$artistName",
                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                  )
                ],
              ),
            ),
            Spacer(),
            Column(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                Text(
                  "200",
                  style: TextStyle(color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PlaylistCard extends StatelessWidget {
  final image;

  final String playlistName;

  PlaylistCard({this.image, this.playlistName});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/p$image.jpg",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$playlistName",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Spacer(),
            Column(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                Text(
                  "200",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
