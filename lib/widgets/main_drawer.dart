import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reapp/screens/anti_alcohol_chew.dart';
import 'package:reapp/screens/call_center.dart';
import 'package:reapp/screens/health_routine.dart';
import 'package:reapp/screens/location_activity.dart';
import 'package:reapp/screens/myProgress.dart';
import 'package:reapp/screens/my_rewards.dart';
import 'package:reapp/screens/reward.dart';
import 'package:reapp/screens/update_stats.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../anti_chew_shop/screens/orders_screen.dart';

class MainDrawer extends StatefulWidget {
  // MainDrawer(this.username_val,this.email_val);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String email_val;
  String username_val;

  Future<void> getResponse() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user_i = await auth.currentUser();
    String uid2 = user_i.uid;
    // String uid2 = uid;
    print("UID is:" + uid2);
    print("hello");
    String url =
        "https://reapp-4a214.firebaseio.com/userdata/" + uid2 + ".json";
    // const url = "https://reapp-4a214.firebaseio.com/products.json";
    // onError2(){
    //   return;
    // };
    dynamic rs = await http.get(url);

    print(json.decode(rs.body));
    json_rs = json.decode(rs.body) as Map<String, dynamic>;
    json_rs.forEach((prodId, prodData) {
      email_val = prodData['email'];
      username_val = prodData['username'];
    });
    // List<Transaction> rewards_collected=[];
    // json_rs.forEach((prodId, prodData) {
    //   print("Data is"+prodData['reward_title']+prodData['reward_cost'].toString());
    //   rewards_collected.add(Transaction(
    //     id: prodId,
    //     title: prodData['reward_title'],
    //     amount: prodData['reward_cost'],
    //     date: DateTime.parse(prodData['timestamp']),
    //     progress: 0.00
    //   ));
    // });
    // transactions = rewards_collected;
    // print("Added Amount is:" + transactions[0].amount.toString());
  }

  var _isLoading = false;
  dynamic json_rs;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    getResponse().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 24,
          // fontWeight: FontWeight.bold,
          color: Colors.white,
          // fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // color: Colors.blue[200],
        decoration: BoxDecoration(
              gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.blue[400],Colors.blue[400]],
        )),
        child: ListView(
          children: <Widget>[
            /*Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).accentColor,
              child: Text(
                'Cooking Up!',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Theme.of(context).primaryColor),
              ),
            ),*/
            SizedBox(
              height: 20,
            ),
            _isLoading
                ? Center(child: CircularProgressIndicator(
                  
                ))
                : Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.account_circle,
                          size: 50.0,
                          color: Colors.white,
                          // color: Colors.blue[900],
                          // color: Colors.grey[700],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello $username_val!",
                                style: TextStyle(fontSize: 20,fontFamily: 'OpenSans', color: Colors.white, fontWeight: FontWeight.bold,)
                              ),
                              Text(email_val, style: TextStyle(fontSize: 13,fontFamily: 'OpenSans', color: Colors.white, fontWeight: FontWeight.bold,)),
                            ])
                      ],
                    ),
                    SizedBox(height: 10),
            Padding(
padding:EdgeInsets.symmetric(horizontal:5.0),
child:Container(
height:1.0,
width:50.0,
color: Colors.white),),
            SizedBox(
              height: 40,
            ),
            // Text(widget.email_val),

            buildListTile('My Rewards', Icons.card_giftcard, () {
              Navigator.of(context).pushNamed(MyRewards.routeName);
            }),
            buildListTile('My Notes', Icons.work, () {
              Navigator.of(context).pushNamed(UpdateStats.routeName);
            }),
            buildListTile('My Health Routine', Icons.favorite, () {
              Navigator.of(context).pushNamed(HealthRoutine.routeName);
            }),
            buildListTile(
                'My Progress', Icons.addchart_outlined ,() {
              Navigator.of(context).pushNamed(MyProgress.routeName);
            }),

            buildListTile('Location Activity',
                Icons.add_location, () {
              Navigator.of(context).pushNamed(LocationActivity.routeName);
            }),

            buildListTile('e-Shoppe', Icons.add_shopping_cart_rounded , () {
              Navigator.of(context).pushNamed(AntiAlcoholics.routeName);
            }),
            /* buildListTile('Orders', Icons.fastfood, () {
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            }),*/
          ],
        ),
      ),
    );
  }
}
