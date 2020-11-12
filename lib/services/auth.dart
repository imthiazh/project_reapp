import 'package:firebase_auth/firebase_auth.dart';
import 'package:reapp/models/user.dart';
import 'package:reapp/services/database.dart';

class AuthService {
  	FirebaseAuth _auth = FirebaseAuth.instance;

    BasicUser _basicUserFromFirebaseUser (FirebaseUser user){
      return user!=null ? BasicUser(uid: user.uid) : null;
    }

    Stream<BasicUser> get user_stream{
      return _auth.onAuthStateChanged.map(_basicUserFromFirebaseUser);
    }
    // Stream<BasicUser> get user{
    //   return _auth.onAuthStateChanged.map((item)=>_basicUserFromFirebaseUser(item));
    // }

    Future signInAnon() async {

	    try{
   			AuthResult result =  await _auth.signInAnonymously();
        print("Signing in now");
    		FirebaseUser fb_user = result.user;
    		return _basicUserFromFirebaseUser(fb_user);
    	}
    	catch(e){
			  print(e.toString());
        return null;
    	}
    }

    Future signOut() async {
      try{
        return await _auth.signOut();
      }
      catch(e){
			  print(e.toString());
        return null;
    	}
    }

    Future signInWithEmailAndPassword(String email,String password) async {
      try{
        AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        FirebaseUser fb_user = result.user;
        //await DatabaseService(uid: fb_user.uid).updateUserData("New Name", "sugars number", 100);
        return _basicUserFromFirebaseUser(fb_user);
        // return fb_user;
      }catch(e){
        print(e.toString());
      }
    }

      // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _basicUserFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }
}