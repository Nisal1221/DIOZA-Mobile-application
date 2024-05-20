
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled2/modles.dart';

class Authservices {
//firebase instance

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create a user from firebase with uid
  UserModle? _userWithFirebaseUserUid(User? user) {
    return user != null ? UserModle(uid: user.uid) : null;
  }

  //creating stream for cheking auth changes in user
  Stream<UserModle?> get user {
    return _auth.authStateChanges().map(_userWithFirebaseUserUid);
  }

//sign in anonymous
  Future signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

//register a new user using email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

//sign in using email
  Future signInUsingEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }


//sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}