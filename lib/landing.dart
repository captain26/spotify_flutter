import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spotify/model/stream_model.dart';
import 'package:spotify/screens/signin/login_page.dart';
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
          print('working');
          print(uid);
<<<<<<< HEAD
          // return HomeScreen(userId: uid);
          return Provider<StreamModel>(
              create: (context) => StreamModel(),
              child: Test(userId: uid)
          );

        }else {
=======
          return Test(userId: uid);
        } else {
>>>>>>> dcbfd0b90d10dc2d87f505dcf6541c16640e348e
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
