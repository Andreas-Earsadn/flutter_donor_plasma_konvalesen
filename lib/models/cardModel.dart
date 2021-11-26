import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class CardModel {
  String bloodType;
  int cardBackground;
  var cardIcon;

  CardModel(this.bloodType, this.cardBackground, this.cardIcon);
}

List<CardModel> cards = [

  new CardModel("A", 0xFFfbc02d, FlutterIcons.blood_bag_mco),
  new CardModel("B", 0xFF2E7D32, FlutterIcons.blood_bag_mco),
  new CardModel("O", 0xFFec407a, FlutterIcons.blood_bag_mco),
  new CardModel("AB", 0xFF1565C0, FlutterIcons.blood_bag_mco),
  new CardModel("A-", 0xFFEC7748, FlutterIcons.blood_bag_mco),
  new CardModel("O-", 0xFFfbc02d, FlutterIcons.blood_bag_mco),
  new CardModel("O+", 0xFFF345CF, FlutterIcons.blood_bag_mco),
  new CardModel("B+", 0xFF11D295, FlutterIcons.blood_bag_mco),
  new CardModel("B-", 0xFFF30F0F, FlutterIcons.blood_bag_mco),
  new CardModel("A+", 0xFF792727, FlutterIcons.blood_bag_mco),
  new CardModel("AB-", 0xFF1565C0, FlutterIcons.blood_bag_mco),
  new CardModel("AB+", 0xFFEC7748, FlutterIcons.blood_bag_mco),
  new CardModel("Rh-", 0xFFF345CF, FlutterIcons.blood_bag_mco),
  new CardModel("Rh+", 0xFF2E7D32, FlutterIcons.blood_bag_mco),
];
