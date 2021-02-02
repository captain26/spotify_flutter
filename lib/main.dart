import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/landing.dart';
import 'package:spotify/model/song_player.dart';
import 'package:spotify/model/stream_model.dart';
import 'package:spotify/screens/signin/login_page.dart';
import 'package:spotify/screens/playpage.dart';
import 'package:spotify/service/auth.dart';
import 'package:spotify/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<SongPlayer>(
      create: (context) => SongPlayer(),
      child: Provider<StreamModel>(
        create: (context) => StreamModel(),
        child: Provider<Auth>(
          create: (_) => Auth(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LandingPage(),
            routes: {
              '/song': (ctx) => PlayPage()
            },
          ),
        ),
      ),
    );
  }
}
