import 'package:donateplasma/models/User.dart';
import 'package:donateplasma/screens/Login/login_screen.dart';
import 'package:donateplasma/screens/Welcome/welcome_screen.dart';
import 'package:donateplasma/screens/adminscreen.dart';
import 'package:donateplasma/services/auth_services.dart';
import 'package:donateplasma/utils/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../wrapper.dart';

// import 'package:flutter_auth/Screens/Welcome/components/body.dart';

void main() => runApp(MainAdmin());
class MainAdmin extends StatelessWidget {
  static const routeName = '/main_admin';
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(value: AuthController.firebaseUserStream,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
      initialRoute: '/',
      routes: {
        WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
        MainAdmin.routeName: (ctx) => MainAdmin(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
         AdminScreen.routeName: (ctx) => AdminScreen()
      },

    ),
    );

  }
}
