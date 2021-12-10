import 'package:flutter/material.dart';
import 'package:food_app/widgets/drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Home'),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
