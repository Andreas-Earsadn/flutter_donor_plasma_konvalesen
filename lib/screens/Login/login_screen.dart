// import 'dart:html';

import 'package:donateplasma/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/body.dart';



class LoginScreen extends StatelessWidget {
   static const routeName = '/admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Body(),
    );
  }


}