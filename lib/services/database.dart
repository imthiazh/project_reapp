import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
 
  final String uid;
  DatabaseService({ this.uid });
  
  final CollectionReference user_data = Firestore.instance.collection("user_data");

  Future updateUserData(String name, String sugars, int strength) async {
    return await user_data.document(uid).setData({
      "Name" : name,
      "Sugars": sugars,
      "Strength": strength
    });
  }

  // Map<String, dynamic> get user_data_stream{
  //   return getUserData();
  // }

  Stream<QuerySnapshot> get user_data_stream{
    return user_data.snapshots();
  }

  Future<DocumentSnapshot> getUserData() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot value = await user_data.document(firebaseUser.uid).get();
    return value;
  }
}

