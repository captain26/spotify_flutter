import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/landing.dart';
import 'package:spotify/screens/login_page.dart';
import 'package:spotify/service/auth.dart';
import 'package:spotify/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create: (context) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
  }
}
