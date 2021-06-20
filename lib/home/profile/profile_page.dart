import 'dart:async';
import 'dart:ui' as ui;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labyrinth/firebase/firebase_authentification.dart';
import 'package:labyrinth/firebase/firebase_cloud_firestore.dart';
import 'package:labyrinth/helper/app_localizations.dart';
import 'package:labyrinth/helper/size_config.dart';
import 'package:labyrinth/home/profile/settings_page.dart';

import 'profile_curve_clipper.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.backgroundColor});

  final Color backgroundColor;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = FirebaseAuthentification().getCurrUser();
  var userInfo = FirebaseCloudFirestore.currUserInfo;

  @override
  Widget build(BuildContext context) {
    Image image = Image.network(
      user.photoURL,
    );
    Completer<ui.Image> completer = new Completer<ui.Image>();
    image.image.resolve(new ImageConfiguration()).addListener(
        ImageStreamListener(
            (ImageInfo info, bool _) => completer.complete(info.image)));

    return Container(
      color: widget.backgroundColor,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            ClipPath(
              clipper: ProfileCurveClipper(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.tealAccent,
                        Colors.blue,
                        Colors.indigo,
                        Colors.indigo[900],
                      ]),
                ),
                height: SizeConfig.adaptHeight(43),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 30, right: 10),
                child: IconButton(
                  icon: Icon(
                    Icons.settings,
                    size: 34,
                    color: Colors.white70,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage(
                              name: user.displayName,
                            )),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  _buildAvatarWidget(completer, image),
                  SizedBox(
                    height: SizeConfig.adaptHeight(4),
                  ),
                  Text(
                    user.displayName,
                    style: TextStyle(
                        fontSize: SizeConfig.adaptFontSize(6),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(user.email),
                  SizedBox(
                    height: SizeConfig.adaptHeight(2),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cake,
                        color: Colors.pink,
                      ),
                      SizedBox(
                        width: SizeConfig.adaptWidth(1),
                      ),
                      Text(
                        userInfo["birthday"],
                        style: TextStyle(
                          fontSize: SizeConfig.adaptFontSize(4),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.adaptHeight(2),
                  ),
                  Text(
                    AppLocalizations.of(context).translate("from") +
                        " " +
                        userInfo["country"],
                    style: TextStyle(
                        fontSize: SizeConfig.adaptFontSize(4),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarWidget(Completer<ui.Image> completer, Image image) {
    return Container(
      height: SizeConfig.adaptHeight(30),
      width: SizeConfig.adaptHeight(30),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: new Border.all(
            color: Colors.deepPurple[700],
            width: 3.0,
          ),
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: image.image,
          ),
          color: Colors.deepPurple[700].withOpacity(0.3)),
      child: FutureBuilder<ui.Image>(
          future: completer.future,
          builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
            if (snapshot.hasData) {
              return Container();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
