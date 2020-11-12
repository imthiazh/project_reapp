import 'package:flutter/material.dart';
import 'package:reapp/screens/authenticate/register.dart';
import 'package:reapp/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignin = true;
  void toggleView(){
    setState(() => showSignin = !showSignin);
  }

  @override
  Widget build(BuildContext context) {
    print("Before creating authservice object2");
    if(showSignin){
      return Container(
        child: SignIn(toggleView: toggleView)
      );
    } else {
      return Container(
        child: Register(toggleView: toggleView)
      );
    }
  }
}