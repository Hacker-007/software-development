import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:Software_Development/services/crud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore db = Firestore.instance;
  Map<String, dynamic> user;

  Future<FirebaseUser> signinWithGoogle(BuildContext context) async {
    GoogleSignInAccount googleUser = await this.googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential authCredential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    FirebaseUser user = (await this.auth.signInWithCredential(authCredential)).user;
      
    _updateUserData(user);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this.user = _convertFirebaseUserToMap(user);
    preferences.setString('User Details', jsonEncode(this.user));
    return user;
  }

  Future<FirebaseUser> signinWithEmailAndPassword(BuildContext context, [List<String> fields]) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    FirebaseUser user = (await this.auth.signInWithEmailAndPassword(email: fields.elementAt(0), password: fields.elementAt(1))).user;
    this.user = _convertFirebaseUserToMap(user);
    preferences.setString('User Details', jsonEncode(this.user));
    return user;
  }

  Future<FirebaseUser> signupWithEmailAndPassword(BuildContext context, [List<String> fields]) async {
    print('Trying To Save User With Email ${fields.elementAt(1)} And Password ${fields.elementAt(2)}.');
    FirebaseUser user = (await this.auth.createUserWithEmailAndPassword(email: fields.elementAt(1), password: fields.elementAt(2))).user;
    this.user = {
      'Full Name': fields.elementAt(0),
      'Email Address': user.email,
      'Photo URL': '',
    };

    await CrudOperations.create(this.user);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('User Details', jsonEncode(this.user));
    return user;
  }

  Future<void> signout() async {
    this.user = {};
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('User Details');
    return await this.auth.signOut();
  }

  Future<Map<String, dynamic>> getRememberedUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (this.user = jsonDecode(preferences.getString('User Details') ?? '{}'));
  }

  Future<bool> setRememberedUser(Map<String, dynamic> userDetails) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this.user = userDetails;
    return preferences.setString('User Details', jsonEncode(userDetails));
  }

  void _updateUserData(FirebaseUser user) async {
    DocumentReference ref = this.db.collection('users')
                                .document(user.uid);

    this.user = {
      'Full Name': user.displayName,
      'Email Address': user.email,
      'Photo URL': user.photoUrl,
    };

    return ref.setData(this.user, merge: true);
  }

  Map<String, dynamic> _convertFirebaseUserToMap(FirebaseUser user) {
    UserInfo userInfo = user.providerData.elementAt(0);
    Map<String, dynamic> map = {};
    map.putIfAbsent('Full Name', () => userInfo.displayName);
    map.putIfAbsent('Email Address', () => userInfo.email);
    map.putIfAbsent('Photo URL', () => userInfo.photoUrl);
    return map;
  }
}

final AuthService authService = AuthService();