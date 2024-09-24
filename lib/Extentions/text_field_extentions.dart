import 'package:get/get_utils/src/get_utils/get_utils.dart';

extension TextFieldValidator on String {
  String? isValidEmail() {
    if (isEmpty) {
      return "Enter Email";
    } else if (isNotEmpty && !GetUtils.isEmail(this)) {
      return "Enter Valid Email";
    }
    return null;
  }

  String? isEmptyField({String? messageTitle}) {
    if (isEmpty) {
      return "$messageTitle can't be empty";
    }
    return null;
  }

  String? validatePassword() {
    String pattern =
        r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (isEmpty) {
      return "Enter Password";
    } else if (!regExp.hasMatch(this)) {
      return 'Password must include 6-12 Characters , At least 1 number and 1 special character';
    }
    return null;
  }

  String? validateConfirmPassword({required String password}) {
    if (isEmpty) {
      return "Enter Confirm Password";
    } else if (password != this) {
      return 'Enter same password';
    }
    return null;
  }
}
