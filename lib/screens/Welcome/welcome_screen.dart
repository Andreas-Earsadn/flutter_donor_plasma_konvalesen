import 'package:donateplasma/models/User.dart';
import 'package:donateplasma/screens/Login/login_screen.dart';
import 'package:donateplasma/services/auth_services.dart';
import 'package:donateplasma/utils/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';
// import 'package:flutter_auth/Screens/Welcome/components/body.dart';

// void main() => runApp(WelcomeScreen());
class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Body(),
    );
  }
}
