import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupAuthProvider extends ChangeNotifier {
  static String Pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp _regExp = RegExp(Pattern);

  UserCredential? _userCredential;

  bool isLoading = false;

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
    } else if (password.text.trim().length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password Should be at least 8 characters'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
      try {
        isLoading = true;
        notifyListeners();

        _userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress.text,
          password: password.text,
        );

        isLoading = true;
        notifyListeners();

        FirebaseFirestore.instance
            .collection("users")
            .doc(_userCredential!.user!.uid)
            .set(
          {
            "FullName": fullName.text,
            "emailAddress": emailAddress.text,
            "password": password.text,
            "userUid": _userCredential!.user!.uid,
          },
        ).then((value) async {
          isLoading = false;
          notifyListeners();
          Text("Account Created Successfully");

          await Navigator.pushNamedAndRemoveUntil(
            context,
            "/",
            (route) => false,
          );
          notifyListeners();
        });
      } on FirebaseAuthException catch (e) {
        isLoading = false;
        notifyListeners();

        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Weak Password"),
              backgroundColor: Colors.red,
            ),
          );
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Email already exists"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
