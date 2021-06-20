import 'package:labyrinth/helper/register.dart';

import 'package:sprintf/sprintf.dart';
import 'app_localizations.dart';

String validateFullName(String value) {
  String patttern = r"^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$";
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return sprintf(
        AppLocalizations.of(Register.materialKey.currentContext)
            .translate("field_must_not_be_empty"),
        [
          AppLocalizations.of(Register.materialKey.currentContext)
              .translate("full_name")
        ]);
  } else if (!regExp.hasMatch(value)) {
    return sprintf(
        AppLocalizations.of(Register.materialKey.currentContext)
            .translate("invalid_form_of"),
        [
          AppLocalizations.of(Register.materialKey.currentContext)
              .translate("full_name")
        ]);
  }
  return null;
}

String validateBirthday(String value) {
  String pattern = r'^\d{4}\/(0[1-9]|1[012])\/(0[1-9]|[12][0-9]|3[01])$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return sprintf(
        AppLocalizations.of(Register.materialKey.currentContext)
            .translate("field_must_not_be_empty"),
        [
          AppLocalizations.of(Register.materialKey.currentContext)
              .translate("birthday")
        ]);
  } else if (!regExp.hasMatch(value)) {
    return sprintf(
        AppLocalizations.of(Register.materialKey.currentContext)
            .translate("birthday_must_be"),
        [
          AppLocalizations.of(Register.materialKey.currentContext)
              .translate("birthday_form")
        ]);
  }

  return null;
}

String validateCountry(String value) {
  String pattern = r'[a-zA-Z]{2,}';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0)
    return sprintf(
        AppLocalizations.of(Register.materialKey.currentContext)
            .translate("field_must_not_be_empty"),
        [
          AppLocalizations.of(Register.materialKey.currentContext)
              .translate("country")
        ]);
  else if (!regExp.hasMatch(value)) {
    return sprintf(
        AppLocalizations.of(Register.materialKey.currentContext)
            .translate("invalid_form_of"),
        [
          AppLocalizations.of(Register.materialKey.currentContext)
              .translate("country")
        ]);
  }

  return null;
}

String validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0 || value == null) {
    return sprintf(
        AppLocalizations.of(Register.materialKey.currentContext)
            .translate("field_must_not_be_empty"),
        [
          AppLocalizations.of(Register.materialKey.currentContext)
              .translate("email")
        ]);
  } else if (!regExp.hasMatch(value)) {
    return sprintf(
        AppLocalizations.of(Register.materialKey.currentContext)
            .translate("invalid_form_of"),
        [
          AppLocalizations.of(Register.materialKey.currentContext)
              .translate("email")
        ]);
  } else {
    return null;
  }
}

String validatePassword(String value) {
  String patttern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return sprintf(
        AppLocalizations.of(Register.materialKey.currentContext)
            .translate("field_must_not_be_empty"),
        [
          AppLocalizations.of(Register.materialKey.currentContext)
              .translate("password")
        ]);
  } else if (value.length < 8) {
    return sprintf(
        AppLocalizations.of(Register.materialKey.currentContext)
            .translate("password_must_not_be_shorter_than"),
        [8]);
  } else if (!regExp.hasMatch(value)) {
    return AppLocalizations.of(Register.materialKey.currentContext)
        .translate("password_must_contain");
  }
  return null;
}

String validateField(String value) {
  if (value.length == 0) {
    return sprintf(
        AppLocalizations.of(Register.materialKey.currentContext)
            .translate("field_must_not_be_empty"),
        [""]).replaceFirst("''", "");
  }
  return null;
}
