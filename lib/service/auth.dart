import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String uid;

  User({this.uid});
}

class Auth {
  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
    );
  }

  Stream<User> get onAuthStateChanged {
    return FirebaseAuth.instance.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> signinAnomously() async {
    final authResult = await FirebaseAuth.instance.signInAnonymously();

    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }
}
