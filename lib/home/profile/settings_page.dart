import 'package:flutter/material.dart';
import 'package:labyrinth/helper/app_localizations.dart';
import 'package:labyrinth/helper/register.dart';
import 'package:labyrinth/helper/size_config.dart';
import 'package:labyrinth/login/login_page.dart';

import '../../main.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({this.name});
  final String name;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String settedLanguage;
  List languageItems = ["English", "Русский", "Română"];

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(body: _builBody());
  }

  _builBody() {
    return Container(
      width: SizeConfig.adaptWidth(100),
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
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.adaptHeight(10),
          ),
          Text(
            AppLocalizations.of(context).translate("settings"),
            style: TextStyle(
                color: Colors.indigo[900],
                fontSize: SizeConfig.adaptFontSize(6),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: SizeConfig.adaptHeight(6),
          ),
          _buildSelectAreaSettingContainer(
              AppLocalizations.of(context).translate("my_account"),
              widget.name.toString(),
              _buildChooseIconWidget()),
          SizedBox(
            height: SizeConfig.adaptHeight(3),
          ),
          _buildSelectAreaSettingContainer(
              AppLocalizations.of(context).translate("language"),
              Register.getLanguageNameByCode(
                Register.currLocale.languageCode,
              ),
              _buildChooseLanguageWidget()),
          SizedBox(
            height: SizeConfig.adaptHeight(3),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.indigo.withOpacity(0.5))),
              child: Container(
                alignment: Alignment.center,
                width: SizeConfig.adaptWidth(80),
                margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.adaptHeight(3),
                ),
                child: Text(
                  AppLocalizations.of(context).translate("log_out"),
                  style: TextStyle(
                      fontSize: SizeConfig.adaptFontSize(6),
                      color: Colors.white70),
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildChooseIconWidget() {
    return Container(
      width: SizeConfig.adaptWidth(15),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.only(
            right: SizeConfig.adaptWidth(4),
          ),
          child: Icon(
            Icons.arrow_forward_ios_sharp,
            size: 16,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }

  _buildChooseLanguageWidget() {
    return Container(
      width: SizeConfig.adaptWidth(15),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          dropdownColor: Colors.indigo[600].withOpacity(0.7),
          icon: Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(
                right: SizeConfig.adaptWidth(4),
              ),
              child: Icon(
                Icons.arrow_forward_ios_sharp,
                size: 16,
                color: Colors.white70,
              ),
            ),
          ),
          onChanged: (value) {
            Register.setLocale(Register.getLanguageCodeByName(value));
            setState(() {
              settedLanguage = value;
            });
          },
          items: languageItems.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  _buildSelectAreaSettingContainer(
      String title, String settedSetting, Widget chooseContentWidget) {
    return Container(
      width: SizeConfig.adaptWidth(100),
      height: SizeConfig.adaptHeight(10),
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.adaptWidth(6)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: SizeConfig.adaptWidth(4),
            ),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white70, fontSize: SizeConfig.adaptFontSize(5)),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: SizeConfig.adaptWidth(30),
            child: Text(
              settedSetting,
              style: TextStyle(
                  color: Colors.white70, fontSize: SizeConfig.adaptFontSize(4)),
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          chooseContentWidget,
        ],
      ),
    );
  }
}
