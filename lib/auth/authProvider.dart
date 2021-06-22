import 'package:firebase_auth/firebase_auth.dart';
import 'package:space_app/database/favoritesDatabase.dart';
import 'package:space_app/model/userData.dart';

class AuthProvider {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<UserData> get user {
    return _firebaseAuth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  UserData _userFromFirebaseUser(User user) {
    return user != null ? UserData(user.uid, user.email) : null;
  }

  signInWithEmailAndPassword({String email, String password}) async {
    UserCredential authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    User user = authResult.user;
    return UserData(user.uid, user.email);
  }

  createUserWithEmailAndPassword({String email, String password}) async {
    UserCredential authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = authResult.user;
    print('User ${user.email} created!');
    return UserData(user.uid, user.email);
  }

  signOut() async {
    await _firebaseAuth.signOut();
    FavoriteDatabase.favoritesIDs = [];
  }
}
