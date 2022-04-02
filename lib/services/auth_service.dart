import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  //anonymous signin for guest
  Future<User?>getOrCreateAnoUser() async{
    try{
      if(currentUser == null){
        await _firebaseAuth.signInAnonymously();
      }
      return currentUser;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //user sign in with email and password

  //register with password and email

  //sign out
}