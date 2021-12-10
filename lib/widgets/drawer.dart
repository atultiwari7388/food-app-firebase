import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/View/Home/home.view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  _buildDrawerOption(Icon? icon, String? title, Function()? onTap) {
    return ListTile(
      leading: icon,
      title: Text(
        title!,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Stack(
            children: [
              Image(
                height: 200,
                width: double.infinity,
                image: NetworkImage(
                    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcmkt-image-prd.freetls.fastly.net%2F0.1.0%2Fps%2F1975968%2F1360%2F906%2Fm1%2Ffpnw%2Fwm1%2Fu327jilz1k5qg9zkqrolwekuw4qqxhwr8olzyznr86nyq1ykghyev1zacxaz4uj3-.jpg%3F1480686447%26s%3Dc83588a72c0940648334b98b3194568b&f=1&nofb=1"),
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 20.0,
                left: 20.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 3.0, color: Theme.of(context).primaryColor),
                      ),
                      child: ClipOval(
                        child: Image(
                          image: NetworkImage(
                              "https://scontent.fbbi5-1.fna.fbcdn.net/v/t39.30808-6/256320539_287960583239367_3515810905931329717_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=730e14&_nc_ohc=OGcM8hdI1l8AX8Hen6R&_nc_ht=scontent.fbbi5-1.fna&oh=ccf66147ee484794f0ee859ea4087090&oe=61B6BF53"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 7.0),
                    Text(
                      userModel.fullName!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _buildDrawerOption(
              Icon(Icons.account_circle), "Your Profile", () => null),
          _buildDrawerOption(
              Icon(Icons.favorite_border), "Favorite", () => null),
          _buildDrawerOption(
              Icon(Icons.shopping_cart_outlined), "Cart", () => null),
          _buildDrawerOption(Icon(Icons.badge_sharp), "My Orders", () => null),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: _buildDrawerOption(
                Icon(Icons.exit_to_app_outlined),
                "Logout",
                () => {
                  FirebaseAuth.instance.signOut().then(
                        (value) => Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/welcome",
                          (route) => false,
                        ),
                      ),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
