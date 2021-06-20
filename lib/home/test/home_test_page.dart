import 'package:flutter/material.dart';
import 'package:labyrinth/helper/app_localizations.dart';
import 'package:labyrinth/helper/size_config.dart';
import 'package:labyrinth/splash/widgets/rounded_button.dart';

import 'test_page.dart';

class HomeTestPage extends StatefulWidget {
  HomeTestPage({this.backgroundColor});

  final Color backgroundColor;

  @override
  _HomeTestPageState createState() => _HomeTestPageState();
}

class _HomeTestPageState extends State<HomeTestPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.adaptWidth(5),
          vertical: SizeConfig.adaptHeight(1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.adaptHeight(8),
          ),
          Text(
            AppLocalizations.of(context).translate("test"),
            style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.adaptFontSize(8),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: SizeConfig.adaptHeight(6),
          ),
          Text(
            AppLocalizations.of(context).translate("be_honest_with_yourself"),
            style: TextStyle(
                color: Colors.white, fontSize: SizeConfig.adaptFontSize(6)),
          ),
          SizedBox(
            height: SizeConfig.adaptHeight(6),
          ),
          Text(
            """${AppLocalizations.of(context).translate("this_test_is_made_for_personal_reference")}""",
            style: TextStyle(
                color: Colors.white, fontSize: SizeConfig.adaptFontSize(6)),
          ),
          SizedBox(
            height: SizeConfig.adaptHeight(2),
          ),
          RoundedButton(
            backgroundColor: Colors.blueAccent.withOpacity(0.5),
            child: Text(
              AppLocalizations.of(context).translate("start"),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.adaptFontSize(4)),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TestPage()),
            ),
          ),
        ],
      ),
    );
  }
}
