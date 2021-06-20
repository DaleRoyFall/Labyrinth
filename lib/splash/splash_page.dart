import 'package:flutter/material.dart';
import 'package:labyrinth/helper/app_localizations.dart';
import 'package:labyrinth/helper/size_config.dart';
import 'package:labyrinth/login/login_page.dart';
import 'package:labyrinth/sign_up/sign_up.dart';
import 'package:labyrinth/splash/widgets/top_wave_clipper.dart';

import 'widgets/rounded_button.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: SizeConfig.screenHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: [
              Colors.lightBlueAccent,
              // Colors.blue,
              Colors.indigo,
            ]),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: TopWaveClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.indigo,
                      Colors.lightBlueAccent,
                    ], begin: Alignment.topLeft, end: Alignment.center),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: SizeConfig.adaptHeight(30),
                ),
                child: Image.asset(
                  "assets/images/man-maze.png",
                  scale: 5,
                  color: Colors.white30,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: SizeConfig.adaptHeight(36),
                  left: SizeConfig.adaptWidth(5),
                ),
                child: Text(
                  "Labyrinth",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.adaptFontSize(6),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.adaptHeight(8),
          ),
          RoundedButton(
            backgroundColor: Colors.indigo,
            child: Text(
              AppLocalizations.of(context).translate("login"),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.adaptFontSize(4)),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.adaptHeight(2),
          ),
          RoundedButton(
            backgroundColor: Colors.indigo[50],
            child: Text(
              AppLocalizations.of(context).translate("sign_up"),
              style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.adaptFontSize(4)),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpPage(),
              ),
            ),
          )
        ],
      ),
    )));
  }
}
