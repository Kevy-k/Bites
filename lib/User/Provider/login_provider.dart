
import 'package:bites/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier{

 bool _waiting=false;
  bool get waiting=>_waiting;
bool _isError=false;
bool  get isError=>_isError;
String _errorMessage="";
String get error=>_errorMessage;
  void startWaiting(){
    _waiting=true;
    notifyListeners();
  }
  void stopWaiting(){
    _waiting=false;
    notifyListeners();
  }

void throwErrorMessage(){
  _isError=true;
  _errorMessage="Failed to login. Either invalid credential or network error";
  notifyListeners();
}
void clearError(){
   _isError=false;
  _errorMessage="";
  notifyListeners();
}
   Future<void> SignIn(String email,String password,BuildContext context) async {
    startWaiting();
    try {
      UserCredential userCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email,
              password: password,);
      if (userCred.user != null) {
        stopWaiting();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyApp()));
      }
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
      stopWaiting();
      throwErrorMessage();
      
    }
  }
}