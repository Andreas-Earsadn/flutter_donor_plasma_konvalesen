import 'dart:convert' as convert;
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donateplasma/animation/FadeAnimation.dart';
import 'package:donateplasma/constants/color_constants.dart';
import 'package:donateplasma/modules/city_model.dart';
import 'package:donateplasma/modules/province_model.dart';
import 'package:donateplasma/screens/HomeScreen.dart';
import 'package:donateplasma/widgets/drawerWidget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  static const routeName = '/edit';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final goldar = ['A  ', 'B  ', 'O  ', 'A+ ', 'B+ ', 'O- ', 'O+ ', 'AB ', 'A- ', 'A+ ', 'AB-', 'AB+','Rh+','Rh-'];

  String dropdownValue;
  var dropdownProvinceValue;
  var dropdownCityValue;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController bloodController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
    //firebase
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference donors = firestore.collection('Donors1');

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Center(
          child: Text(
            'Jadilah pendonor',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.menu_rounded,
            size: 40,
            color: kBannerBasicColor,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.pan_tool,
              size: 25,
              color: kBannerBasicColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(

        child: Form(
          key: _formkey,

          child: Container(

            child: Column(
              children: <Widget>[
                FadeAnimation(
                  0,
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    height: 280.0,
                    child: Image.asset('assets/images/appr.png'),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    //Container(
                     // alignment: Alignment.center,
                     // padding: EdgeInsets.only(left: 10, right: 10),
                       Text(
                        '+ FORMULIR ',
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color:Colors.red,
                        ),
                      ),
                    Text(
                      'PENDONOR',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color:kPrimaryColor,
                      ),
                    ),

                    //),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 35, right: 35, bottom: 15),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                        0,
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                offset: Offset(-4, 4),
                                blurRadius: 10,
                                color: Color(0xFF8211D2).withOpacity(.6),
                              )
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(bottom: 20),

                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFFFBF05).withOpacity(.10),
                                    ),
                                  ),
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: nameController,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Data ini tidak boleh kosong";
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Nama Lengkap Anda*",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.all(1.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFFFBF05).withOpacity(.10),
                                    ),
                                  ),
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: ageController,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Data ini tidak boleh kosong";
                                    }
                                    else if (value.length > 2) {
                                      return "Usia yang anda masukkan tidak valid";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Usia *",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top:20, bottom:20),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFFFBF05).withOpacity(.10),
                                    ),
                                  ),
                                ),
                                child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    border:const OutlineInputBorder(),
                                  ),

                                  hint: Text(
                                      'Golongan Darah *', style: TextStyle(color: Colors.grey[400],
                                    fontFamily: 'Poppins',),),

                                  value: dropdownValue,
                                  // icon: Icon(Icons.arrow_drop_down,
                                  //     color: Colors.deepPurpleAccent),
                                  isExpanded: true,

                                  items: goldar.map(buildMenuItem).toList(),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(1.0),
                                // decoration: BoxDecoration(
                                //
                                //   border: Border(
                                //     bottom: BorderSide(
                                //       color: Color(0xFF8211D2).withOpacity(.10),
                                //     ),
                                //
                                //   ),
                                // ),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: phoneController,
                                  validator: (String value) {
                                    String pattern =
                                        r'(^(?:[0+]9)?[0-9]{10,12}$)';
                                    RegExp regExp = new RegExp(pattern);
                                    if (value.isEmpty) {
                                      return "Data ini tidak boleh kosong";
                                    }
                                    if (value.length > 13 || value.length < 5) {
                                      return "Nomor HP anda tidak valid";
                                    }
                                    if (!regExp.hasMatch(value)) {
                                      return 'Mohon masukkan nomor yang valid ya';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border:  OutlineInputBorder(),
                                    hintText: "Nomor Handphone  *",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child:
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                                  child: DropdownSearch<Province>(

                                    // ignore: deprecated_member_use
                                    label: 'Provinsi *',



                                    // popupBarrierColor:kPrimaryColor,
                                    dropdownSearchBaseStyle:  TextStyle(color: Colors.grey[400],
                                      fontFamily: 'Poppins',),
                                    // showSelectedItems: true,


                                    showClearButton: true,
                                    onFind: (String filter) async {

                                      Uri url = Uri.parse(
                                          "https://api.rajaongkir.com/starter/province");
                                      // Uri urlc = Uri.parse("https://api.rajaongkir.com/starter/city");

                                      try {
                                        final response = await http.get(
                                          url,
                                          headers: {
                                            "key":
                                                "6cfef77420547f9bf2f093096cbe160d",
                                          },
                                        );

                                        var data = json.decode(response.body)
                                            as Map<String, dynamic>;

                                        var statusCode =
                                            data["rajaongkir"]["status"]["code"];

                                        if (statusCode != 200) {
                                          throw data["rajaongkir"]["status"]
                                              ["description"];
                                        }

                                        var listAllProvince = data["rajaongkir"]
                                            ["results"] as List<dynamic>;

                                        var models = Province.fromJsonList(
                                            listAllProvince);
                                        return models;
                                      } catch (err) {
                                        print(err);
                                        return List<Province>.empty();
                                      }
                                    },
                                    selectedItem: dropdownProvinceValue,
                                    onChanged: (prov) {
                                      if (prov != null) {
                                        print(prov.province);
                                        dropdownProvinceValue = prov.province;

                                      } else {
                                        print("Tidak memilih provinsi manapun");
                                      }
                                    },
                                    showSearchBox: true,

                                    dropdownSearchDecoration: InputDecoration(
                                        border:  OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 10,
                                    )),
                                    popupItemBuilder:
                                        (context, item, isSelected) {
                                      return Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: kPrimaryColor

                                                  .withOpacity(.10),
                                            ),
                                          ),
                                        ),
                                        child: Text("${item.province}"),
                                      );
                                    },
                                    itemAsString: (item) => item.province,
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom : 20),
                                  child: DropdownSearch<City>(
                                    showClearButton: true,
                                    label: "Pilih kota anda *",
                                    // ignore: deprecated_member_use
                                    hint: 'Kota',

                                    onFind: (String filter) async {
                                      Uri url = Uri.parse(
                                          "https://api.rajaongkir.com/starter/city");
                                      // Uri urlc = Uri.parse("https://api.rajaongkir.com/starter/city");

                                      try {
                                        final response = await http.get(
                                          url,
                                          headers: {
                                            "key":
                                                "6cfef77420547f9bf2f093096cbe160d",
                                          },
                                        );

                                        var data = json.decode(response.body)
                                            as Map<String, dynamic>;

                                        var statusCode =
                                            data["rajaongkir"]["status"]["code"];

                                        if (statusCode != 200) {
                                          throw data["rajaongkir"]["status"]
                                              ["description"];
                                        }

                                        var listAllCity = data["rajaongkir"]
                                            ["results"] as List<dynamic>;

                                        var models =
                                            City.fromJsonList(listAllCity);
                                        return models;
                                      } catch (err) {
                                        print(err);
                                        return List<City>.empty();
                                      }
                                    },
                                    selectedItem: dropdownCityValue,

                                    onChanged: (city) {
                                      if (city != null) {
                                        print(city.cityName);
                                        dropdownCityValue = city.cityName;

                                      } else {
                                        print("Tidak memilih kota manapun");
                                      }
                                    },


                                    showSearchBox: true,
                                    dropdownSearchDecoration: InputDecoration(
                                        border:  OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        )),
                                    popupItemBuilder:
                                        (context, item, isSelected) {
                                      return Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color(0xFF792727)

                                                  .withOpacity(.10),
                                            ),
                                          ),
                                        ),
                                        child: Text("${item.cityName}"),
                                      );
                                    },
                                    itemAsString: (item) => item.cityName,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 20),

                                child: TextFormField(
                                  maxLines: 3,
                                  controller: addressController,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Data ini tidak boleh kosong";
                                    }
                                    return null;
                                  },

                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 10,),

                                    border:  OutlineInputBorder(),
                                    hintText: "Alamat Lengkap*",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(1.0),
                                child: TextFormField(
                                  maxLines: 3,
                                  controller: descriptionController,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Data ini masih kosong";
                                    }
                                    return null;
                                  },

                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 10,),

                                    border:  OutlineInputBorder(),
                                    hintText: "Deskripsikan diri anda (max : 200 character)",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),


                      ),
                      SizedBox(
                        height: 10,
                        width: 200,
                      ),
                      FadeAnimation(
                          2,
                          Container(
                            height: 100,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              //color: Theme.of(context).primaryColor,
                            ),

                            child: Center(



                              child: RaisedButton(
                                elevation: 5,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(15)

                               ),


                                onPressed: () {
                                  String nama,
                                      goldar,
                                      nohp,
                                      alamat,
                                      usia, deskripsi;
                              var  provinsi;
                                      var kota;
                                  nama = nameController.text;
                                  goldar = dropdownValue;
                                  nohp = phoneController.text;
                                  alamat = addressController.text;
                                  provinsi = dropdownProvinceValue.toString();
                                  kota = dropdownCityValue.toString();
                                  usia = ageController.text;
                                  deskripsi = descriptionController.text;

                                  if (_formkey.currentState.validate()) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              "KONFIRMASI DATA DIRI ANDA",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                            content: Text(
                                              "Nama: $nama \nGoldar: $goldar \nUsia: $usia \nNo Handphone: $nohp \nAlamat: $alamat\nProvinsi : $provinsi \nKota:$kota \n\nDeskripsi: $deskripsi  \n\nApakah anda yakin dengan data yang anda masukkan ?",
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                      color: Colors.redAccent,
                                                    )),
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  donors.add({
                                                    //ADD DATA HERE
                                                    'nama': nama,
                                                    'usia' : int.parse(usia),
                                                    'goldar': goldar,
                                                    'no hp': nohp.replaceFirst(
                                                        new RegExp(r'^0+'), ''),
                                                    'provinsi': provinsi,
                                                    'kota': kota,
                                                    'alamat': alamat,
                                                    'deskripsi' : deskripsi,
                                                  });
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Data anda telah masuk pada sistem kami. Admin akan memproses data anda",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      fontSize: 16.0,
                                                      backgroundColor:
                                                          Colors.green,
                                                      textColor: Colors.white);

                                                  // Navigator.of(context).pop(EditProfile.routeName);
                                                 // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                                                  Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);


                                                },
                                                child: Text("IYA",
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                      color: Colors.redAccent,
                                                    )),
                                              ),
                                            ],
                                          );
                                        });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Data yang anda input tidak diizinkan",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        fontSize: 16.0,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white);
                                  }
                                },
                                color: Colors.deepPurpleAccent,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(width: 10),
                                      Text(
                                        'DAFTAR',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'poppins',
                                            fontSize: 16),
                                      )
                                    ]),
                                textColor: Colors.white,
                              ),
                            ),
                            ),
                          )

                      // SizedBox(
                      //   height: 0,
                      // ),
                    ],
                  ),
                )
              ],
            ),

          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
