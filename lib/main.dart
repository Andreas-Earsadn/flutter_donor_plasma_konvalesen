import 'dart:io';

import 'package:donateplasma/models/User.dart';
import 'package:donateplasma/providers/information.dart';
import 'package:donateplasma/providers/users.dart';
import 'package:donateplasma/screens/BannerScreen.dart';
import 'package:donateplasma/screens/Covid19Tracker/covid19Tracker.dart';
import 'package:donateplasma/screens/HomeScreen.dart';
import 'package:donateplasma/screens/Welcome/welcome_screen.dart';
import 'package:donateplasma/screens/adminscreen.dart';
import 'package:donateplasma/screens/edit_profile.dart';
import 'package:donateplasma/screens/infoPlasma.dart';
import 'package:donateplasma/screens/story/story_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:donateplasma/constants/color_constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'main_admin.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel channel;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await untuk tipe future
  await Firebase.initializeApp();

  HttpOverrides.global = MyHttpOverrides();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      // 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Information(),
        ),
        // ChangeNotifierProvider(
        //   create: (ctx) => Users(),
        // )
      ],
      child: MaterialApp(
        title: 'Donor Plasma',
        theme:
            ThemeData(primaryColor: kPrimaryColor, accentColor: kAccentColor),
        home: BannerScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          BannerScreen.routeName: (ctx) => BannerScreen(),
          EditProfile.routeName: (ctx) => EditProfile(),
          StoryScreen.routeName: (ctx) => StoryScreen(),
          InfoPlasma.routeName: (ctx) => InfoPlasma(),
          //rute ke halaman admin
          WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
         // MainAdmin.routeName: (ctx) => MainAdmin(),
          AdminScreen.routeName: (ctx) => AdminScreen(),
          CovidTracker.routeName: (ctx) => CovidTracker()
        },
      ),
    );
  }
}

//http overrides

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
