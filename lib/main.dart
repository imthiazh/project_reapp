import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reapp/anti_chew_shop/screens/orders_screen.dart';
import 'package:reapp/screens/health_routine.dart';
import 'package:reapp/screens/home/home.dart';
import 'package:reapp/screens/location_activity.dart';
import 'package:reapp/screens/myProgress.dart';
import 'package:reapp/screens/my_rewards.dart';
import 'package:reapp/screens/wrapper.dart';
import 'package:reapp/services/auth.dart';
import 'package:flutter/rendering.dart';
import 'package:reapp/screens/anti_alcohol_chew.dart';
import 'package:reapp/screens/call_center.dart';
import 'package:reapp/screens/reward.dart';
import 'package:reapp/screens/update_stats.dart';
import 'package:reapp/widgets/main_drawer.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _messaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _messaging.getToken().then((token) {
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<BasicUser>.value(
      value: AuthService().user_stream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: {
          '/home': (ctx) => Home(),
          UpdateStats.routeName: (ctx) => UpdateStats(),
          MyRewards.routeName: (ctx) => MyRewards(), //routes for navigation
          CallCenter.routeName: (ctx) => CallCenter(),
          HealthRoutine.routeName: (ctx) => HealthRoutine(),
          LocationActivity.routeName: (ctx) => LocationActivity(),
          MyProgress.routeName: (ctx) => MyProgress(),
          Reward.routeName: (ctx) => Reward(),
          AntiAlcoholics.routeName: (ctx) => AntiAlcoholics(),
          //OrdersScreen.routeName: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
