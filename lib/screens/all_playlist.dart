import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/screens/playlist_song.dart';

class Playlist extends StatefulWidget {
  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  Future<List<dynamic>> futurePlaylist;
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

  void initState() {
    super.initState();
    futurePlaylist = fetchPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
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
            return Column(
              children: [
                Spacer(),
                CircularProgressIndicator(),
                Spacer(),
              ],
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
            builder: (context) => PlaylistSongs(
              PlaylistId: id,
              PlaylistName: playlistName,
            ),
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
