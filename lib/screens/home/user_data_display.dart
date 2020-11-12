import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reapp/models/user.dart';
import 'package:reapp/services/database.dart';

class UserDataDisplay extends StatefulWidget {
  @override
  _UserDataDisplayState createState() => _UserDataDisplayState();
}

class _UserDataDisplayState extends State<UserDataDisplay> {
  String name=" ";
  String user_class=" ";
  int i = 0;
  int flag = 0;
  dynamic user_data_got;

  DatabaseService dbservice = new DatabaseService();

void initState()
{
  Future<DocumentSnapshot> gotValue = dbservice.getUserData();
  gotValue.then((value){
    if(gotValue!=null){
    user_data_got = value.data;

    print(user_data_got);
    print(user_data_got["Name"]);
    setState(() {
      name = user_data_got["Name"];
    user_class =  user_data_got["UserClass"];
    });
      
    
    print(i);
    i+=1;
      // name = user_data_got["Name"];
      // user_class = user_data_got["UserClass"];
    }
  });
}

  

  set_display() {
  flag = 1;
  Future<DocumentSnapshot> gotValue = dbservice.getUserData();
  gotValue.then((value){
    if(gotValue!=null){
    user_data_got = value.data;

    print(user_data_got);
    print(user_data_got["Name"]);
    setState(() {
      name = user_data_got["Name"];
    user_class =  user_data_got["UserClass"];
    });
    
    print(i);
    i+=1;
      // name = user_data_got["Name"];
      // user_class = user_data_got["UserClass"];
    }
  });
  }
  
  @override
  Widget build(BuildContext context) {


  
  final user_data_snapshot = Provider.of<QuerySnapshot>(context);
  final user = Provider.of<BasicUser>(context);
  
  // String name;
  // String user_class;
  
  // if(flag==0){
  // set_display();
  // }
  return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.0),
            Icon(Icons.person, size: 70.0,),
            SizedBox(height: 30.0),
            Text("Name: "+name,style: TextStyle(
        color: Colors.black,
        fontFamily: 'RaleWay',
        fontWeight: FontWeight.bold,
        fontSize: 20)),
        SizedBox(height: 30.0),
            Text("User Type: "+user_class,style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20)),
          ],),
      )
  );
  }
}