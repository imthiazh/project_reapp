import 'package:flutter/material.dart';

class LocationActivity extends StatelessWidget {
  static const routeName = '/locationactivity';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Activity:'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Location Activity:'),
          ],
        ),
      ),
    );
  }
}
