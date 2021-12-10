import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/View/Home/home.view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

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
            Container(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userModel.userImage!),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Column(
                children: [
                  Text(
                    userModel.fullName!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    userModel.emailAddress!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    "+91-6307537145",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
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
                    Icons.favorite_border,
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
                    'Favorite',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Container(
              child: Card(
                color: Colors.grey.shade100,
                elevation: 0,
                child: ListTile(
                  leading: Icon(
                    Icons.shopping_cart_outlined,
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
                    'Cart',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Container(
              child: Card(
                color: Colors.grey.shade100,
                elevation: 0,
                child: ListTile(
                  leading: Icon(
                    Icons.badge_sharp,
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
                    Icons.login_outlined,
                    size: 30,
                    color: Color(0xffDB1B18),
                  ),
                  TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then(
                            (value) => Navigator.pushNamedAndRemoveUntil(
                              context,
                              "/welcome",
                              (route) => false,
                            ),
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
