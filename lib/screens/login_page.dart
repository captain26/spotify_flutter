import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/service/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Future<void> _signinAnonmously(BuildContext context) async{
    final auth = Provider.of<Auth>(context,listen: false);
    try{
      await auth.signinAnomously();
    }catch(e){
      print(e);
    }

  }


  @override
  Widget build(BuildContext context) {
    final auth =  Provider.of<Auth>(context,listen: false);
    return Scaffold(
      body: Container(
          child: FlatButton(
            child: Text("TaP me"),
            onPressed: () async{
              await _signinAnonmously(context);
            },
          ),
      ),
    );
  }
}
