import 'package:flutter/material.dart';
import 'package:food_app/presentation/View/SignIn/components/signin_authprovider.dart';
import 'package:food_app/widgets/filled_btn.widget.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    SignInAuthProvider signinAuthProvider =
        Provider.of<SignInAuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // top section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset("assets/logo.png", scale: 2.6),
                      SizedBox(height: 10),
                      Text(
                        "SignIn",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // middle section

              Column(
                children: [
                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        size: 30,
                        color: Colors.green,
                      ),
                      labelText: "Email",
                    ),
                  ),
                  TextFormField(
                    controller: _password,
                    obscureText: _isVisible,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline,
                          size: 30, color: Colors.green),
                      labelText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        icon: Icon(
                          _isVisible ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // bottom Section
              SizedBox(height: 10),
              Column(
                children: [
                  signinAuthProvider.isLoading == false
                      ? FilledButtonWidget(
                          btnName: "SignIn",
                          onPressed: () {
                            signinAuthProvider.signinValidation(
                              emailAddress: _email,
                              password: _password,
                              context: context,
                            );
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                  SizedBox(height: 20.0),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/signup");
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Don't Have an Account ? ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                            text: "SignUp",
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
