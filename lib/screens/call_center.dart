import 'package:flutter/material.dart';

class CallCenter extends StatelessWidget {
  static const routeName = '/call';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Service'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Contact Numbers:'),
          ],
        ),
      ),
    );
  }
}
