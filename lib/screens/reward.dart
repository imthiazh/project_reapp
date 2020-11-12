import 'package:flutter/material.dart';

class Reward extends StatelessWidget {
  static const routeName = '/reward';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Rewards'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('...'),
          ],
        ),
      ),
    );
  }
}
