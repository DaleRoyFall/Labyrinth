import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labyrinth/firebase/enum/authentification_error_code.dart';
import 'package:labyrinth/firebase/firebase_authentification.dart';
import 'package:labyrinth/helper/app_localizations.dart';
import 'package:labyrinth/helper/size_config.dart';
import 'package:labyrinth/helper/validation.dart';
import 'package:labyrinth/home/home_page.dart';
import 'package:labyrinth/home/post_wall/bloc_list/post_list_cubit.dart';
import 'package:labyrinth/login/widgets/wave_widget.dart';
import 'package:labyrinth/splash/splash_page.dart';
import 'package:labyrinth/splash/widgets/rounded_button.dart';

import 'widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();

  bool passwordVisible = false;
  String loginErrorCode = "";

  @override
  Widget build(BuildContext context) {
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return WillPopScope(
      onWillPop: () async {
        pushPage(context, SplashPage());
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Stack(
          children: [
            Container(
              height: SizeConfig.screenHeight - 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue[400],
                      Colors.blue[50],
                    ]),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeOutQuad,
              top: keyboardOpen ? -SizeConfig.screenHeight : 0.0,
              child: WaveWidget(
                size: Size(SizeConfig.screenWidth, SizeConfig.screenHeight),
                yOffset: SizeConfig.screenHeight / 3,
                color: Colors.white,
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
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: SizeConfig.adaptHeight(50),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            loginErrorCode,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: SizeConfig.adaptFontSize(3.5),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.adaptHeight(2),
                        ),
                        InputField(
                            keyboardOpen
                                ? Colors.blueAccent.withOpacity(0.5)
                                : Colors.deepPurple[700].withOpacity(0.5),
                            AppLocalizations.of(context).translate("email"),
                            Icons.email,
                            emailController,
                            validateEmail,
                            false,
                            TextInputType.emailAddress),
                        SizedBox(
                          height: SizeConfig.adaptHeight(2),
                        ),
                        InputField(
                            keyboardOpen
                                ? Colors.blueAccent.withOpacity(0.5)
                                : Colors.deepPurple[700].withOpacity(0.5),
                            AppLocalizations.of(context).translate("password"),
                            Icons.lock,
                            passwordController,
                            validatePassword,
                            true,
                            TextInputType.visiblePassword,
                            visibilityValidator: passwordVisible,
                            onChangeVisibility: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        }),
                        SizedBox(
                          height: SizeConfig.adaptHeight(2),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.adaptWidth(10),
                              right: SizeConfig.adaptWidth(14)),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("forgot_password"),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.adaptFontSize(3),
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                print(
                                  AppLocalizations.of(context)
                                      .translate("forgot_password"),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.adaptHeight(2),
                        ),
                        RoundedButton(
                          backgroundColor: keyboardOpen
                              ? Colors.blueAccent.withOpacity(0.5)
                              : Colors.deepPurple[700].withOpacity(0.5),
                          child: Text(
                            AppLocalizations.of(context).translate("login"),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.adaptFontSize(4)),
                          ),
                          onPressed: () async {
                            print(FirebaseAuthentification().getCurrUser());

                            if (_formKey.currentState.validate()) {
                              dynamic loginResult =
                                  await FirebaseAuthentification().login(
                                      emailController.text,
                                      passwordController.text);

                              if (loginResult is User) {
                                loginErrorCode = "";
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (_) =>
                                          PostListCubit()..fetchPostList(),
                                      child: HomePage(),
                                    ),
                                  ),
                                );
                              } else {
                                setState(() {
                                  loginErrorCode = AppLocalizations.of(context)
                                      .translate(
                                          AuthentificationErrorCodeMessage()
                                              .getErrorMessage(loginResult));
                                });
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<T> pushPage<T>(BuildContext context, Widget page) {
  return Navigator.of(context)
      .push<T>(MaterialPageRoute(builder: (context) => page));
}
