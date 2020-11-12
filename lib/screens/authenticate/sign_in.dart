import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:reapp/services/auth.dart';
import 'package:reapp/shared/constants.dart';
import 'package:reapp/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  AuthService _authuser = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Container(
      decoration: BoxDecoration(
              gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.cyanAccent[400],Colors.blue[600]],
        )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GradientAppBar(
          // backgroundColor: Colors.blue,Colors.blue[600]
          backgroundColorStart: Colors.blue[600],
    backgroundColorEnd: Colors.cyan,
          title: Text("Sign In",style: TextStyle(fontFamily: 'OpenSans',)),
          elevation: 0.00,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person, color: Colors.white, size: 30),
              label: Text('Register',style: TextStyle(fontFamily: 'OpenSans',fontSize: 18, color: Colors.white)),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 60.0),
            Text("Welcome to ReApp!", style: TextStyle(fontSize: 30, fontFamily: 'OpenSans', color:Colors.white, fontWeight: FontWeight.bold)),
            
            SizedBox(height: 60.0),
            Text("Sign In", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',color:Colors.white)),
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
                  if(_formkey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _authuser.signInWithEmailAndPassword(email,password);
                    if(result==null){
                      setState(() {
                        loading = false;
                         error = 'Invalid Credentials';
                      });
                    }
                  }
                  else{
                    print("lol1234");
                  }
                },
              ),
            ),],),
            SizedBox(height: 10.0),
            Text(error),
            
          ],
                )
              )
            ),
        )
      ),
    );
  }
}