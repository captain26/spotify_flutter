import 'dart:convert';
import 'dart:math';

<<<<<<< HEAD
import 'package:audioplayers/audioplayers.dart';
=======
>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spotify/model/song_model.dart';
import 'package:spotify/model/stream_model.dart';
import 'package:spotify/screens/playpage.dart';
import 'package:http/http.dart' as http;

class Songs extends StatefulWidget {
  AudioPlayer audioPlayer;

  Songs({this.audioPlayer});
  @override
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  FirebaseUser loggedInUser;
  final _auth = FirebaseAuth.instance;

<<<<<<< HEAD

=======
>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e
  Future<List<dynamic>> futureSong;

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
<<<<<<< HEAD
=======

>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
<<<<<<< HEAD
=======

>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    futureSong = fetchSong();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    Size size = MediaQuery.of(context).size;
    return  Expanded(
        child: FutureBuilder(
            future: futureSong,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return SongCard(
                        image: Random().nextInt(7) + 1,
                        sname: snapshot.data[index]['name'],
                        //TODO: Check Error
                        // userId: loggedInUser.uid,
                        id: snapshot.data[index]['_id'],
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
      );

=======
    return Expanded(
      child: FutureBuilder(
          future: futureSong,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return SongCard(
                      image: Random().nextInt(7) + 1,
                      sname: snapshot.data[index]['name'],
                      userId: loggedInUser.uid,
                      id: snapshot.data[index]['_id'],
                      songId: snapshot.data[index]['track'],
                      artistName: snapshot.data[index]['artist_name'],
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
    );
>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e
  }
}

class SongCard extends StatelessWidget {


  final image;
  final String sname;
  final String songId;
  final String artistName;
  final id;
  final userId;

<<<<<<< HEAD
  SongCard({this.image, this.sname, this.songId, this.artistName,this.id,this.userId});
=======
  SongCard(
      {this.image,
      this.sname,
      this.userId,
      this.id,
      this.songId,
      this.artistName});

>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e
  Future<List<dynamic>> futurePlaylist;

  Future<List<dynamic>> fetchPlaylist() async {
    final response = await http
<<<<<<< HEAD
        .get("https://ancient-spire-46177.herokuapp.com/tracks/myplaylist/$userId");
=======
        .get("https://spotify412.herokuapp.com/tracks/myplaylist/$userId");
>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e
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

  void showDialogBox(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    print(height);
    print(width);
    var popup = AlertDialog(
      content: Container(
        height: height * 0.5,
        width: width * 0.8,
        child: FutureBuilder(
            future: futurePlaylist,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return PlaylistCard(
                        trackId: id,
                        playlistId: snapshot.data[index]['_id'],
                        image: Random().nextInt(7) + 1,
                        playlistName: snapshot.data[index]['playlist_name'],
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
<<<<<<< HEAD
                      "${snapshot.error}",
                    ));
=======
                  "${snapshot.error}",
                ));
>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e
              }

              // By default, show a loading spinner.
              return Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Spacer(),
                    CircularProgressIndicator(),
                    Spacer(),
                  ],
                ),
              );
            }),
      ),
    );
    // ignore: non_constant_identifier_names
    showDialog(context: context, builder: (BuildContext) => popup);
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<StreamModel>(context,listen: false);
    return InkWell(
      onTap: () {
<<<<<<< HEAD
        model.inString.add(Song(uid: songId,Name: sname,Artist: artistName));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => PlayPage(
        //           songId: songId,
        //           artistName: artistName,
        //         )));
=======
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayPage(
                      songId: songId,
                      artistName: artistName,
                    )));
>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e
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
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.white,
              onPressed: () {
                print(id);
                futurePlaylist = fetchPlaylist();
                showDialogBox(context);
              },
            ),
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

  final playlistId;
  final trackId;

  final String playlistName;

  PlaylistCard({this.trackId, this.playlistId, this.image, this.playlistName});

  Future<void> addingSongToPlaylist() async {
<<<<<<< HEAD
    var url = 'https://ancient-spire-46177.herokuapp.com/tracks/addsongtoplaylist';
=======
    var url = 'https://spotify412.herokuapp.com/tracks/addsongtoplaylist';
>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e
    Map<String, String> header = new Map();

    header['Content-Type'] = 'application/json';
    var body = json.encode({
      'trackID': trackId,
      'playlistID': playlistId,
    });
    var response = await http.post(url, headers: header, body: body);
    print('Response body: ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        addingSongToPlaylist();
        Navigator.pop(context);
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
                    "$playlistName",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
