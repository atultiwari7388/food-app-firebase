import 'package:flutter/material.dart';
import 'package:food_app/presentation/View/Home/home.view.dart';
import 'package:food_app/presentation/View/LoggedIn/logged_in.view.dart';
import 'package:food_app/presentation/View/Profile/profile.view.dart';
import 'package:food_app/presentation/View/SignIn/signin.view.dart';
import 'package:food_app/presentation/View/SignUp/signup.view.dart';
import 'package:food_app/presentation/View/Welcome/welcome.view.dart';

class AppRoutes {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        {
          return MaterialPageRoute(
            builder: (context) => HomeView(),
          );
        }
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
      case "/signin":
        {
          return MaterialPageRoute(
            builder: (context) => SignInView(),
          );
        }
      case "/loggedin":
        {
          return MaterialPageRoute(
            builder: (context) => LoggedInView(),
          );
        }
      case "/profile":
        {
          return MaterialPageRoute(
            builder: (context) => ProfileView(),
          );
        }
    }
  }
}
