import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/screens/playlist_song.dart';

class MyPlaylist extends StatefulWidget {
  final userId;
  MyPlaylist({this.userId});

  @override
  _MyPlaylistState createState() => _MyPlaylistState();
}

class _MyPlaylistState extends State<MyPlaylist> {
  Future<List<dynamic>> futurePlaylist;

  String playlist_name;

  Future<List<dynamic>> fetchPlaylist() async {
    final response = await http.get(
        "https://ancient-spire-46177.herokuapp.com/tracks/myplaylist/${widget.userId}");
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

  Future<void> addingPlaylist() async {
    print(playlist_name);
    var url =
        'https://ancient-spire-46177.herokuapp.com/tracks/playlist/create/${widget.userId}';
    Map<String, String> header = new Map();

    header['Content-Type'] = 'application/json';
    var body = json.encode({
      'playlist_name': playlist_name,
    });
    var response = await http.post(url, headers: header, body: body);
    print('Response body: ${response.body}');
  }

  void initState() {
    super.initState();
    futurePlaylist = fetchPlaylist();
    print(widget.userId);
  }

  void showDialogBox(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    bool _autovalidate = false;

    var popup = AlertDialog(
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          autovalidate: _autovalidate,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Playlist Name',
                  contentPadding:
                      EdgeInsets.only(top: 25, bottom: 25, left: 20),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(width: 2, style: BorderStyle.none),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(width: 2, color: Colors.blue),
                  ),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Playlist Name is Required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  playlist_name = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                focusElevation: 0,
                highlightElevation: 0,
                splashColor: Colors.white.withOpacity(0.1),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                onPressed: () async {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();

                  try {
                    final result = await InternetAddress.lookup('google.com');
                    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                      print('connected');
                      addingPlaylist();
                      Navigator.pop(context);
                    }
                  } on SocketException catch (_) {
                    print('not connected');
                    Navigator.pop(context);
                  }
                },
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Add Playlist',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // ignore: non_constant_identifier_names
    showDialog(context: context, builder: (BuildContext) => popup);
  }

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
                "ADD",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () {
              showDialogBox(context);
            },
          ),
        ],
        title: Text('My Playlists',
            style: GoogleFonts.raleway(textStyle: TextStyle(fontSize: 30))),
      ),
      body: FutureBuilder(
          future: futurePlaylist,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return PlaylistCard(
                      id: snapshot.data[index]['_id'],
                      image: Random().nextInt(7) + 1,
                      playlistName: snapshot.data[index]['playlist_name'],
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                "${snapshot.error}",
              ));
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
    );
  }
}

class PlaylistCard extends StatelessWidget {
  final image;

  final id;
  final String playlistName;

  PlaylistCard({this.id, this.image, this.playlistName});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PlaylistSongs(PlaylistId: id, PlaylistName: playlistName),
          ),
        );
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
