import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class HealthRoutine extends StatelessWidget {
  static const routeName = '/healthroutine';
  List<String> str = ["Sample1","Sample2","Sample3"];


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
          title: Text('Health Routine'), 
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30.0),
                        Text("    Live healthy!", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)),
                        SizedBox(height: 30.0),
                      //   Column( children:
                      //   str.map((tx){
                      //     Container(
                      //     width: 410,
                      // height: 80,
                      // padding: EdgeInsets.only(left: 3),
                      // margin: EdgeInsets.only(left: 10),
                      //     child: Card(
                      //       color: Colors.blue[50],
                            
                      //     shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white, width: 1),borderRadius: BorderRadius.all(Radius.circular(15))),
                      //       child: Container(padding: EdgeInsets.all(10),child: Text("1. Sample text", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.blue))),
                      //     ),
                      //   );
                      //   }).toList()
                      //   )
            ],
          ),
        ),
      ),
    );
  }
}
