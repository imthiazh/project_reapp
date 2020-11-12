import 'dart:convert';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:emoji_feedback/emoji_feedback.dart';
import 'package:reapp/models/transaction.dart';

class UpdateStats extends StatefulWidget {
  static const routeName = '/update';

  @override
  _UpdateStatsState createState() => _UpdateStatsState();
}

class _UpdateStatsState extends State<UpdateStats> {

  List<Transaction> transactions;
  dynamic json_rs;
  double consumedLitres;

  double moneySpent;

  String reason_daily;

  double days;

  double weight;

  double height;

  double sleep;

  double exerciseDuration;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Future<void> _saveForm() async {
    final isValid = _fbKey.currentState
        .validate(); //to trigger all the validators in the various text field
    if (!isValid) {
      //only if all validators return null,isValid will be true.
      return;
    }
    _fbKey.currentState.save();
    final FirebaseAuth auth = FirebaseAuth.instance;
    // var DBref = FirebaseDatabase.instance.reference();
    FirebaseUser user = await auth.currentUser();
    String uid2 = user.uid;
    // String uid2 = uid;
    // print("UID is:" + uid2);
    // print("hello");
    void inputData() async {
      String url = "https://reapp-4a214.firebaseio.com/userstats/"+uid2+".json";
      // const url = "https://reapp-4a214.firebaseio.com/products.json";
          http.post(url, body: json.encode({
            "consumedLitres":consumedLitres,
            "moneySpent":moneySpent,
            "days":days,
            "weight":weight,
            "height":height,
            "sleep":sleep,
            "reason_daily":reason_daily,
            "exerciseDuration":exerciseDuration,
            "timestamp":DateTime.now().toString()
          }));

        String url10 = "https://reapp-4a214.firebaseio.com/reason_daily/"+uid2+".json";
        http.post(url10, body: json.encode({            
            "reason_daily":reason_daily,
          }));
        if(consumedLitres>0){
          String url1 = "https://reapp-4a214.firebaseio.com/last_consumed/"+uid2+".json";
        // const url = "https://reapp-4a214.firebaseio.com/products.json";
            http.post(url1, body: json.encode({
              "timestamp":DateTime.now().toString()
            }));
        }
        else{
           
        print("please");
        // print(moneySpent / transactions[0].amount);
        // String url0 =
        //     "https://reapp-4a214.firebaseio.com/rewards/" + uid2 + ".json";
        // http.post(url0,
        //     body: json.encode({"progress": transactions[0].progress}));  
        String url0 =
            "https://reapp-4a214.firebaseio.com/rewards/" + uid2 + ".json";
        // const url = "https://reapp-4a214.firebaseio.com/products.json";
        // onError2(){
        //   return;
        // };
        dynamic rs = await http.get(url0);
        
        print(json.decode(rs.body));
        json_rs = json.decode(rs.body) as Map<String, dynamic>;
        List<Transaction> rewards_collected = [];
        json_rs.forEach((prodId, prodData) {
          print("Data is" +
              prodData['reward_title'] +
              prodData['reward_cost'].toString());

          rewards_collected.add(Transaction(
              id: prodId,
              title: prodData['reward_title'],
              amount: prodData['reward_cost'],
              date: DateTime.parse(prodData['timestamp']),
              progress: prodData['progress']));
        });

        int i=0;
        int identifier=0;
        bool itsSelected = false;
        json_rs.forEach((prodId, prodData) {
          
          if(prodData['progress']<100 && !itsSelected){
            i = identifier;
            itsSelected = true;
          }
          identifier++;
        });
        print("I value is: $i");

        transactions = rewards_collected;

        print("ttrreeii");
        print(transactions[i].amount);

        // double new_progress = transactions[0].progress +
        //     ((moneySpent / transactions[0].amount) * 100);
        transactions[i].progress = transactions[i].progress +
            ((moneySpent / transactions[i].amount) * 100);

        if(transactions[i].progress>100){
          transactions[i].progress = 100;
        }
        // print("pleaseeeeeeeeeeeeeeeeeeeeeee");
        print("Progresssss is:");print(transactions[i].progress);
        String url6 =
            "https://reapp-4a214.firebaseio.com/rewards/"+uid2+"/"+transactions[i].id+".json";
        http.patch(url6,
            body: json.encode({"progress": transactions[i].progress,
              // "reward_cost": transactions[0].amount,
              // "reward_title": transactions[0].title,
              // "timestamp": transactions[0].date,
            }));
  
        }

        String url3 = "https://reapp-4a214.firebaseio.com/last_consumed/"+uid2+".json";
        // const url = "https://reapp-4a214.firebaseio.com/products.json";
          dynamic resp = await http.get(url3);
          // dynamic json_resp;
          print(json.decode(resp.body));
          resp=json.decode(resp.body) as Map<String, dynamic>;
          int count = 0;
          String last_date;
          // print(json_resp['timestamp']);
          resp.forEach((prodId, prodData) {
            last_date = prodData['timestamp'];
          });
          // String last = json_resp[count]['timestamp'];
          print(last_date);
      }
      inputData();


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
              gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.cyanAccent[400],Colors.blue[600]],
        )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GradientAppBar(
          backgroundColorStart: Colors.blue[600],
    backgroundColorEnd: Colors.cyan,
    title: Text('My Notes',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                  )),
          // title: Text('My Notes'),
        ),
        body: Container(
          
          child: FormBuilder(
            key: _fbKey,
            child: Container(
              
              child: SingleChildScrollView(
                child: Container(
        //           decoration: BoxDecoration(
        //       gradient: LinearGradient(
        // begin: Alignment.topRight,
        // end: Alignment.bottomLeft,
        // colors: [Colors.cyanAccent[400],Colors.blue[600]],
        // )),
                  child: Column(
                    children: <Widget>[
                      Container(
                        // color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 30.0),
                        Text("Keep track daily!", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)),
                        SizedBox(height: 30.0),
                              Text('1. How much alcohol did you consume today ? (ml)',
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)),
                                  SizedBox(height: 20.0),
                              FormBuilderSlider(
                                // divisions: /,
                                attribute: 'slider',
                                textStyle: TextStyle(fontSize: 15,fontFamily: 'OpenSans',color:Colors.white),
                                min: 0,
                                inactiveColor: Colors.white,
                                activeColor: Colors.cyan[100],
                                max: 10,
                                initialValue: 0,
                                onSaved: (value) {
                                  consumedLitres = double.parse(value.toString());
                                  print(value);
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text('2. How much do you usually spend on alcohol in a day? (Rs.)',
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)),
                                  SizedBox(
                                height: 10,
                              ),
                              SizedBox(height: 20.0),
                              FormBuilderTextField(
                                  attribute: 'textfield',
                                  style: TextStyle(fontSize: 20,fontFamily: 'OpenSans',color:Colors.white),
                                  cursorColor: Colors.blue,
                                  maxLines: 1,
                                  validators: [
                                    //FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                  ],
                                //   textStyle: TextStyle(fontSize: 15,fontFamily: 'OpenSans',color:Colors.white),
                                // // min: 0,
                                // inactiveColor: Colors.white,
                                // activeColor: Colors.cyan[100],
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    moneySpent = double.parse(value.toString());
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '3. How many days have you gone without alcohol ?',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FormBuilderTouchSpin(
                                  attribute: 'touch_spin',
                                  // textStyle: ,
                                  textStyle: TextStyle(fontSize: 20,fontFamily: 'OpenSans',color:Colors.white),
                                  iconActiveColor: Colors.white,
                                  iconDisabledColor: Colors.cyan,
                                  initialValue: 1,
                                  step: 1,
                                  onSaved: (value) {
                                    days = double.parse(value.toString());
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '4. Enter your weight in kilograms',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FormBuilderTextField(
                                  attribute: 'textfield',
                                  style: TextStyle(fontSize: 20,fontFamily: 'OpenSans',color:Colors.white),
                                  maxLines: 1,
                                  validators: [
                                    //FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                  ],
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    weight = double.parse(value.toString());
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '5. Enter your height in centimetres',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FormBuilderTextField(
                                  attribute: 'textfield',
                                  style: TextStyle(fontSize: 20,fontFamily: 'OpenSans',color:Colors.white),
                                  maxLines: 1,
                                  validators: [
                                    //FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                  ],
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    height = double.parse(value.toString());
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '6. How many hours did you sleep yesterday ?',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FormBuilderTouchSpin(
                                  attribute: 'touch_spin',
                                  textStyle: TextStyle(color: Colors.white, fontSize: 25),
                                  iconActiveColor: Colors.white,
                                  initialValue: 1,
                                  step: 1,
                                  onSaved: (value) {
                                    sleep = double.parse(value.toString());
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '7. How many minutes did you workout today ?',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FormBuilderTextField(
                                  attribute: 'textfield',
                                  style: TextStyle(fontSize: 20,fontFamily: 'OpenSans',color:Colors.white),
                                  maxLines: 1,
                                  validators: [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                    FormBuilderValidators.maxLength(3),
                                  ],
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    exerciseDuration = double.parse(value.toString());
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '8. How are you feeling today ?',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              EmojiFeedback(
                                onChange: (index) {
                                  print(index);
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                '9. Tell us how you feel',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FormBuilderTextField(
                                attribute: 'textfield',
                                style: TextStyle(fontSize: 20,fontFamily: 'OpenSans',color:Colors.white),
                                maxLines: 3,
                                validators: [
                                  FormBuilderValidators.required(),
                                ],
                                onSaved: (value) {
                                    reason_daily = value;
                                  }
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FlatButton(
                
                // color: Colors.transparent,
                // color: Colors.black.withOpacity(0),
                // color: Colors.transparent,
                // splashColor: Colors.black26,
                color: Colors.transparent,
                highlightColor: Colors.white,
                shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white, width: 1),borderRadius: BorderRadius.all(Radius.circular(5))),
              
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)
                ),
                onPressed: _saveForm
              ),
                              // RaisedButton(
                              //   child: Text('Submit'),
                              //   onPressed: _saveForm,
                              //   color: Colors.blue,
                              // ),
                              SizedBox(
                                height: 20,
                              ),
                              // RaisedButton(
                              //   child: Text('Reset'),
                              //   color: Colors.blue,
                              //   onPressed: () {
                              //     _fbKey.currentState.reset();
                              //   },
                              // )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          // RaisedButton(
                          //   child: Text('Submit'),
                          //   onPressed: _saveForm,
                          // ),

                          // RaisedButton(
                          //   child: Text('Reset'),
                          //   onPressed: () {
                          //     _fbKey.currentState.reset();
                          //   },
                          // )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}