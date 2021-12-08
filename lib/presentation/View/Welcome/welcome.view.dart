import 'package:flutter/material.dart';
import 'package:food_app/presentation/View/Welcome/components/top_section.dart';
import 'package:food_app/widgets/filled_btn.widget.dart';
import 'package:food_app/widgets/outlined_btn.widget.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Top Section
            TopSection(),
            //Center Section
            Center(
              child: Image.asset("assets/logo.png"),
            ),
            //Bottom Section
            FilledButtonWidget(
              btnName: 'LogIn',
              onPressed: () {},
            ),
            OutlineButtonWidget(
              btnName: 'SignUp',
              onPressed: () => Navigator.pushNamed(context, '/signup'),
            ),
          ],
        ),
      ),
    );
  }
}
