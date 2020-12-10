import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/screens/login_page.dart';
import 'package:spotify/service/auth.dart';
import 'package:spotify/test.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return LoginPage();
          }
          final uid = user.uid;
          print(uid);
          return Test(userId: uid);
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
