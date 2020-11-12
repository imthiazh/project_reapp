import 'package:flutter/material.dart';
import 'chartsDisplay.dart';


class MyProgress extends StatelessWidget {
  static const routeName = '/myprogress';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Animated Charts App',
      theme: ThemeData(
        primaryColor: Color(0xffff6101),
      ),
      home: ChartsDisplay(),
    );
  }
}
