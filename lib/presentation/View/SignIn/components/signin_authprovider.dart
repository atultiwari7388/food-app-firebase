import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInAuthProvider extends ChangeNotifier {
  static String Pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp _regExp = RegExp(Pattern);

  bool isLoading = false;

  UserCredential? userCredential;

  void signinValidation({
    required TextEditingController? emailAddress,
    required TextEditingController? password,
    required BuildContext context,
  }) async {
    if (emailAddress!.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email Address is required'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else if (!_regExp.hasMatch(emailAddress.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email Address is invalid'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else if (password!.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password is required'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password must be at least 8 characters'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      try {
        isLoading = true;
        notifyListeners();

        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailAddress.text,
          password: password.text,
        )
            .catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message),
              backgroundColor: Colors.red,
            ),
          );
        }).then((value) async {
          isLoading = false;
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Successfully signed in'),
              backgroundColor: Colors.green,
            ),
          );
          await Navigator.of(context).pushReplacementNamed('/');
          notifyListeners();
        });
      } on FirebaseException catch (e) {
        isLoading = false;
        notifyListeners();

        if (e.code == "user-not-found") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User not found'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (e.code == "wrong-password") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Wrong password'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Something went wrong'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
