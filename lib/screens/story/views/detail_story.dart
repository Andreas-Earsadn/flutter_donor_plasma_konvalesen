import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailStory extends StatefulWidget {
  final String authorName;
  const DetailStory({Key key, this.authorName}) : super(key: key);
  @override
  _DetailStoryState createState() => _DetailStoryState();
}

class _DetailStoryState extends State<DetailStory> {
  var isPressed = true;



  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Stories')
                  .orderBy('authorName')
                  .startAt([widget.authorName]).endAt(
                      [widget.authorName + '\uf8ff']).snapshots(),
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
                        // DateTime timeAgo = document["dateTime"];
                        return Stack(
                          alignment: Alignment.topCenter,
                          overflow: Overflow.visible,
                          children: <Widget>
                          [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: CachedNetworkImage(
                                imageUrl: document['imgUrl'],
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 48, left: 16),
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
                                    IconButton(
                                      icon: (isPressed)
                                          ? Icon(
                                              Icons.bookmark_border,
                                              color: Colors.deepPurple,
                                              size: 28,
                                            )
                                          : Icon(
                                              Icons.bookmark,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                      onPressed: () {
                                        setState(() {
                                          if (isPressed == true) {
                                            isPressed = false;
                                          } else {
                                            isPressed = true;
                                          }
                                        });
                                      },
                                    )
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
                                margin: EdgeInsets.only(top: height / 20),
                                height: height,
                                width: width,
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      //Category
                                      Text(
                                        "MY STORY",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple),
                                      ),

                                      SizedBox(
                                        height: 12,
                                      ),

                                      //Title
                                      Text(
                                        document['title'],
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),

                                      SizedBox(
                                        height: 12,
                                      ),


                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            color: Colors.grey,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                           DateFormat.yMMMEd().format (DateTime.tryParse(document['dateTime'])),
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 14),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Icon(
                                            Icons.system_update_rounded,
                                            color: Colors.grey,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            timeago.format(DateTime.tryParse(document['dateTime'])),

                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 14),
                                          )
                                        ],
                                      ),

                                      SizedBox(
                                        height: 20,
                                      ),

                                      //Profile Pic
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            height: 30,
                                            width: 30,

                                            child: CircleAvatar(
                                                      child: Image.asset('assets/images/user0.jpg'),
                                                      //backgroundColor: Colors.blue,
                                                      radius: 25,
                                                    ),
                                                   ),

                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            document['authorName'],
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 30,
                                      ),

                                      //Paragraph
                                      Text(
                                        document['myStory'] ,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16.5,
                                            height: 1.4),
                                        textAlign: TextAlign.left,
                                        maxLines: 8,
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
}
