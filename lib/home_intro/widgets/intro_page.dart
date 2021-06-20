import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labyrinth/helper/size_config.dart';
import 'package:labyrinth/home/home_page.dart';
import 'package:labyrinth/home/post_wall/bloc_list/post_list_cubit.dart';

import '../constants.dart';

class IntroPage extends StatelessWidget {
  IntroPage(
      {this.backgroundColor,
      this.image,
      this.diseaseName,
      this.diseaseDescription});

  final Color backgroundColor;
  final Image image;
  final String diseaseName;
  final String diseaseDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      color: backgroundColor,
      child: Stack(
        alignment: Alignment.bottomCenter,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: SizeConfig.adaptHeight(25)),
              child: image,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.adaptWidth(6),
                  vertical: SizeConfig.adaptHeight(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Labyrinth",
                    style: goldCoinWhiteStyle,
                  ),
                  GestureDetector(
                    child: Text(
                      "Skip",
                      style: goldCoinWhiteStyle,
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (_) => PostListCubit()..fetchPostList(),
                          child: HomePage(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.adaptWidth(6)),
            child: Container(
              height: SizeConfig.adaptHeight(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    diseaseName,
                    style: whiteStyle,
                  ),
                  SizedBox(
                    height: SizeConfig.adaptHeight(4),
                  ),
                  Text(
                    diseaseDescription,
                    style: descriptionWhiteStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
