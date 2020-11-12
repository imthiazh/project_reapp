import 'dart:convert';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reapp/models/transaction.dart' as trans;
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:reapp/screens/home/user_data_display.dart';
import 'package:reapp/screens/home/user_intro.dart';
import 'package:reapp/services/auth.dart';
import 'package:reapp/services/database.dart';
import 'package:flutter/rendering.dart';
import 'package:reapp/screens/anti_alcohol_chew.dart';
import 'package:reapp/screens/call_center.dart';
import 'package:reapp/screens/reward.dart';
import 'package:reapp/screens/update_stats.dart';
import 'package:reapp/widgets/listTransaction.dart';
import 'package:reapp/widgets/main_drawer.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _result = "yo";
  String _last_date;
  int a;
  int b;
  int c;
  int d;

  Timer _timer;

  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      getResponse().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  dynamic json_rs;
  var _isInit = true;
  var _isLoading = false;
  String last_date = "p";
  List<trans.Transaction> rewards_first = [];

  Future<void> getResponse() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user_i = await auth.currentUser();
    String uid2 = user_i.uid;
    // String uid2 = uid;
    print("UID is:" + uid2);
    print("hello");
    String url = "https://reapp-4a214.firebaseio.com/rewards/" + uid2 + ".json";
    // const url = "https://reapp-4a214.firebaseio.com/products.json";
    // onError2(){
    //   return;
    // };
    dynamic rs = await http.get(url);

    print(json.decode(rs.body));
    json_rs = json.decode(rs.body) as Map<String, dynamic>;
    // List<trans.Transaction> rewards_collected=[];
    // json_rs.forEach()
    // setState()
    json_rs.forEach((prodId, prodData) {
      rewards_first.add(trans.Transaction(
          id: prodId,
          title: prodData['reward_title'],
          amount: prodData['reward_cost'],
          date: DateTime.parse(prodData['timestamp']),
          progress: prodData['progress']));
    });
    String url3 =
        "https://reapp-4a214.firebaseio.com/last_consumed/" + uid2 + ".json";
    // const url = "https://reapp-4a214.firebaseio.com/products.json";
    dynamic resp = await http.get(url3);
    // dynamic json_resp;
    print(json.decode(resp.body));
    resp = json.decode(resp.body) as Map<String, dynamic>;
    int count = 0;

    // print(json_resp['timestamp']);
    resp.forEach((prodId, prodData) {
      _last_date = prodData['timestamp'];
    });
    // String last = json_resp[count]['timestamp'];
    print(_last_date);
    a = DateTime.now().difference(DateTime.parse(_last_date)).inDays;

    b = (DateTime.now().difference(DateTime.parse(_last_date)).inHours);
    if (a > 0) {
      b = b % 24; //convert to hours
    }
    c = (DateTime.now().difference(DateTime.parse(_last_date)).inMinutes);
    if (b > 0) {
      c = c % 60; 
    }
    d = (DateTime.now().difference(DateTime.parse(_last_date)).inSeconds);
    if (c > 0) {
      d = d % 60;
    }
    _result = "$a days, $b hours, $c minutes, $d seconds.";
    print(_result);

    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (d > -1) {
          d++;
          if (d == 60) {
            c++;
            d = 0;
          }
          if (c == 60) {
            b++;
            c = 0;
          }
        } else {
          _timer.cancel();
        }
      });
    });
    setState(() {
      
    });
  }

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15))), 
      height: 300.0,
      child: Carousel(
        borderRadius: true,
        radius: Radius.circular(20),
        showIndicator: false,
        boxFit: BoxFit.cover, //image takes the full box
        images: [
          AssetImage('assets/images/img_carousel_4.jpg'),
          AssetImage('assets/images/img_carousel_5.jpg'),
          AssetImage('assets/images/img_carousel_6.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        animationDuration: Duration(milliseconds: 25),
        autoplayDuration: Duration(seconds: 9),
        dotSize: 0,
      ),
    );

    Widget imageCarousel2 = Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15))), 
      height: 300.0,
      child: Carousel(
        borderRadius: true,
        radius: Radius.circular(20),
        showIndicator: false,
        boxFit: BoxFit.cover, //image takes the full box
        images: [
          AssetImage('assets/images/medic_offers.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        animationDuration: Duration(milliseconds: 25),
        autoplayDuration: Duration(seconds: 9),
        dotSize: 0,
      ),
    );
    
      return StreamProvider<QuerySnapshot>.value(
        value: DatabaseService().user_data_stream,
        child: Container(
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
              title: Text('Reapp',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                  )),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      _auth.signOut();
                    },
                    icon: Icon(Icons.person, color: Colors.white, size: 30),
                    label: Text('Logout',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 18,
                            color: Colors.white))),
              ],
            ),
            drawer: MainDrawer(),
            body: RefreshIndicator(
              onRefresh: getResponse,
              child: SingleChildScrollView(
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    imageCarousel,
                    // _isLoading
                    //     ? CircularProgressIndicator()
                        SizedBox(
                            height: 10,
                          ),
                    Text(
                      "   Days gone without alcohol",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _isLoading ? Container(
                      width: 410,
                      height: 127,
                      padding: EdgeInsets.only(left: 3),
                      child: Card(
                        color: Colors.blue[50],
                        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white, width: 1),borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Container(child: Center(child : CircularProgressIndicator()),
                        decoration: BoxDecoration(
    
  ),)
                        

                        // color: Colors.blue,
                        
                      ),
                    ) : Container(
                      width: 410,
                      padding: EdgeInsets.only(left: 3),
                      child: Card(
                        color: Colors.blue[50],
                        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white, width: 1),borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Container(child: Column(
                          children: [
                            SizedBox(height: 30),
                            Container(
                              width: 370,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  
                                  Text(
                                  "$a",
                                  style: TextStyle(
                                      color: Colors.blue[600],
                                      fontSize: 30,
                                      fontFamily: 'OpenSans'),
                                ),
                                Text(
                                  ":",
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 20,
                                      fontFamily: 'OpenSans'),
                                ),
                                Text(
                                  "$b",
                                  style: TextStyle(
                                      color: Colors.blue[600],
                                      fontSize: 30,
                                      fontFamily: 'OpenSans'),
                                ),
                                Text(
                                  ":",
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 20,
                                      fontFamily: 'OpenSans'),
                                ),
                                Text(
                                  "$c",
                                  style: TextStyle(
                                      color: Colors.blue[600],
                                      fontSize: 30,
                                      fontFamily: 'OpenSans'),
                                ),
                                Text(
                                  ":",
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 30,
                                      fontFamily: 'OpenSans'),
                                ),
                                  Text(
                                  "$d",
                                  style: TextStyle(
                                      color: Colors.blue[600],
                                      fontSize: 30,
                                      fontFamily: 'OpenSans'),
                                ),
                                
                                // Card(child: Text("abc"),),
                                // Card(child: Text("abc"),),
                                // Card(child: Text("abc"),)
                              ],
                              ),
                            ),
                            Container(
                              width: 370,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  
                                  Text(
                                  "        DAYS              HOURS            MINUTES          SECONDS",
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 12,
                                      fontFamily: 'OpenSans'),
                                ),
                                // Text(
                                //   "Days",
                                //   style: TextStyle(
                                //       color: Colors.blue[600],
                                //       fontSize: 30,
                                //       fontFamily: 'OpenSans'),
                                // ),
                                // Text(
                                //   "Days",
                                //   style: TextStyle(
                                //       color: Colors.blue[600],
                                //       fontSize: 30,
                                //       fontFamily: 'OpenSans'),
                                // ),
                                // Text(
                                //   "Days",
                                //   style: TextStyle(
                                //       color: Colors.blue[600],
                                //       fontSize: 30,
                                //       fontFamily: 'OpenSans'),
                                // ),
                                
                                
                                // Card(child: Text("abc"),),
                                // Card(child: Text("abc"),),
                                // Card(child: Text("abc"),)
                              ],
                              ),
                              
                            ),
                            SizedBox(height: 30),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //   Card(child: Text("abc"),),
                            //   Card(child: Text("abc"),),
                            //   Card(child: Text("abc"),)
                            // ],
                            // ),
                            
                          ],
                          
                        ),
                        decoration: BoxDecoration(
    // gradient: LinearGradient(
      // begin: Alignment.topRight,
      //   end: Alignment.bottomLeft,
        // colors: [Colors.white[400],Colors.white[600]]
      //  colors: [Colors.white,Colors.white,]
      //  )
  ),)
                        

                        // color: Colors.blue,
                        
                      ),
                    ),
                    // _isLoading ? Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white) ,)) : Container(
                    //   child: Column(
                    //     children: <Widget>[
                    //       Container(
                    //         child: Card()
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: <Widget>[
                    //           Text(
                    //             'Days',
                    //             style: TextStyle(
                    //                 //color: Colors.black,
                    //                 fontSize: 15,
                    //                 fontFamily: 'OpenSans'),
                    //           ),
                    //           Text(
                    //             'Hours',
                    //             style: TextStyle(
                    //                 //color: Colors.black,
                    //                 fontSize: 15,
                    //                 fontFamily: 'OpenSans'),
                    //           ),
                    //           Text(
                    //             'Minutes',
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontSize: 15,
                    //                 fontFamily: 'OpenSans'),
                    //           ),
                    //           Text(
                    //             'Seconds',
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontSize: 15,
                    //                 fontFamily: 'OpenSans'),
                    //           ),
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: <Widget>[
                    //           Text(
                    //             "$a",
                    //             style: TextStyle(
                    //                 //color: Colors.black,
                    //                 fontSize: 15,
                    //                 fontFamily: 'OpenSans'),
                    //           ),
                    //           Text(
                    //             "$b",
                    //             style: TextStyle(
                    //                 //color: Colors.black,
                    //                 fontSize: 15,
                    //                 fontFamily: 'OpenSans'),
                    //           ),
                    //           Text(
                    //             "$c",
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontSize: 15,
                    //                 fontFamily: 'OpenSans'),
                    //           ),
                    //           Text(
                    //             "$d",
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontSize: 15,
                    //                 fontFamily: 'OpenSans'),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    //   height: 50,
                    // ),
                    SizedBox(height: 10),
                    Text('   Upcoming Rewards',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)),
                    SizedBox(height: 10),
                    _isLoading
                        ? Container(
                      width: 410,
                      height: 100,
                      padding: EdgeInsets.only(left: 3),
                      child: Card(
                        color: Colors.blue[50],
                        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white, width: 1),borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Container(child: Center(child : CircularProgressIndicator()),
                        decoration: BoxDecoration(
    
  ),)
                        

                        // color: Colors.blue,
                        
                      ),
                    )
                        : Row(
                          children: [
                            SizedBox(width: 3),
                            Container(
                              width: 405,
                              child: ListTransaction(rewards_first, true)),
                          ],
                        ),
                        SizedBox(height: 15),
                    Text('   Newly Launched @e-Shoppe',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)),
                    SizedBox(height: 10),
                        imageCarousel2
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
