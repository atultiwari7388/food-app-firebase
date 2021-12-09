import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/View/Home/home.view.dart';
import 'package:food_app/presentation/View/Welcome/welcome.view.dart';

class LoggedInView extends StatelessWidget {
  const LoggedInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapShot.hasData) {
            return HomeView();
          } else if (snapShot.hasError) {
            return Text("Error");
          } else {
            return WelcomeView();
          }
        },
      ),
    );
  }
}
