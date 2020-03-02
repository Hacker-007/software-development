import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrudOperations {

  static bool isLoggedIn() {
    if(FirebaseAuth.instance.currentUser() != null) {
      return true;
    }

    return false;
  }

  static Future<void> create(Map<String, dynamic> userData) async {
    if(isLoggedIn()) {
      Firestore.instance
               .collection('users')
               .add(userData)
               .catchError((e) => print(e));
      print('Saved User.');
    } else {
      print('User Not Logged In.');
    }
  }

  static Future<QuerySnapshot> read() async {
     return Firestore.instance
                     .collection('users')
                     .getDocuments();
  }
}