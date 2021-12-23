import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/widgets/filled_btn.widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
                onChanged: (value) {
                  setState(() {
                    email = value.trim();
                  });
                },
              ),
              SizedBox(height: 30),
              FilledButtonWidget(
                btnName: "Send Request",
                onPressed: () async {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: email!)
                      .whenComplete(
                        () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Emaiil sent to $email"),
                            backgroundColor: Colors.green,
                          ),
                        ),
                      );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
