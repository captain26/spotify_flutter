import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/landing.dart';
import 'package:spotify/screens/home_screen.dart';
import 'package:spotify/service/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create: (context) => Auth(),
      child: MaterialApp(
        home: LandingPage(),
      ),
    );
  }
}
