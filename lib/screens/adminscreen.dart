// import 'dart:html';
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:donateplasma/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:donateplasma/modules/city_model.dart';
import 'package:donateplasma/modules/province_model.dart';
import 'package:donateplasma/widgets/item_card_admin.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donateplasma/animation/FadeAnimation.dart';
import 'package:donateplasma/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class AdminScreen extends StatefulWidget {
  static const routeName = '/AdminScreen';

  @override
  AdminScreenState createState() => AdminScreenState();
}

class AdminScreenState extends State<AdminScreen> {
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

    // _searchController.addListener(_onSearchChanged);

    //fcm
  }
//plan admin bisa menambahkan data
  final goldar = ['A ', 'A-', 'B ', 'O', 'A+', 'B+', 'O-', 'O+', 'AB', 'AB+', 'AB-','Rh+','Rh-'];
  String dropdownValue;
  var dropdownProvinceValue;
  var dropdownCityValue;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bloodController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    //koneksi ke firebase
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference donors = firestore.collection('Donors1');
    CollectionReference donorsSelection = firestore.collection('Donors');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Admin Donor Plasma'),
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.menu_rounded,
          //     size: 40,
          //     color: kBannerBasicColor,
          //   ),
          //   onPressed: () => _scaffoldKey.currentState.openDrawer(),
          // ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "ANDA AKAN LOGOUT",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.redAccent,
                          ),
                        ),
                        content: Text(
                          "Anda Yakin Ingin Meninggalkan Halaman Ini? ?",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.black87),
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("TIDAK",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.redAccent,
                                )),
                          ),
                          FlatButton(
                            onPressed: () async {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (Route<dynamic> route) => false);
                              await AuthController.signOut();
                            },
                            child: Text("IYA",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.redAccent,
                                )),
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(
                Icons.logout,
                size: 25,
                color: kBannerBasicColor,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              children: [
                //// VIEW DATA HERE
                StreamBuilder(
                 stream: donors.orderBy('goldar', descending: true).snapshots(),
                  // stream: donors.snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data.docs
                            .map<Widget>((e) => ItemCard(
                                  e.data()['nama'],
                                  e.data()['usia'],
                                  e.data()['no hp'],
                                  e.data()['provinsi'],
                                  e.data()['kota'],
                                  e.data()['alamat'],
                                  e.data()['goldar'].toString(), onUpdate: ()
                        {
                          String status = 'available';

                          donorsSelection.add({
                            //ADD DATA HERE
                            'nama':  e.data()['nama'],
                            'usia' :  e.data()['usia'],
                            'goldar': e.data()['goldar'],
                            'no hp':  e.data()['no hp'],
                            'provinsi': e.data()['provinsi'],
                            'kota':  e.data()['kota'],
                            'alamat': e.data()['alamat'],
                            'deskripsi' :e.data()['deskripsi'],
                            'status'  : status,
                            // 'status' : e.data()['status'],
                          });
                          donors.doc(e.id).delete();
                          Fluttertoast.showToast(
                              msg:
                              "Data berhasil kami kirim ke halaman informasi",
                              toastLength:
                              Toast.LENGTH_LONG,
                              gravity:
                              ToastGravity.CENTER,
                              fontSize: 16.0,
                              backgroundColor:
                              Colors.green,
                              textColor: Colors.white);


                        },
                          onDelete: (){ donors.doc(e.id).delete();
                          Fluttertoast.showToast(
                              msg:
                              "Data berhasil dihapus",
                              toastLength:
                              Toast.LENGTH_LONG,
                              gravity:
                              ToastGravity.CENTER,
                              fontSize: 16.0,
                              backgroundColor:
                              Colors.redAccent,
                              textColor: Colors.white);
                          },
                                ))
                            .toList(),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 0,
                )
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(-5, 0),
                        blurRadius: 15,
                        spreadRadius: 3)
                  ]),
                  width: double.infinity,
                  height: 0,
                  child: Row(
                      // children: [
                      //   SizedBox(
                      //     width: MediaQuery.of(context).size.width - 160,
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         TextField(
                      //           keyboardType: TextInputType.text,
                      //           controller: nameController,
                      //           decoration: InputDecoration(
                      //             border: InputBorder.none,
                      //             hintText: "Nama",
                      //             hintStyle: TextStyle(
                      //               color: Colors.grey[400],
                      //               fontFamily: 'Poppins',
                      //             ),
                      //           ),
                      //         ),
                      //         DropdownButton<String>(
                      //           hint: Text('Golongan Darah'),
                      //           value: dropdownValue,
                      //           icon: Icon(Icons.arrow_drop_down,
                      //               color: Colors.deepPurpleAccent),
                      //           isExpanded: true,
                      //           items: goldar.map(buildMenuItem).toList(),
                      //           onChanged: (String newValue) {
                      //             setState(() {
                      //               dropdownValue = newValue;
                      //             });
                      //           },
                      //         ),
                      //         TextField(
                      //           keyboardType: TextInputType.number,
                      //           controller: phoneController,
                      //           decoration: InputDecoration(
                      //             border: InputBorder.none,
                      //             hintText: "Nomor Handphone",
                      //             hintStyle: TextStyle(
                      //               color: Colors.grey[400],
                      //               fontFamily: 'Poppins',
                      //             ),
                      //           ),
                      //         ),
                      //         Container(
                      //           child: DropdownSearch<Province>(
                      //             label: "Provinsi",
                      //             // showSelectedItems: true,
                      //             hint: 'Pilih provinsi anda',
                      //             showClearButton: true,
                      //             onFind: (String filter) async {
                      //               Uri url = Uri.parse(
                      //                   "https://api.rajaongkir.com/starter/province");
                      //               // Uri urlc = Uri.parse("https://api.rajaongkir.com/starter/city");
                      //
                      //               try {
                      //                 final response = await http.get(
                      //                   url,
                      //                   headers: {
                      //                     "key":
                      //                         "6cfef77420547f9bf2f093096cbe160d",
                      //                   },
                      //                 );
                      //
                      //                 var data = json.decode(response.body)
                      //                     as Map<String, dynamic>;
                      //
                      //                 var statusCode =
                      //                     data["rajaongkir"]["status"]["code"];
                      //
                      //                 if (statusCode != 200) {
                      //                   throw data["rajaongkir"]["status"]
                      //                       ["description"];
                      //                 }
                      //
                      //                 var listAllProvince = data["rajaongkir"]
                      //                     ["results"] as List<dynamic>;
                      //
                      //                 var models =
                      //                     Province.fromJsonList(listAllProvince);
                      //                 return models;
                      //               } catch (err) {
                      //                 print(err);
                      //                 return List<Province>.empty();
                      //               }
                      //             },
                      //             selectedItem: dropdownProvinceValue,
                      //             onChanged: (prov) {
                      //               if (prov != null) {
                      //                 print(prov.province);
                      //               } else {
                      //                 print("Tidak memilih provinsi manapun");
                      //               }
                      //             },
                      //             showSearchBox: true,
                      //             dropdownSearchDecoration: InputDecoration(
                      //                 contentPadding: EdgeInsets.symmetric(
                      //               vertical: 10,
                      //               horizontal: 10,
                      //             )),
                      //             popupItemBuilder: (context, item, isSelected) {
                      //               return Container(
                      //                 padding: EdgeInsets.all(8.0),
                      //                 decoration: BoxDecoration(
                      //                   border: Border(
                      //                     bottom: BorderSide(
                      //                       color: Color(0xFF8211D2)
                      //                           .withOpacity(.10),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 child: Text("${item.province}"),
                      //               );
                      //             },
                      //           ),
                      //         ),
                      //         Container(
                      //           child: DropdownSearch<City>(
                      //             showClearButton: true,
                      //             label: "Kota",
                      //             hint: 'Pilih kota tinggal anda sekarang',
                      //             onFind: (String filter) async {
                      //               Uri url = Uri.parse(
                      //                   "https://api.rajaongkir.com/starter/city");
                      //               // Uri urlc = Uri.parse("https://api.rajaongkir.com/starter/city");
                      //
                      //               try {
                      //                 final response = await http.get(
                      //                   url,
                      //                   headers: {
                      //                     "key":
                      //                         "6cfef77420547f9bf2f093096cbe160d",
                      //                   },
                      //                 );
                      //
                      //                 var data = json.decode(response.body)
                      //                     as Map<String, dynamic>;
                      //
                      //                 var statusCode =
                      //                     data["rajaongkir"]["status"]["code"];
                      //
                      //                 if (statusCode != 200) {
                      //                   throw data["rajaongkir"]["status"]
                      //                       ["description"];
                      //                 }
                      //
                      //                 var listAllCity = data["rajaongkir"]
                      //                     ["results"] as List<dynamic>;
                      //
                      //                 var models = City.fromJsonList(listAllCity);
                      //                 return models;
                      //               } catch (err) {
                      //                 print(err);
                      //                 return List<City>.empty();
                      //               }
                      //             },
                      //             onChanged: (value) => print(value.province),
                      //             selectedItem: dropdownCityValue,
                      //             popupItemBuilder: (context, item, isSelected) {
                      //               return Container(
                      //                 padding: EdgeInsets.all(8.0),
                      //                 decoration: BoxDecoration(
                      //                   border: Border(
                      //                     bottom: BorderSide(
                      //                       color: Color(0xFF8211D2)
                      //                           .withOpacity(.10),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 child: Text("${item.cityName}"),
                      //               );
                      //             },
                      //             itemAsString: (item) => item.cityName,
                      //           ),
                      //         ),
                      //         TextField(
                      //           keyboardType: TextInputType.number,
                      //           controller: addressController,
                      //           decoration: InputDecoration(
                      //             border: InputBorder.none,
                      //             hintText: "alamat",
                      //             hintStyle: TextStyle(
                      //               color: Colors.grey[400],
                      //               fontFamily: 'Poppins',
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      //   Container(
                      //     height: 180,
                      //     width: 130,
                      //     padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                      //     child: RaisedButton(
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(8)),
                      //         color: kPrimaryColor,
                      //         child: Text(
                      //           'ADD\nDATA',
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold,
                      //             fontFamily: 'Poppins',
                      //           ),
                      //         ),
                      //         onPressed: () {
                      //           //// ADD DATA HERE
                      //         }),
                      //   )
                      // ],
                      ),
                )),
          ],
        ));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
