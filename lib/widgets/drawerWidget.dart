import 'package:donateplasma/constants/color_constants.dart';
import 'package:donateplasma/screens/Covid19Tracker/covid19Tracker.dart';
import 'package:donateplasma/screens/HomeScreen.dart';
import 'package:donateplasma/screens/Welcome/welcome_screen.dart';
import 'package:donateplasma/screens/edit_profile.dart';
import 'package:donateplasma/screens/infoPlasma.dart';
import 'package:donateplasma/screens/story/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xDCFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 180.0,
            color: kPrimaryColor,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 25, 20, 20),
                  child: new Text(
                    'Donor Plasma',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.home,
              color: Colors.deepPurpleAccent.shade100,
            ),
            title: Text('Halaman Utama'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.handHoldingMedical,
              color: Colors.greenAccent,
            ),
            title: Text('Jadi pendonor'),
            onTap: () {
              Navigator.of(context).pushNamed(EditProfile.routeName);
              Fluttertoast.showToast(
                  msg:
                      "Anda memasuki halaman formulir pendonor\n Isi data anda dengan benar.\nTerimakasih",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  fontSize: 16.0,
                  backgroundColor: kPrimaryColor,
                  textColor: Colors.white);
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.history,
              color: Colors.pinkAccent.shade400,
            ),
            title: Text('Yuk bagikan ceritamu'),
            onTap: () {
              Navigator.of(context).pushNamed(StoryScreen.routeName);
              Fluttertoast.showToast(
                  msg:
                  "Yuk bagikan ceritamu disini\nCerita yang anda bagikan pasti bermanfaat kok",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  fontSize: 16.0,
                  backgroundColor: kPrimaryColor,
                  textColor: Colors.white);
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.userNurse,
              color: Colors.black87,
            ),
            title: Text('Login sebagai admin'),
            onTap: () {
              Navigator.of(context).pushNamed(WelcomeScreen.routeName);
              Fluttertoast.showToast(
                  msg:
                  "Anda memasuki halaman login admin\n Pastikan bahwa anda telah memiliki akses pada laman ini",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  fontSize: 16.0,
                  backgroundColor: kPrimaryColor,
                  textColor: Colors.white);
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.virus,
              color: Colors.teal,
            ),
            title: Text('Covid-19 Tracker'),
            onTap: () {
              Navigator.of(context).pushNamed(CovidTracker.routeName);
              Fluttertoast.showToast(
                  msg:
                  "Pantau perkembangan kasus COVID-19 secara global maupun nasional",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  fontSize: 16.0,
                  backgroundColor: kPrimaryColor,
                  textColor: Colors.white);
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.questionCircle,
              color: Colors.orangeAccent,
            ),
            title: Text('FAQ'),
            onTap: () {
              Navigator.of(context).pushNamed(InfoPlasma.routeName);
              Fluttertoast.showToast(
                  msg:
                  "Anda memasuki halaman FAQ\n Anda dapat melihat informasi dan pertanyaan yang sering diajukan disini.\nTerimakasih",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  fontSize: 16.0,
                  backgroundColor: kPrimaryColor,
                  textColor: Colors.white);
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.bookReader,
              color: Colors.lightBlueAccent,
            ),
            title: Text('Tentang Kami'),
            onTap: () {
              Navigator.of(context).pushNamed('StoryScreen.routeName');
            },
          ),
        ],
      ),
    );
  }
}
