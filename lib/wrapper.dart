

import 'package:donateplasma/screens/Login/login_screen.dart';
import 'package:donateplasma/screens/adminscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    User firebaseUser = Provider.of<User>(context);
    
    return (firebaseUser == null) ? LoginScreen() :AdminScreen();
  }
  
  
}