import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:reapp/services/auth.dart';
import 'package:reapp/shared/constants.dart';
import 'package:reapp/shared/loading.dart';
import 'package:http/http.dart' as http; 
import 'dart:convert';

class Register extends StatefulWidget {
  final Function toggleView;

  
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
  AuthService _authuser = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String username = '';
  String password = '';
  String reason = '';
  String reward_title = '';
  double amount_spent = 0.00;
  double reward_cost = 0.00;
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Container(
      decoration: BoxDecoration(
              gradient: LinearGradient(
        begin: Alignment.topRight,
        end: FractionalOffset.bottomLeft,
        colors: [Colors.cyanAccent[400],Colors.blue[600]],
        stops: [0, 1]
        )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GradientAppBar(
          backgroundColorStart: Colors.blue[600],
    backgroundColorEnd: Colors.cyan,
          title: Text("Sign Up",style: TextStyle(fontFamily: 'OpenSans',)),
          elevation: 0.00,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person, color: Colors.white, size: 30),
              label: Text('Log In',style: TextStyle(fontFamily: 'OpenSans',fontSize: 18, color: Colors.white)),
              onPressed: () => widget.toggleView(),
            ),
          ],
        ),
        body: SingleChildScrollView(
                child: Container(
            padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 50.0),
            child: Form(
              key: _formkey, 
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 60.0),
                  Text("Join us!", style: TextStyle(fontSize: 35, fontFamily: 'OpenSans',color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 60.0),
                  Text("Sign Up", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color: Colors.white, )),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Username"),
                    validator: (val) {
                      return val.isEmpty ? 'Username empty' : null;
                    },
                    onChanged: (val) {
                      setState(() {
                        username = val;
                      });
                    }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Email"),
                    validator: (val) {
                      return val.isEmpty ? 'Email empty' : null;
                    },
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Password"),
                    validator: (val) {
                      return val.isEmpty ? 'pass empty' : null;
                    },
                    obscureText: true,
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    }
                  ),
                  // SizedBox(height: 20.0),
                  // Text("Please answer this short survey:",style: TextStyle(fontSize: 20)),
                  SizedBox(height: 35.0),
                  Text("What is the reason you chose this app?",style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: "Reason",
                      contentPadding: new EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
// border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    
                    // decoration: InputDecoration(
// hintText: 'Email',
),
                    validator: (val) {
                      return val.isEmpty ? 'Reason empty' : null;
                    },
                    onChanged: (val) {
                      setState(() {
                        reason = val;
                      });
                    }
                  ),
                  SizedBox(height: 30.0),

                  Text("How much do you spend each day on alcohol?",style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: textInputDecoration.copyWith(
                      hintText: "Amount",
                      // contentPadding: new EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
// border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    
                    // decoration: InputDecoration(
// hintText: 'Email',
),
                    validator: (val) {
                      return val.isEmpty ? 'Amount empty' : null;
                    },
                    onChanged: (val) {
                      setState(() {
                        amount_spent = double.parse(val);
                      });
                    }
                  ),
                  SizedBox(height: 30.0),
                  Text("Set a reward as your first step!",style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20.0),
                  TextFormField(
                    // keyboardType: TextInputType.number,
                    decoration: textInputDecoration.copyWith(
                      hintText: "Reward",
                    ),
                    validator: (val) {
                      return val.isEmpty ? 'Reward empty' : null;
                    },
                    onChanged: (val) {
                      setState(() {
                        reward_title = val;
                      });
                    }
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    // keyboardType: TextInputType.number,
                    decoration: textInputDecoration.copyWith(
                      hintText: "Cost",
                    ),
                    validator: (val) {
                      return val.isEmpty ? 'Cost empty' : null;
                    },
                    onChanged: (val) {
                      setState(() {
                        reward_cost = double.parse(val);
                      });
                    }
                  ),
                  SizedBox(height: 40.0),
                  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [SizedBox(
              height: 45,
              width: 125,
                          child: FlatButton(
                
                // color: Colors.transparent,
                // color: Colors.black.withOpacity(0),
                // color: Colors.transparent,
                // splashColor: Colors.black26,
                color: Colors.transparent,
                highlightColor: Colors.white,
                shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white, width: 1),borderRadius: BorderRadius.all(Radius.circular(5))),
              
                child: Text(
                  "Lets Go!",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)
                ),
                onPressed: () async {
                  setState(() {
                      loading = true;
                    });
                      dynamic result = await _authuser.registerWithEmailAndPassword(email, password);
                        if(result == null) {
                          setState(() {
                            loading = false;
                            error = 'Please supply a valid email';
                          });
                        }

                        final FirebaseAuth auth = FirebaseAuth.instance;
      // var DBref = FirebaseDatabase.instance.reference();
      FirebaseUser user = await auth.currentUser();
      String uid2 = user.uid;
      // String uid2 = uid;
      print("UID is:" + uid2);
      print("hello");
      void inputData() async {
          String url = "https://reapp-4a214.firebaseio.com/userdata/"+uid2+".json";
          // const url = "https://reapp-4a214.firebaseio.com/products.json";
              http.post(url, body: json.encode({
                "username":username,
                "email":email,
                "reason":reason,
                "amount":amount_spent,
                "timestamp":DateTime.now().toString()
              }));

              String url2 = "https://reapp-4a214.firebaseio.com/reason_reg/"+uid2+".json";
          // const url = "https://reapp-4a214.firebaseio.com/products.json";
              http.post(url2, body: json.encode({
                "reason":reason,
              }));

            String url1 = "https://reapp-4a214.firebaseio.com/last_consumed/"+uid2+".json";
          // const url = "https://reapp-4a214.firebaseio.com/products.json";
              http.post(url1, body: json.encode({
                "timestamp":DateTime.now().toString()
              }));

              String url3 = "https://reapp-4a214.firebaseio.com/rewards/"+uid2+".json";
          // const url = "https://reapp-4a214.firebaseio.com/products.json";
              http.post(url3, body: json.encode({
              "reward_title":reward_title,
              "reward_cost":reward_cost,
              "timestamp":DateTime.now().toString(),
              "progress" : 0.0
            }));
          }
          inputData();

                      },
              ),
            ),],),
      //             RaisedButton(
      //               color: Colors.blue,
      //               child: Text(
      //                 "Sign Up",
      //                 style: TextStyle(color: Colors.white, fontFamily: 'OpenSans', fontWeight: FontWeight.bold)
      //               ),
      //               onPressed: () async {
      //                 setState(() {
      //                 loading = true;
      //               });
      //                 dynamic result = await _authuser.registerWithEmailAndPassword(email, password);
      //                   if(result == null) {
      //                     setState(() {
      //                       loading = false;
      //                       error = 'Please supply a valid email';
      //                     });
      //                   }

      //                   final FirebaseAuth auth = FirebaseAuth.instance;
      // // var DBref = FirebaseDatabase.instance.reference();
      // FirebaseUser user = await auth.currentUser();
      // String uid2 = user.uid;
      // // String uid2 = uid;
      // print("UID is:" + uid2);
      // print("hello");
      // void inputData() async {
      //     String url = "https://reapp-4a214.firebaseio.com/userdata/"+uid2+".json";
      //     // const url = "https://reapp-4a214.firebaseio.com/products.json";
      //         http.post(url, body: json.encode({
      //           "username":username,
      //           "email":email,
      //           "reason":reason,
      //           "amount":amount_spent,
      //           "timestamp":DateTime.now().toString()
      //         }));

      //       String url1 = "https://reapp-4a214.firebaseio.com/last_consumed/"+uid2+".json";
      //     // const url = "https://reapp-4a214.firebaseio.com/products.json";
      //         http.post(url1, body: json.encode({
      //           "timestamp":DateTime.now().toString()
      //         }));

      //         String url3 = "https://reapp-4a214.firebaseio.com/rewards/"+uid2+".json";
      //     // const url = "https://reapp-4a214.firebaseio.com/products.json";
      //         http.post(url3, body: json.encode({
      //         "reward_title":reward_title,
      //         "reward_cost":reward_cost,
      //         "timestamp":DateTime.now().toString()
      //       }));
      //     }
      //     inputData();

      //                 }
                      
      //                 // if(_formkey.currentState.validate()){
      //                 //   setState(() {
      //                 //     loading = true;
      //                 //   });
      //                 //   dynamic result = await _authuser.signInWithEmailAndPassword(email,password);
      //                 //   if(result==null){
      //                 //     setState(() {
      //                 //       loading = false;
      //                 //        error = 'Invalid Credentials';
      //                 //     });
      //                 //   }
      //                 // }
      //                 // else{
      //                 //   print("lol1234");
      //                 // }
      //             ),
                  SizedBox(height: 10.0),
                  Text(error)
                ],
              )
            )
          ),
        )
      ),
    );
  }
}