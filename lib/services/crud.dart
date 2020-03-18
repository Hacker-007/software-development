import 'package:Software_Development/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  // Update
  static Future<void> update(BuildContext context, List<String> parameters) async {
    String email = authService.user['Email Address'];
    authService.setRememberedUser({
      'Full Name': parameters.elementAt(0),
      'Email Address': parameters.elementAt(1),
      'Photo URL': authService.user['Photo URL'],
    });
    return (await Firestore.instance
                           .collection('users')
                           .getDocuments())
                           .documents
                           .firstWhere((snapshot) => snapshot.data.containsValue(email))
                           .reference
                           .updateData({
                             'Full Name': parameters.elementAt(0),
                             'Email Address': parameters.elementAt(1),
                             'Photo URL': authService.user['Photo URL'],
                            });
  }

  static void delete() async {
    String email = authService.user['Email Address'];
    if(isLoggedIn()) {
      await authService.signout();
    }

    return (await Firestore.instance
                     .collection('users')
                     .getDocuments())
                     .documents
                     .firstWhere((snapshot) => snapshot.data.containsValue(email))
                     .reference
                     .delete();
  }
}