import 'package:flutter/material.dart';

class BannerModel {
  String text;
  List<Color> cardBackground;
  String image;

  BannerModel(this.text, this.cardBackground, this.image);
}

List<BannerModel> bannerCards = [
  new BannerModel(
      'Mengapa Mendonor?',
      [
        Color(0xffa1d4ed),
        Color(0xffc0eaff),
      ],
      "assets/images/414-bg.png"),


  new BannerModel(
      "Covid-19",
      [
        Color(0xffb6d4fa),
        Color(0xffcfe3fc),
      ],
      "assets/images/covid-bg.png"),
  //
  // new BannerModel(
  //     'Demam Berdarah Dengue',
  //     [
  //       Color(0xffffe083),
  //       Color(0xffffe083),
  //     ],
  //     "assets/dengue.jpg"),
  // new BannerModel(
  //     'Limfoma',
  //     [
  //       Color(0xffffffff),
  //       Color(0xffffffff),
  //     ],
  //     "assets/limfoma.jpg"),
  // new BannerModel(
  //     'Konjungtivis',
  //     [
  //       Color(0xfff5c02c),
  //       Color(0xfff5c02c),
  //     ],
  //     "assets/conjungtivis.jpg"),
];