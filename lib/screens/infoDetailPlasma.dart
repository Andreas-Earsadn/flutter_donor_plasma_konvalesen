import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class PlasmaDetail extends StatefulWidget {
  final String plasmaInfo;
  const PlasmaDetail({this.plasmaInfo});
  @override
  _PlasmaDetailState createState() => _PlasmaDetailState();
}

class _PlasmaDetailState extends State<PlasmaDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          widget.plasmaInfo,
          style: GoogleFonts.lato(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('infoPlasma')
              .orderBy('title')
              .startAt([widget.plasmaInfo]).endAt(
              [widget.plasmaInfo + '\uf8ff']).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
                physics: ClampingScrollPhysics(),
                children: snapshot.data.docs.map((document) {
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.only(left: 20, right: 20),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white10,
                            ),
                            child: Image.asset('assets/images/Facebook Post 940x788 px (3)-min.png'),),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.only(left: 20, right: 20),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade100,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  document['title'],
                                  textAlign:TextAlign.end,
                                  style: GoogleFonts.lato(
                                      color: Colors.black87,
                                      letterSpacing:0,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),

                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  document['deskripsi'],
                                  textAlign:TextAlign.justify,

                                  style: GoogleFonts.lato(
                                    color: Colors.black54,
                                    fontSize: 18,
                                    letterSpacing:0,
                                  ),
                                )
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.only(left: 20, right: 20),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blueGrey[50],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '@Andreas Earsadn',
                                  style: GoogleFonts.lato(
                                      color: Colors.black87,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.left,
                                ),

                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),

                      ],
                    ),
                  );
                }).toList());
          }),
    );
  }
}
