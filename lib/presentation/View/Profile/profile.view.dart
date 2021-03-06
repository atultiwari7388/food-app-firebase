import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food_app/presentation/View/Cart/cart.view.dart';
import 'package:food_app/presentation/View/Home/home.view.dart';
import 'package:food_app/presentation/View/favorites/favorites.screen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isEdit = false;

  Widget textFromField({required String hintText}) {
    return Container(
      child: Text(
        hintText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('My Account'),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Container(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/logo.png"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Column(
                children: [
                  textFromField(hintText: userModel.fullName),
                  textFromField(hintText: userModel.emailAddress),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Container(
              child: Card(
                color: Colors.grey.shade100,
                elevation: 0,
                child: ListTile(
                  leading: Icon(
                    IconlyBold.heart,
                    color: Theme.of(context).primaryColor,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoriteScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  title: Text(
                    'Favorite',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Card(
                color: Colors.grey.shade100,
                elevation: 0,
                child: ListTile(
                  leading: Icon(
                    IconlyBold.buy,
                    color: Theme.of(context).primaryColor,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartView(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  title: Text(
                    'Cart',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Card(
                color: Colors.grey.shade100,
                elevation: 0,
                child: ListTile(
                  leading: Icon(
                    IconlyBold.bag,
                    color: Theme.of(context).primaryColor,
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  title: Text(
                    'My Orders',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Icon(
                    IconlyBold.logout,
                    size: 30,
                    color: Color(0xffDB1B18),
                  ),
                  TextButton(
                    onPressed: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text("LogOut"),
                            content: Text(
                                "Are you sure you want to logout from the app?"),
                            actions: [
                              CupertinoDialogAction(
                                child: Text("Cancel"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              CupertinoDialogAction(
                                child: Text("Logout"),
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pop(context);
                                  FirebaseAuth.instance.signOut().then(
                                        (value) =>
                                            Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          "/welcome",
                                          (route) => false,
                                        ),
                                      );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "Logout",
                      style:
                          TextStyle(color: Color(0xffDB1B18), fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget settingOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "My Profile",
            style: TextStyle(
              color: Color(0xffDB1B18),
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
