// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:donateplasma/models/User.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// FirebaseFirestore firestore = FirebaseFirestore.instance;
// CollectionReference donors = firestore.collection('Donors1');
//
//
// class Users extends ChangeNotifier  {
//   //
//   //
//   //  int _userId;
//   //  String _userName;
//   // String _userPhone;
//   // String _userLocation;
//   // String _userDP;
//   // String _userBlood;
//   //
//   //  DocumentSnapshot donorsDoc = await FirebaseFirestore.instance.collection('Donors1').doc().get();
//   // builder: (_, snapshot){
//   // if (snapshot.hasData){
//   // return Column(
//   // children: snapshot.data.docs
//   //     .map((e) =>
//   // UsersCard(userName: e.data()['name'], userLocation: e.data()['alamat'],userPhone: e.data()['no phone'], userBlood: e.data()['goldar']
//   // )                            )
//   // );
//   // }else {
//   // return Text('Loading');
//   // }
//
//   List<User> _users = [
//     User(
//       userId: 1,
//       userName: 'Andreas Earsadn',
//       userDP: 'assets/images/user0.png',
//       userPhone: '+628123456789',
//       userLocation: 'Medan',
//       userBlood: 'O+'
//     ),
//     User(
//         userId: 2,
//         userName: 'Mark Sepultura',
//         userDP: 'assets/images/user0.png',
//         userPhone: '+628123456789',
//         userLocation: 'Jakarta',
//         userBlood: 'O+'
//     ),
//     User(
//         userId: 3,
//         userName: 'David Kurniawan',
//         userDP: 'assets/images/user0.png',
//         userPhone: '+628123456789',
//         userLocation: 'Surabaya',
//         userBlood: 'B+'
//     ),
//     User(
//         userId: 4,
//         userName: 'Ridwan Nizam',
//         userDP: 'assets/images/user0.png',
//         userPhone: '+628123456789',
//         userLocation: 'Bandung',
//         userBlood: 'O-'
//     ),
//     User(
//         userId: 5,
//         userName: 'Vina Permatasari',
//         userDP: 'assets/images/user0.png',
//         userPhone: '+628123456789',
//         userLocation: 'Bali',
//         userBlood: 'O+'
//     ),
//     User(
//         userId: 6,
//         userName: 'Dedi Haryanto',
//         userDP: 'assets/images/user0.png',
//         userPhone: '+628123456789',
//         userLocation: 'Lampung',
//         userBlood: 'A+'
//     ),
//     User(
//         userId: 7,
//         userName: 'Oksan Saragih',
//         userDP: 'assets/images/user0.png',
//         userPhone: '+628123456789',
//         userLocation: 'Siantar',
//         userBlood: 'A+'
//     ),
//     User(
//         userId: 8,
//         userName: 'Sutan Mahendra',
//         userDP: 'assets/images/user0.png',
//         userPhone: '+628123456789',
//         userLocation: 'Palembang',
//         userBlood: 'A+'
//     ),
//     User(
//         userId: 9,
//         userName: 'John Heracles',
//         userDP: 'assets/images/user0.png',
//         userPhone: '+628123456789',
//         userLocation: 'Batam',
//         userBlood: 'A+'
//     ),
//     User(
//         userId: 10,
//         userName: 'Hasan Arif',
//         userDP: 'assets/images/user0.png',
//         userPhone: '+628123456789',
//         userLocation: 'Pabna',
//         userBlood: 'A+'
//     ),
//   ];
//
//
//   List<User> get userList {
//     final baseUserList = [..._users];
//     return baseUserList;
//   }
// }