import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donateplasma/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'infoDetailPlasma.dart';


class InfoPlasma extends StatefulWidget {

  static const routeName = '/FAQs';
  @override
  _InfoPlasma createState() => _InfoPlasma();
}

class _InfoPlasma extends State<InfoPlasma> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            'FAQ',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('infoPlasma')
                .orderBy('title')
                .startAt(['']).endAt(['' + '\uf8ff']).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                physics: BouncingScrollPhysics(),
                children: snapshot.data.docs.map((document) {
                  return Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 10,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: Colors.black87,
                                width: 0.2,
                              ))),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlasmaDetail(
                                  plasmaInfo: document['title'],
                                )),
                          );
                        },

                        child: Row(
                          children: [
                            SizedBox(


                              height: MediaQuery.of(context).size.height *0.005,
                              width: MediaQuery.of(context).size.width * 0.00005,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    document['title'],
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    document['sinopsis'],
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.lato(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
                }).toList(),
              );
            }));
  }
}