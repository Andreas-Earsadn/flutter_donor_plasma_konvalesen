import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donateplasma/constants/color_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:donateplasma/screens/story/services/crud.dart';
import 'package:donateplasma/screens/story/views/create_blog.dart';
import 'package:donateplasma/screens/story/views/detail_story.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoryScreen extends StatefulWidget {
  static const routeName = '/story';
  @override
  _StoryScreen createState() => _StoryScreen();
}

class _StoryScreen extends State<StoryScreen> {
  CrudMethods crudMethods = new CrudMethods();
  // DocumentSnapshot doc;

  Stream blogsStream = FirebaseFirestore.instance
      .collection('Stories')
      .orderBy('authorName')
      .snapshots();


  @override
  void initState() {
    crudMethods.getData().then((result) {
      setState(() {
        blogsStream = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Bagikan",
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Ceritamu",
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent),
            )
          ],
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
      ),
      backgroundColor: Colors.deepPurple.shade50,
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: blogsStream != null
            ? new SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                        stream: blogsStream,

                        builder: (context, snapshot) {
                          return ListView.builder(
                              physics: ClampingScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              itemCount: snapshot.data.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                DocumentSnapshot document = snapshot.data.docs[index];
                               return Container(
                                  margin: EdgeInsets.only(bottom: 16),
                                  height: 150,
                                  child: Stack(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: CachedNetworkImage(
                                          imageUrl: document['imgUrl'],
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        height: 170,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black45.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => DetailStory(
                                                  authorName: document['authorName']
                                                  // authorName: authorName['authorName'],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                document['title'], textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        Colors.grey.shade100),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                document['desc'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        Colors.grey.shade100),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                document['authorName'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w300,
                                                    color:
                                                        Colors.grey.shade100),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        })
                  ],
                ),
              )
            : Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateBlog()));
              },
              child: Icon(Icons.add),
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}


