import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentification {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<dynamic> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return authResult.user;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return authResult.user;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  User getCurrUser() {
    return _firebaseAuth.currentUser;
  }
}
