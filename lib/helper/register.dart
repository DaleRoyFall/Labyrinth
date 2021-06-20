import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class Register {
  static GlobalKey materialKey = GlobalKey<NavigatorState>();
  static Locale currLocale;
  static var localeStream = BehaviorSubject<Locale>();

  static final List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ru'),
    Locale('ro'),
  ];

  static void initLocale(String deviceLocale) {
    List deviceLocaleDetails = deviceLocale.split("_");
    Register.currLocale =
        _isContainsLocaleInAppLocale(deviceLocaleDetails.first)
            ? Locale(deviceLocaleDetails.first, '')
            : Locale('en', '');
  }

  static bool _isContainsLocaleInAppLocale(String languageCode) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == languageCode) {
        setLocale(supportedLocale.languageCode);
        return true;
      }
    }
    return false;
  }

  static void setLocale(String languageCode) {
    currLocale = Locale(languageCode);
    localeStream.sink.add(Locale('$languageCode', ''));
  }

  static String getLanguageCodeByName(String language) {
    switch (language) {
      case "Русский":
        return "ru";
      case "Română":
        return "ro";

      default:
        return "en";
    }
  }

  static String getLanguageNameByCode(String languageCode) {
    switch (languageCode) {
      case "ru":
        return "Русский";
      case "ro":
        return "Română";

      default:
        return "English";
    }
  }
}
