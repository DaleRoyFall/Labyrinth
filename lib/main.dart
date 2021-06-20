import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:labyrinth/home/profile/settings_page.dart';
import 'package:labyrinth/splash/splash_page.dart';

import 'helper/app_localizations.dart';
import 'helper/register.dart';
import 'helper/size_config.dart';
import 'home/test/diagnosis_page.dart';
import 'home/test/test_page.dart';

import 'package:rxdart/rxdart.dart';
import 'package:devicelocale/devicelocale.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Register.initLocale(await Devicelocale.currentLocale);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Register.localeStream.stream.distinct(),
        initialData: Register.currLocale,
        builder: (context, localeSnapshot) {
          return MaterialApp(
            navigatorKey: Register.materialKey,
            title: 'Labyrinth',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            supportedLocales: Register.supportedLocales,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: localeSnapshot.data,
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode ||
                    supportedLocale.countryCode == locale.countryCode) {
                  Register.setLocale(supportedLocale.languageCode);
                  return supportedLocale;
                }
              }

              return Register.currLocale;
            },

            debugShowCheckedModeBanner: false,
            home: SplashPage(),
            // home: DiagnosisPage(
            //   disease: "Bipolar",
            // ),
            // home: SettingsPage(),
          );
        });
  }
}
