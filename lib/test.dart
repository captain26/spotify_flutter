import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/screens/playpage.dart';


class Test extends StatefulWidget {


  @override
  _TestState createState() => _TestState();
}



class _TestState extends State<Test> {
  Future<List<dynamic>> futureAlbum;
  Future<List<dynamic>> fetchAlbum() async {

    final response = await http.get("https://ancient-spire-46177.herokuapp.com/tracks/all/tracks");
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
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: FutureBuilder(
        future:futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
                itemBuilder: (context,index){
                      return  ChoisesCard(
                        image: Random().nextInt(7) + 1,
                        sname: snapshot.data[index]['name'],
                        songId: snapshot.data[index]['track'],
                        artistName: snapshot.data[index]['artist_name'],
                      );
                }
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}",));
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();


        }

      ),
    );
  }


  Widget buildList(BuildContext context, dynamic documentSnapshot) {
    return InkWell(
      onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => PlayPage()
            ));
      },
      // onTap: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Songspage(
      //           song_name: documentSnapshot.data()["song_name"],
      //           artist_name: documentSnapshot.data()["artist_name"],
      //           song_url: documentSnapshot.data()["song_url"],
      //           image_url: documentSnapshot.data()["image_url"],
      //         ))),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            documentSnapshot.data()["playlist_name"],
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        elevation: 10.0,
      ),
    );
  }
}


class ChoisesCard extends StatelessWidget {
  final image;
  final String sname;
  final String songId;
  final String artistName;

  ChoisesCard({this.image,this.sname,this.songId,this.artistName});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => PlayPage(songId: songId,artistName: artistName,)
        ));
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
                    "${sname}",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${artistName}",
                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                  )
                ],
              ),
            ),
            Spacer(),
            Column(
              children: [Icon(Icons.favorite,color: Colors.white,), Text("200")],
            )
          ],
        ),
      ),
    );
  }
}
