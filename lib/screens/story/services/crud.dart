import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CrudMethods {
  Future<void> addData(blogData) async {
    FirebaseFirestore.instance.collection("Stories").add(blogData).catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await FirebaseFirestore.instance.collection("Stories").snapshots();
  }
}