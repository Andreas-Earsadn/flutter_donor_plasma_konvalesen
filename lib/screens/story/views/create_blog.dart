import 'dart:io';
import 'package:donateplasma/animation/FadeAnimation.dart';
import 'package:donateplasma/screens/story/services/crud.dart';
import 'package:donateplasma/screens/story/story_screen.dart';
import 'package:donateplasma/widgets/drawerWidget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

import '../../../constants.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String authorName, title, desc, story;
  DateTime timeNow = DateTime.now();

  File selectedImage;
  bool _isLoading = false;
  CrudMethods crudMethods = new CrudMethods();
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(pickedFile.path);
    });
  }


  Future uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });

      // Create a Reference to the file

      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('blogImages')
          .child("${randomAlphaNumeric(9)}.jpg");

      firebase_storage.UploadTask uploadTask = ref.putFile(selectedImage);

      var downloadUrl = await (await uploadTask
          .whenComplete(() => "Gambar anda sudah diupload"))
          .ref
          .getDownloadURL();
      print("this is url $downloadUrl");

      Map<String, String> blogMap = {
        "imgUrl": downloadUrl,
        "authorName": authorName,
        "title": title,
        "desc": desc,
        "myStory": story,
        "dateTime": timeNow.toString()
      };
      crudMethods.addData(blogMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<
        ScaffoldState>();
    // final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
    return Scaffold

      (resizeToAvoidBottomInset: true,

      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        key: _scaffoldKey,
        // drawer: CustomDrawer(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Bagikan", style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            Text("Ceritamu",
              style: TextStyle(fontSize: 22, color: Colors.redAccent),
            )
          ],
        ),

        elevation: 0.0,

        actions: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();

              uploadBlog();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.file_upload)),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: _isLoading
            ? Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        )
            : Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              FadeAnimation(
                1.0,
                Container(
                  height: 180.0,
                  child: Image.asset('assets/images/st.png'),
                ),
              ),
              // SizedBox(
              //   height: 100,
              //
              // ),
              GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    pickImage();
                  },
                  child: selectedImage != null
                      ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    height: 170,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.file(
                        selectedImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                      : Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    height: 170,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(6)),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.black45,
                    ),
                  )),
              SizedBox(
                height: 8,
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "Author Name",
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: kPrimaryColor))),
                      onChanged: (val) {
                        if (val.isEmpty) {
                          return "Data ini tidak boleh kosong";
                        }
                        else {
                          authorName = val;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,

                      decoration: InputDecoration(
                          hintText: "Judul",
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: kPrimaryColor))),
                      onChanged: (val) {
                        if (val.isEmpty) {
                          return "Data ini tidak boleh kosong";
                        }
                        else {
                          title = val;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,

                      decoration: InputDecoration(
                          hintText: "Deskripsi Singkat",
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: kPrimaryColor))),
                      maxLines: 3,
                      onChanged: (val) {
                        if (val.isEmpty) {
                          return "Data ini tidak boleh kosong";
                        }
                        else {
                          desc = val;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(

                      decoration: InputDecoration(
                          hintText: "Ceritakan Maksimal 500 kata",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor))),
                      maxLines: 10,
                      onChanged: (val) {
                        if (val.isEmpty) {
                          return "Data ini tidak boleh kosong";
                        }
                        else {
                          story = val;
                        }
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    FlatButton(
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(28)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Share",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 18)),
                            ],
                          )),
                      onPressed: ()  {
                        if (authorName != null && title != null &&
                            selectedImage != null && desc != null &&
                            story != null) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "KONFIRMASI DATA YANG ANDA INPUT",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  content: Text(
                                    "Author : $authorName\nJudul: $title\nDeskripsi : $desc\n\nApakah anda yakin dengan data yang anda input ?",
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
                        //             FlatButton(
                        //               child: Text("IYA",
                        //                   style: TextStyle(
                        //                     fontFamily: 'Poppins',
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: 17,
                        //                     color: Colors.redAccent,
                        //                   )),
                        //               onPressed: () {
                        //                 uploadBlog();
                        //                 Fluttertoast.showToast(
                        //                     msg:
                        //                     "Story anda telah masuk pada sistem kami. Admin akan memproses story anda",
                        //                     toastLength:
                        //                     Toast.LENGTH_SHORT,
                        //                     gravity:
                        //                     ToastGravity.CENTER,
                        //                     fontSize: 16.0,
                        //                     backgroundColor:
                        //                     Colors.green,
                        //                     textColor: Colors.white);
                        //
                        //                 Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                       builder: (context) =>
                        //                           StoryScreen()),
                        //                 );
                        //               },
                        //
                        //             ),
                        //           ],
                        //         );
                        //       });
                                    FlatButton(
                                      onPressed: () {
                                        uploadBlog();

                                        Fluttertoast.showToast(
                                            msg:
                                            "Story anda telah masuk pada sistem kami. Admin akan memproses story data anda",
                                            toastLength:
                                            Toast.LENGTH_SHORT,
                                            gravity:
                                            ToastGravity.CENTER,
                                            fontSize: 16.0,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white);


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
                              "Terjadi kesalahan input data atau data yang anda masukkan belum lengkap\n Silahkan untuk mencoba menginput data kembali",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              fontSize: 16.0,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
                        }
                      },
                      //
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}



