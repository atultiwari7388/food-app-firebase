import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then(
                    (value) => Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/welcome",
                      (route) => false,
                    ),
                  );
            },
            icon: Icon(Icons.exit_to_app_outlined),
          ),
        ],
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
