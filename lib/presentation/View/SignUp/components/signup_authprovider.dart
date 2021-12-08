import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupAuthProvider extends ChangeNotifier {
  static String Pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp _regExp = RegExp(Pattern);

  void signupValidation({
    required TextEditingController? fullName,
    required TextEditingController? emailAddress,
    required TextEditingController? password,
    required BuildContext context,
  }) async {
    if (fullName!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Full Name is required'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else if (emailAddress!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email Address is required'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else if (!_regExp.hasMatch(emailAddress.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid Email Address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else if (password!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password Should be at least 8 characters'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else if (password.text.trim().length <= 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password Should be at least 8 characters'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
  }
}
