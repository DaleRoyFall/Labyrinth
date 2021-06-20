import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labyrinth/firebase/enum/authentification_error_code.dart';
import 'package:labyrinth/firebase/firebase_authentification.dart';
import 'package:labyrinth/firebase/firebase_storage.dart';
import 'package:labyrinth/firebase/firebase_cloud_firestore.dart';
import 'package:labyrinth/helper/app_localizations.dart';
import 'package:labyrinth/helper/size_config.dart';
import 'package:labyrinth/helper/validation.dart';
import 'package:labyrinth/home_intro/home_intro.dart';
import 'package:labyrinth/login/widgets/input_field.dart';
import 'package:labyrinth/login/widgets/wave_widget.dart';
import 'package:labyrinth/splash/widgets/rounded_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sprintf/sprintf.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController fullNameController =
      TextEditingController(text: "");
  final TextEditingController birthdayController =
      TextEditingController(text: "");
  final TextEditingController countryController =
      TextEditingController(text: "");
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final TextEditingController repeatedPasswordController =
      TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();

  bool passwordVisible = false;
  bool repeatedPasswordVisible = false;

  // Get image route
  File _image;
  bool _imageValidator;
  final picker = ImagePicker();

  String signUpErrorCode = "";

  @override
  Widget build(BuildContext context) {
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight - 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.indigo,
                    Colors.tealAccent,
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
                    Colors.blue,
                    Colors.indigo,
                    Colors.indigo[900],
                  ]),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.adaptHeight(6),
                      ),
                      _buildAvatarWidget(),
                      SizedBox(
                        height: SizeConfig.adaptHeight(2),
                      ),
                      _imageValidator == false
                          ? Text(
                              AppLocalizations.of(context)
                                  .translate("image_must_not_be_empty"),
                              style: TextStyle(color: Colors.red[700]),
                            )
                          : Container(),
                      SizedBox(
                        height: SizeConfig.adaptHeight(1),
                      ),
                      InputField(
                          keyboardOpen
                              ? Colors.blueAccent.withOpacity(0.5)
                              : Colors.deepPurple[700].withOpacity(0.5),
                          AppLocalizations.of(context).translate("full_name"),
                          Icons.account_circle,
                          fullNameController,
                          validateFullName,
                          false,
                          TextInputType.name),
                      SizedBox(
                        height: SizeConfig.adaptHeight(2),
                      ),
                      InputField(
                          keyboardOpen
                              ? Colors.blueAccent.withOpacity(0.5)
                              : Colors.deepPurple[700].withOpacity(0.5),
                          AppLocalizations.of(context).translate("birthday"),
                          Icons.date_range,
                          birthdayController,
                          validateBirthday,
                          false,
                          TextInputType.name),
                      SizedBox(
                        height: SizeConfig.adaptHeight(2),
                      ),
                      InputField(
                          keyboardOpen
                              ? Colors.blueAccent.withOpacity(0.5)
                              : Colors.deepPurple[700].withOpacity(0.5),
                          AppLocalizations.of(context).translate("country"),
                          Icons.map,
                          countryController,
                          validateCountry,
                          false,
                          TextInputType.name),
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
                      InputField(
                          keyboardOpen
                              ? Colors.blueAccent.withOpacity(0.5)
                              : Colors.deepPurple[700].withOpacity(0.5),
                          AppLocalizations.of(context)
                              .translate("re_enter_password"),
                          Icons.lock,
                          repeatedPasswordController,
                          (value) {
                            if (value.toString().isEmpty) {
                              return sprintf(
                                  AppLocalizations.of(context)
                                      .translate("field_must_not_be_empty"),
                                  [
                                    AppLocalizations.of(context)
                                        .translate("repeated_password")
                                  ]);
                            } else if (value != passwordController.text) {
                              return AppLocalizations.of(context)
                                  .translate("passwords_must_match");
                            } else {
                              return null;
                            }
                          },
                          true,
                          TextInputType.visiblePassword,
                          visibilityValidator: repeatedPasswordVisible,
                          onChangeVisibility: () {
                            setState(() {
                              repeatedPasswordVisible =
                                  !repeatedPasswordVisible;
                            });
                          }),
                      SizedBox(
                        height: SizeConfig.adaptHeight(2),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.adaptWidth(10),
                            right: SizeConfig.adaptWidth(10)),
                        alignment: Alignment.center,
                        child: Text(
                          signUpErrorCode,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: SizeConfig.adaptFontSize(3.5),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
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
                            AppLocalizations.of(context).translate("sign_up"),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.adaptFontSize(4)),
                          ),
                          onPressed: () async {
                            print("Full name: ${fullNameController.text}");
                            print("Birthday: ${fullNameController.text}");
                            print("Email: ${emailController.text}");
                            print("Password: ${passwordController.text}");
                            print(
                                "RepeatedPassword: ${repeatedPasswordController.text}");

                            if (_formKey.currentState.validate() &&
                                _imageValidator) {
                              dynamic signUpResult =
                                  await FirebaseAuthentification()
                                      .registerWithEmailAndPassword(
                                          emailController.text,
                                          passwordController.text);

                              if (signUpResult is User) {
                                signUpErrorCode = "";
                                var imageName = _image.path.split("/").last;
                                String imageUrl = await LocalFirebaseStorage()
                                    .saveFileToStorage(
                                        "user_avatars/$imageName", _image);

                                User updatedUser =
                                    FirebaseAuth.instance.currentUser;
                                updatedUser.updateProfile(
                                    displayName: fullNameController.text,
                                    photoURL: imageUrl);
                                FirebaseCloudFirestore().saveUserInfo(
                                    updatedUser,
                                    fullNameController.text,
                                    imageUrl,
                                    birthdayController.text,
                                    countryController.text);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeIntroPage()),
                                );
                              } else {
                                setState(() {
                                  signUpErrorCode = AppLocalizations.of(context)
                                      .translate(
                                          AuthentificationErrorCodeMessage()
                                              .getErrorMessage(signUpResult));
                                });
                              }
                            } else if (_imageValidator == null) {
                              setState(() {
                                _imageValidator = false;
                              });
                            } else {
                              print("Form validation failed");
                            }
                          }),
                      SizedBox(
                        height: SizeConfig.adaptHeight(keyboardOpen ? 2 : 4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Get image from gallery
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageValidator = true;
      } else {
        print('No image selected.');
      }
    });
  }

  _buildAvatarWidget() {
    return GestureDetector(
      onTap: () {
        getImage();
      },
      child: Container(
        height: SizeConfig.adaptHeight(30),
        width: SizeConfig.adaptHeight(30),
        decoration: _image != null
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: new Border.all(
                  color: _imageValidator == false
                      ? Colors.red[700]
                      : Colors.deepPurple[700],
                  width: 3.0,
                ),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new FileImage(_image),
                ))
            : BoxDecoration(
                color: Colors.transparent,
                borderRadius: new BorderRadius.all(new Radius.circular(500)),
                border: new Border.all(
                  color: _imageValidator == false
                      ? Colors.red[700]
                      : Colors.deepPurple[700].withOpacity(0.5),
                  width: 3.0,
                ),
              ),
        child: _image != null
            ? Container()
            : Column(
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.adaptHeight(5),
                  ),
                  Icon(
                    Icons.person,
                    size: 86,
                    color: _imageValidator == false
                        ? Colors.red[700]
                        : Colors.deepPurple[700].withOpacity(0.5),
                  ),
                  Text(
                    AppLocalizations.of(context).translate("add_photo"),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: _imageValidator == false
                          ? Colors.red[700]
                          : Colors.deepPurple[700].withOpacity(0.5),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    birthdayController.dispose();
    countryController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatedPasswordController.dispose();

    super.dispose();
  }
}
