
import 'package:donateplasma/components/already_have_an_account_acheck.dart';
import 'package:donateplasma/constants.dart';

import 'package:donateplasma/screens/adminscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

import 'background.dart';
 import'package:donateplasma/services/auth_services.dart';
 import'package:google_fonts/google_fonts.dart';


class Body extends StatelessWidget {//const
   Body({
    Key key,
  }) : super(key: key);

  // final authC = Get.find<AuthController>();
   FirebaseAuth _auth = FirebaseAuth.instance;
   final TextEditingController emailC = TextEditingController();
   final TextEditingController passC = TextEditingController();
   final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
   FocusNode f1 = new FocusNode();
   FocusNode f2 = new FocusNode();
   FocusNode f3 = new FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Form(
        key: _formkey,
        child: Padding(
    padding: const EdgeInsets.only(right: 16, left: 16),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "\nLogin Sebagai Admin ",
              style: TextStyle(fontFamily: 'poppins',fontWeight: FontWeight.w600, fontSize: 20.0, color: Colors.deepPurpleAccent.shade700),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/icons/login.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.07),
            // RoundedInputField(
            //   hintText: "Email",
            //   controller: emailC,
            //   onChanged: (value) {},
            // ),
            // RoundedPasswordField(
            //   controller: passC,
            //   onChanged: (value) {},

            // ),



            TextFormField(
               focusNode: f1,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: emailC,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.purple.shade100,
                hintText: 'Email',
                hintStyle: GoogleFonts.lato(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {


              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter the Email';

                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 25.0,
            ),
            TextFormField(
              focusNode: f2,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.visiblePassword,
              controller: passC,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.purple.shade100,
                hintText: 'Password',
                hintStyle: GoogleFonts.lato(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f2.unfocus();
                FocusScope.of(context).requestFocus(f3);
              },
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value.isEmpty) return 'Please enter the Password';
                return null;
              },
              obscureText: true,
            ),
            ElevatedButton(

             child: Text("LOGIN"),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    showLoaderDialog(context);

                      try {
                        final User user = (await _auth.signInWithEmailAndPassword(
                          email: emailC.text,
                          password: passC.text,
                        ))
                            .user;
                        if (!user.emailVerified) {
                          await user.sendEmailVerification();
                        }
                        // Navigator.of(context).pushNamed(AdminScreen.routeName);
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/AdminScreen', (Route<dynamic> route) => false);
                      } catch (e) {
                        final snackBar = SnackBar(
                          content: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                              Text(" There was a problem signing you in"),
                            ],
                          ),
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                    // _signInWithEmailAndPassword();


                  }
                },

              style: ElevatedButton.styleFrom(
                elevation: 2,
                primary: kPrimaryColor,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),),

            // AlreadyHaveAnAccountCheck(
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return SignUpScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
      )
      ),
    );

  }


   showLoaderDialog(BuildContext context) {
     AlertDialog alert = AlertDialog(
       content: new Row(
           children:[
             CircularProgressIndicator(),
             Container(
                 margin: EdgeInsets.only(left : 15), child: Text ("Loading...")),

           ]
       ),
     );

     showDialog(
         barrierDismissible: false,
         context: context,
         builder: (BuildContext context){
           return alert;
         }
     );
   }



   // @override
   // void dispose() {
   //   emailC.dispose();
   //   passC.dispose();
   //   super.dispose();
   // }


   bool emailValidate(String email) {
     if (RegExp(
         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
         .hasMatch(email)) {
       return true;
     } else {
       return false;
     }
   }

   // void _signInWithEmailAndPassword() async {
   //   try {
   //     final User user = (await _auth.signInWithEmailAndPassword(
   //       email: emailC.text,
   //       password: passC.text,
   //     ))
   //         .user;
   //     if (!user.emailVerified) {
   //       await user.sendEmailVerification();
   //     }
   //     // Navigator.of(context).pushNamed(AdminScreen.routeName);
   //     Navigator.of(context)
   //         .pushNamedAndRemoveUntil('/adminscreen', (Route<dynamic> route) => false);
   //   } catch (e) {
   //     final snackBar = SnackBar(
   //       content: Row(
   //         children: [
   //           Icon(
   //             Icons.info_outline,
   //             color: Colors.white,
   //           ),
   //           Text(" There was a problem signing you in"),
   //         ],
   //       ),
   //     );
   //     Navigator.pop(context);
   //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
   //   }
   // }

   void _pushPage(BuildContext context, Widget page) {
     Navigator.of(context).push(
       MaterialPageRoute<void>(builder: (_) => page),
     );
   }
}


