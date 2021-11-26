// import 'dart:html';
import 'package:donateplasma/models/cardModel.dart';
import 'package:donateplasma/screens/search.dart';
import 'package:donateplasma/widgets/carouselSlider.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:donateplasma/widgets/notificationList.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:donateplasma/constants/color_constants.dart';
import 'package:donateplasma/widgets/drawerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../main.dart';
import 'ExploreList.dart';
import 'donorList.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _donorName = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _donorName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final information = Provider.of<Information>(context).infoList;
    String _message;
    DateTime now = DateTime.now();
    String _currentHour = DateFormat('kk').format(now);
    int hour = int.parse(_currentHour);

    setState(
      () {
        if (hour >= 5 && hour < 11) {
          _message = 'Selamat Pagi  ';
        }
       else if (hour >= 11 && hour < 15) {
          _message = 'Selamat Siang   ';
        }
       else  if (hour >= 15 && hour < 18) {
          _message = 'Selamat Sore   ';
        }
        else {
          _message = 'Selamat Malam  ';
        }
      },
    );
    //fcm and search
    @override
    void initstate() {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        if (notification != null && android != null && !kIsWeb) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  // channel.description,
                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in example app.
                  icon: 'launch_background',
                ),
              ));
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('Ayo donorkan plasma anda melalui aplikasi kami :)');
      });

      super.initState();
      _donorName = new TextEditingController();
    }

    // _searchController.addListener(_onSearchChanged);

    //fcm
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bgHI.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[Container()],
          backgroundColor: kPrimaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.menu_rounded,
              size: 40,
              color: kBannerBasicColor,
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          title: Container(
            padding: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  //width: MediaQuery.of(context).size.width/1.3,
                  alignment: Alignment.center,
                  child: Text(
                    _message,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  width: 55,
                ),
                IconButton(
                  splashRadius: 20,
                  icon: Icon(Icons.notifications_active_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => NotificationList()));
                  },
                ),
              ],
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: SafeArea(
            child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return;
          },
          child: Column(children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20, bottom: 10),
                          child: Text(
                            "Halo  ",
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          // decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //         image: AssetImage('assets/images/bgHI.png'),
                          //         fit: BoxFit.cover)),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20, bottom: 25),
                          child: Text(
                            "Yuk Cari Pendonor \nKami",
                            style: GoogleFonts.lato(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 25),
                          child: TextFormField(
                            textInputAction: TextInputAction.search,
                            controller: _donorName,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 20, top: 10, bottom: 10),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Cari Pendonor Berdasarkan Kota',
                              hintStyle: GoogleFonts.lato(
                                color: Colors.black26,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                              suffixIcon: Container(
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: IconButton(
                                  iconSize: 20,
                                  splashRadius: 20,
                                  color: Colors.white,
                                  icon: Icon(FlutterIcons.search1_ant),
                                  //tombol cari
                                  onPressed: () {
                                    String value;
                                    setState(
                                          () {
                                        value.length == 0
                                            ? Container()
                                            : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SearchList(
                                              searchKey: value,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },

                                ),
                              ),
                            ),
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                            onFieldSubmitted: (String value) {
                              setState(
                                () {
                                  value.length == 0
                                      ? Container()
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SearchList(
                                              searchKey: value,
                                            ),
                                          ),
                                        );
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 23, bottom: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Kami peduli dengan anda",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                color: Colors.pink.shade300,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 200.0,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Carouselslider(),

                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Stok Plasma",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                color: Colors.pink[300],
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          height: 150,
                          padding: EdgeInsets.only(top: 14),
                          child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            itemCount: cards.length,
                            itemBuilder: (context, index) {
                              //print("images path: ${cards[index].cardImage.toString()}");
                              return Container(
                                margin: EdgeInsets.only(right: 14),
                                height: 150,
                                width: 140,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(cards[index].cardBackground),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[400],
                                        blurRadius: 4.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(3, 3),
                                      ),
                                    ]
                                    ),
                                // ignore: deprecated_member_use
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ExploreList(
                                                bloodType:
                                                    cards[index].bloodType,
                                              )),
                                    );
                                  },
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 29,
                                            child: Icon(
                                              cards[index].cardIcon,
                                              size: 26,
                                              color: Color(
                                                  cards[index].cardBackground),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          cards[index].bloodType,
                                          style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Pendonor Kami",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                color: Colors.pink[300],
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: donorList(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        )),
      ),
    );
  }
}


