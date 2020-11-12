import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reapp/models/user.dart';
import 'package:reapp/screens/authenticate/authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
  final user = Provider.of<BasicUser>(context);
  print(user);
  

    // return either the Home or Authenticate widget on authentication
  if(user==null){
    return Authenticate();
  } else{
    return Home();
  }
  }
}