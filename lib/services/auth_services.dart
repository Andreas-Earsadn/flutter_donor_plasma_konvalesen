import 'dart:async';


import 'package:donateplasma/screens/adminscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class AuthController {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  // Stream<User> streamAuthStatus() {
  //   return auth.authStateChanges();
  // }

  static Future<User> signInAnonymous() async {
    try {
      UserCredential result = await FirebaseAuth.instance.signInAnonymously();
      User firebaseUser = result.user;

      return firebaseUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> signOut() async {
    _auth.signOut();
  }



  static Future<User> login (String email, String password) async {
    try {

      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User firebaseUser = result.user;
      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else{
        // Navigator.of(context).pushNamed(AdminScreen.routeName);
      }

    }

  }

  // Stream<User> get firebaseUserStream  =>
  //     _auth.authStateChanges();

  static Stream <User> get firebaseUserStream => _auth.authStateChanges();
}
