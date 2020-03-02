import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:software_development/services/crud.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Observable<FirebaseUser> user;
  Observable<Map<String, dynamic>> profile;


  AuthService() {
    this.user = Observable(this._auth.onAuthStateChanged);

    this.profile = this.user.switchMap((FirebaseUser u) {
      if(u != null) {
        return this._db.collection('users')
                       .document(u.uid)
                       .snapshots()
                       .map((snap) => snap.data);
      } else {
        return Observable.just({ });
      }
    });

    this._db.settings(timestampsInSnapshotsEnabled: true);
  }

  Future<FirebaseUser> googleSignIn() async {
    GoogleSignInAccount googleUser = await this._googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    try {  
      FirebaseUser user = await this._auth.signInWithGoogle(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      
      updateUserData(user);
      print('Signed In ${user.displayName}.');
      return user;
    } catch(e) {
      print('Error Occurred: $e.');
      return null;
    }
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = this._db.collection('users')
                                .document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now(),
    }, merge: true);
  }

  Future<FirebaseUser> registerWithEmailAndPassword(List<String> fields) async {
    try {
      print('Trying To Save User With Email ${fields.elementAt(1)} And Password ${fields.elementAt(2)}.');
      FirebaseUser user = await this._auth.createUserWithEmailAndPassword(email: fields.elementAt(1), password: fields.elementAt(2));
      await CrudOperations.create({
        'Full Name': fields.elementAt(0),
        'Email Address': user.email,
      });

      return user;
    } catch(e) {
      print('Error Occurred: $e');
      return null;
    }
  }

  void signout() {
    this._auth.signOut();
  }
}

final AuthService authService = AuthService();