import 'package:firebase_auth/firebase_auth.dart';
import 'package:space_app/model/userData.dart';

class AuthProvider {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<UserData> get user {
    return _firebaseAuth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  UserData _userFromFirebaseUser(User user) {
    return user != null ? UserData(user.uid) : null;
  }

  Future<UserData> signInAnonimo() async {
    UserCredential authResult = await _firebaseAuth.signInAnonymously();
    User user = authResult.user;
    return UserData(user.uid);
  }

  signInWithEmailAndPassword({String email, String password}) async {
    UserCredential authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    User user = authResult.user;
    return UserData(user.uid);
  }

  createUserWithEmailAndPassword({String email, String password}) async {
    UserCredential authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = authResult.user;
    return UserData(user.uid);
  }

  signOut() async {
    await _firebaseAuth.signOut();
  }
}
