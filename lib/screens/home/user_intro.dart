import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:reapp/models/user.dart';

class UserIntro extends StatefulWidget {
  @override
  _UserIntroState createState() => _UserIntroState();
}

class _UserIntroState extends State<UserIntro> {
  final StreamController _streamController = StreamController();

  addData() async {
    // for(int i=0;i<=10;i++){
    //   await Future.delayed(Duration(seconds: 1));
    //   _streamController.sink.add(i);
    // }
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var value = await Firestore.instance.collection("user_data").document(firebaseUser.uid).get();
    _streamController.sink.add(value.data);
  }
  

  @override
  void initState(){
    super.initState();
    addData();
  }
  
  @override
  Widget build(BuildContext context) {

    // final user = Provider.of<BasicUser>(context);
    // String uid_user = user.uid;
    // var jsonData;
    // Firestore.instance.collection("user_data").document(uid_user).get().then((value){
      
    //   jsonData=value.data["Name"];
      
    //   print(jsonData);
    // });
    

    return Container(
      child: Column(
        children: <Widget>[
          StreamBuilder(
        stream: _streamController.stream,
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text("Error");
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  // color: Colors.red,
                  // size: 30.0,
                  //valueColor: Animation<Color> ,
                )
              )
            );
          }
          return Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30.0),
                  Icon(Icons.person, size: 70.0,),
                  SizedBox(height: 30.0),
                  Text("Name: "+snapshot.data["Name"],style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20)),
              SizedBox(height: 30.0),
                  Text("User Type: "+snapshot.data["UserClass"],style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20)),
                ],),
            )
          );
          //return Text("${snapshot.data}");
        },
      ),
        ],
      )
      
    );
  }

  
}