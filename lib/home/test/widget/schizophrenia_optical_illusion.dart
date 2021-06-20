import 'package:flutter/material.dart';
import 'package:labyrinth/helper/size_config.dart';

class SchizophreniaOpticalIllusion extends StatelessWidget {
  SchizophreniaOpticalIllusion({this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.adaptWidth(50),
      height: SizeConfig.adaptWidth(50),
      decoration: BoxDecoration(
        color: Color(0xff949599),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
