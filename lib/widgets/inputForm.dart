

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'dart:convert';


class InputForm extends StatefulWidget {
  
  final Function addTx;

  InputForm(this.addTx);

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  Future<void> saveInput() async {
    final title_tx = titleController.text;
    final amount_tx = double.parse(amountController.text);

    if(title_tx.isEmpty || amount_tx<=0){
      return;
    }

    widget.addTx(title_tx,amount_tx);
  final FirebaseAuth auth = FirebaseAuth.instance;
    // var DBref = FirebaseDatabase.instance.reference();
    FirebaseUser user = await auth.currentUser();
    String uid2 = user.uid;
    // String uid2 = uid;
    print("UID is:" + uid2);
    print("hello");
    void inputData() async {
      String url = "https://reapp-4a214.firebaseio.com/rewards/"+uid2+".json";
      // const url = "https://reapp-4a214.firebaseio.com/products.json";
          http.post(url, body: json.encode({
            "reward_title":title_tx,
            "reward_cost":amount_tx,
            "timestamp":DateTime.now().toString(),
            "progress" : 0.0
          }));
      }
      inputData();
  }


//uncomment
                            // final FirebaseUser user = await auth.currentUser();
                            // final uid = user.uid;
                            // print(uid);
                            // DBref.child("MyNotesData").child(uid.toString()).set({
                              //uncomment
                                // 'uid':uid.toString(),
      //                           'consumedLitres': _formData.consumedLitres.toString(),
      // 'moneySpent': _formData.moneySpent.toString(),
      // 'days': _formData.days.toString(),
      // 'weight': _formData.weight.toString(),
      // 'height':_formData.height.toString(),
      //uncomment
      // 'sample': 1.2,
      // 'reward_cost': amount_tx,
      // 'reward_title': title_tx,
      // 'timestamp2': DateTime.now().toString(),
      //uncomment
      // 'exerciseDuration': _formData.exerciseDuration.toString()
                            // });
                            // here you write the codes to input the data into firestore

  @override
  Widget build(BuildContext context) {
    return Card( //formfield
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     color: Colors.blue,
              //     width: 2
              //   )
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Reward Title"
                    ),
                    controller: titleController,
                    onSubmitted: (_) => saveInput(),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Cost"
                    ),
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    onSubmitted: (_) => saveInput(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FlatButton(
                    child: Text("Add Reward", style: TextStyle(color: Colors.blue, fontSize: 18),),
                    // color: Colors.grey,
                    onPressed: saveInput
                  )
                ],
              ),
            ),
          );
  }
}