import 'package:flutter/material.dart';
import 'package:labyrinth/helper/size_config.dart';

class InputField extends StatelessWidget {
  InputField(
      this.backgroundColor,
      this.hintText,
      this.icon,
      this.textEditingController,
      this.validator,
      this.obscureText,
      this.keyboardType,
      {this.visibilityValidator,
      this.onChangeVisibility});

  final Color backgroundColor;
  final String hintText;
  final IconData icon;
  final TextEditingController textEditingController;
  final Function validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool visibilityValidator;
  final Function onChangeVisibility;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: SizeConfig.adaptWidth(10), right: SizeConfig.adaptWidth(10)),
      child: TextFormField(
        controller: textEditingController,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: backgroundColor,
            contentPadding: EdgeInsets.only(
                top: SizeConfig.adaptHeight(3),
                bottom: SizeConfig.adaptHeight(3)),
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: SizeConfig.adaptWidth(4), color: Colors.grey[300]),
            focusColor: Colors.redAccent,
            prefixIcon: Icon(
              icon,
              color: Colors.grey[300],
            ),
            suffixIcon: obscureText
                ? GestureDetector(
                    child: !visibilityValidator
                        ? Icon(
                            Icons.visibility,
                            color: Colors.grey[300],
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: Colors.grey[300],
                          ),
                    onTap: onChangeVisibility,
                  )
                : Container(
                    width: 0,
                    height: 0,
                  ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 2,
              ),
            )),
        validator: validator,
        obscureText: (visibilityValidator != null && !visibilityValidator) ??
            obscureText,
        keyboardType: keyboardType,
      ),
    );
  }
}
