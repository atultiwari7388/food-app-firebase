import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/View/SignUp/signup.view.dart';
import 'package:food_app/presentation/View/Welcome/welcome.view.dart';

class AppRoutes {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/welcome':
        {
          return MaterialPageRoute(
            builder: (context) => WelcomeView(),
          );
        }
      case "/signup":
        {
          return MaterialPageRoute(
            builder: (context) => SignUpView(),
          );
        }
    }
  }
}
