
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donateplasma/constants.dart';
import 'package:donateplasma/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatefulWidget {
  static const routeName = '/aboutus';

  @override
  _AboutUsScreen createState() => _AboutUsScreen();
}

class _AboutUsScreen extends State <AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
              stream:FirebaseFirestore.instance
                  .collection('AboutUs')
                  .orderBy('appName')
                  .snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowGlow();
                    return;
                  },
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.size,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = snapshot.data.docs[index];
                        
                        return Stack(
                          alignment: Alignment.topCenter,
                          overflow: Overflow.visible,
                          children: <Widget>
                          [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: CachedNetworkImage(
                                imageUrl: document['imgAboutUs'],
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 18, left: 16),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.deepPurple,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),

                                  ],
                                ),
                              ),
                            ),

                            //Bottom Sheet
                            Container(
                              //Bottom Sheet Dimensions
                              margin: EdgeInsets.only(top: height / 2.3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40)),
                              ),

                              child: Container(
                                margin: EdgeInsets.only(top: height / 50),
                                height: height,
                                width: width,
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      //Category
                                      Text(
                                        "TENTANG KAMI",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple),
                                      ),

                                      SizedBox(
                                        height: 12,
                                      ),

                                      //Title
                                      Text(
                                        document['appName'],
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),

                                      SizedBox(
                                        height: 12,
                                      ),




                                      SizedBox(
                                        height: 10,
                                      ),
                                    Text(
                                        "DEVELOPER",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent),
                                      ),
                                    SizedBox(
                                        height: 20,
                                      ),

                                      //Profile Pic
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            height: 100,
                                            width: 100,

                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(document['imgDev']),
                                              //backgroundColor: Colors.blue,
                                              radius: 25,
                                            ),
                                          ),

                                          SizedBox(
                                            height: 10,
                                          ),

                                        ],
                                      ),
                                        SizedBox(
                                            height: 20,
                                          ),
                                      Column(
                                        children: [
                                          Text(
                                            document['devName'],
                                            style:
                                                TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),

                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            FlutterIcons.google__with_circle_ent,
                                            color: Colors.redAccent,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                          document['devEmail'],
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 14),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Icon(
                                            FlutterIcons.facebook_with_circle_ent,
                                            color: Colors.indigo,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                           document['devFacebook'],

                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 14),
                                          )

                                        ],

                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),

                                        Text(
                                        "DESKRIPSI",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),

                                      //Paragraph
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              document['description'] ,
                                              overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16.5,
                                                  height: 1.4),
                                              textAlign: TextAlign.left,
                                               maxLines: document['expandSize'],

                                            ),

                                          ),
                                        ],

                                      ),
                                      Flexible(
                                        child: Container(

                                          padding: EdgeInsets.symmetric(vertical: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              FloatingActionButton(
                                                onPressed: () {
                                                  _launchCaller("tel:" + document['devPhone']);
                                                },
                                                child: Icon(FlutterIcons.logo_whatsapp_ion),
                                                backgroundColor: Colors.green,
                                                foregroundColor: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                );
              }),
        ),
      ),

    );
  }


    _launchCaller(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';

    }
  }
}
