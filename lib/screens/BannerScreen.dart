import 'package:donateplasma/animation/FadeAnimation.dart';
import 'package:donateplasma/constants/text_style_constants.dart';
import 'package:donateplasma/screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:donateplasma/constants/color_constants.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BannerScreen extends StatelessWidget {
  static const routeName = '/banner';

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 700.0,
   height: MediaQuery.of(context).size.height,


      color: kPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 55, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeAnimation(
              1.5,
              Container(
                height: 95.0,
                width: 95.0,
                child: Image.asset('assets/images/bloodcase.png'),
              ),
            ),
            FadeAnimation(
              1.6,
              Row(
                children: <Widget>[
                  Text(
                    'Donor',
                    style: kBannerTitleStyle,
                  ),
                  Text(
                    ' Plasma',
                    style: kBannerPlasmaTitleStyle,
                  )
                ],
              ),
            ),
            FadeAnimation(
              1.6,
              Text(
                'Selamatkan banyak kehidupan',
                style: kBannerTitleStyle,
              ),
            ),
            SizedBox(
              height: 0.0,
            ),
            FadeAnimation(
              1.7,
              Text(
                'Anda telah sembuh dari Covid-19? Donorkan plasma anda untuk menyelamatkan nyawa mereka. Mari berjuang bersama kami untuk',
                style: kBannerSubTitleStyle,
              ),
            ),
            SizedBox(
              height: 10.0, //atur ukuran
            ),
            FadeAnimation(
              1.8,
              Text(
                'MENYELAMATKAN DUNIA',
                style: kBannerSub02TitleStyle,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            FadeAnimation(
              1.5,
              Container(
                height: 80.0,
                width: 100.0,
                alignment: Alignment.bottomRight,
                child: Image.asset('assets/images/bg2dp.png'),

              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            FadeAnimation(
              1.8,
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 100.0,
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                          Fluttertoast.showToast(
                              msg:
                              "Selamat datang di halaman utama aplikasi donor plasma konvalesen\n",
                              toastLength:
                              Toast.LENGTH_LONG,
                              gravity:
                              ToastGravity.CENTER,
                              fontSize: 16.0,
                              backgroundColor:
                              kPrimaryColor,
                              textColor: Colors.white);
                        },
                        child: Text(
                          'Join Us',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily: 'Poppins'
                          ),
                        ),
                        color: kBannerBasicColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),

            )
          ],

        ),
      ),
    );
  }


}
