import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labyrinth/helper/size_config.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({Key key, this.backgroundColor, this.child, this.onPressed})
      : super(key: key);

  final Color backgroundColor;
  final Widget child;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.adaptWidth(80),
      margin: EdgeInsets.only(
          right: SizeConfig.adaptWidth(10), left: SizeConfig.adaptWidth(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: backgroundColor,
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
