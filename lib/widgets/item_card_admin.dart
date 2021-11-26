import 'package:donateplasma/constants.dart';
import 'package:donateplasma/models/cardModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemCard extends StatelessWidget {
  final String name;

  final int usia;
  final String deskripsi;
  final String phone;
  final String alamat;
  final String goldar;
  final String provinsi;
  final String kota;
  //// Pointer to Update Function
  final Function onUpdate;
  //// Pointer to Delete Function
  final Function onDelete;

  ItemCard(this.name,this.usia,this.goldar, this.phone, this.provinsi, this.kota, this.alamat,{this.deskripsi,
      this.onUpdate, this.onDelete});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
       margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
       padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.pinkAccent[200])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
              backgroundColor: Colors.white,
              radius: 29,
            backgroundImage: AssetImage('assets/images/user0.jpg')),
          // new Image.asset(
          //   'assets/images/user0.jpg',
          //   fit: BoxFit.cover,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text("$name",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600)),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text("$usia",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600)),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text("$phone",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600)),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text("$provinsi",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text("$kota",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text("$alamat",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600)),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text("$goldar",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600)),
              ),


              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text("$deskripsi",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600)),
              ),

            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 50,
                width: 70,
                child: RaisedButton(
                    shape: CircleBorder(),
                    color: Colors.white,
                    child: Center(
                        child: Icon(
                      Icons.cloud_upload_rounded,
                      color: Colors.lightBlueAccent,
                          size: 30.0,
                    )),
                    onPressed: () {
                      if (onUpdate != null) onUpdate();
                    }),
              ),
              SizedBox(
                height: 70,
                width: 70,

              ),
              SizedBox(
                height: 50,
                width: 70,
                child: RaisedButton(
                    shape: CircleBorder(),
                    color: Colors.white,
                    child: Center(

                        child: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    )),
                    onPressed: () {
                      if (onDelete != null) onDelete();
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}
