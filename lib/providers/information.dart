import 'package:donateplasma/models/info.dart';
import 'package:donateplasma/themes/themes_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Information extends ChangeNotifier {
  List<Info> _information = [
    Info(
      color: Colors.deepPurpleAccent.shade100,
      infoId: 1,
      message: 'Selalu menjaga jarak ketika kamu sedang berada di luar rumah. \n Jangan keluyuran jika tidak ada urusan yang terlalu penting yah..'
    ),
    Info(
        color: Colors.deepPurpleAccent.shade100,
        infoId: 2,
        message: 'Gunakan handsanitizer, masker dan sarung tangan untuk melindungi diri anda.'
    ),
    Info(
        color: Colors.deepPurpleAccent.shade100,
        infoId: 3,
        message: 'Menghindari merokok dan segera ambil tindakan medis jika pernafasan anda bermasalah.'
    ),
    Info(
        color: Colors.deepPurpleAccent.shade100,
        infoId: 4,
        message: 'Konsumsi makanan bergizi untuk meningkatkan sistem imun anda.'
    ),
    Info(
        color: Colors.deepPurpleAccent.shade100,
        infoId: 5,
        message: 'Konsultasi dengan dokter jika anda tiba-tiba mengalami sakit.'
    ),
    Info(
        color: Colors.deepPurpleAccent.shade100,
        infoId: 6,
        message: 'Bacalah buku dan habiskan waktu bersama keluarga anda untuk menghindari depresi selama isolasi.'
    ),
  ];

  List<Info> get infoList {
    final baseInfoList = [..._information];
    return baseInfoList;
  }
}