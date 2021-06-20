import 'package:firebase_auth/firebase_auth.dart';
import 'package:labyrinth/helper/app_localizations.dart';

enum AuthentificationErrorCode {
  invalid_email,
  user_disabled,
  user_not_found,
  wrong_password,
  email_already_in_use
}

class AuthentificationErrorCodeMessage {
  String getErrorMessage(FirebaseAuthException firebaseAuthException) {
    if (firebaseAuthException.code ==
        _enumToString(AuthentificationErrorCode.invalid_email,
            replaceFrom: "_", replaceTo: "-")) {
      return "invalid_email";
    } else if (firebaseAuthException.code ==
        _enumToString(AuthentificationErrorCode.email_already_in_use,
            replaceFrom: "_", replaceTo: "-")) {
      return "email_already_in_use";
    } else if (firebaseAuthException.code ==
        _enumToString(AuthentificationErrorCode.user_disabled,
            replaceFrom: "_", replaceTo: "-")) {
      return "user_disabled";
    } else if (firebaseAuthException.code ==
        _enumToString(AuthentificationErrorCode.user_not_found,
            replaceFrom: "_", replaceTo: "-")) {
      return "user_not_found";
    } else if (firebaseAuthException.code ==
        _enumToString(AuthentificationErrorCode.wrong_password,
            replaceFrom: "_", replaceTo: "-")) {
      return "wrong_password";
    }

    return null;
  }

  String _enumToString(dynamic value, {String replaceFrom, String replaceTo}) {
    return value.toString().split('.').last.replaceAll(replaceFrom, replaceTo);
  }
}
