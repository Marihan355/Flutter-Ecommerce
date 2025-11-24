import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance; //a singleton. there is only one instance/object of firebaseAuth in my repo. like a single door everone uses to get inside, rather than creating a new door ever time

//login
  Future<User?> login(String email, String password) async { //input: email and password
    final result = await _auth.signInWithEmailAndPassword( //calls Firebases's signInWithEmailAndPassword
        email: email, password: password); //return the logged in user object
    return result.user;
  }

//register
  Future<User?> register(String email, String password) async { 
    final result = await _auth.createUserWithEmailAndPassword( //creates user
        email: email, password: password);
    return result.user;
  }

//logout
  Future<void> logout() async { //no return value
    await _auth.signOut();
  }

//get the current logged in user
  User? currentUser() => _auth.currentUser; 
}