import 'package:flutter/material.dart';
import 'package:food_app/presentation/View/SignUp/components/signup_authprovider.dart';
import 'package:food_app/widgets/filled_btn.widget.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool _isVisible = true;

  TextEditingController _fullName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SignupAuthProvider signupAuthProvider =
        Provider.of<SignupAuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "SignUp",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  TextFormField(
                    controller: _fullName,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_outline,
                        size: 30,
                        color: Colors.green,
                      ),
                      labelText: "Full Name",
                    ),
                  ),
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
              Column(
                children: [
                  signupAuthProvider.isLoading == false
                      ? FilledButtonWidget(
                          btnName: "Register",
                          onPressed: () {
                            signupAuthProvider.signupValidation(
                              context: context,
                              fullName: _fullName,
                              emailAddress: _email,
                              password: _password,
                            );
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, "/signin"),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "Signin ",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
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
