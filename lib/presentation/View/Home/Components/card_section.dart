import 'package:flutter/material.dart';

class CardSection extends StatelessWidget {
  const CardSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 155.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcmkt-image-prd.freetls.fastly.net%2F0.1.0%2Fps%2F1975968%2F1360%2F906%2Fm1%2Ffpnw%2Fwm1%2Fu327jilz1k5qg9zkqrolwekuw4qqxhwr8olzyznr86nyq1ykghyev1zacxaz4uj3-.jpg%3F1480686447%26s%3Dc83588a72c0940648334b98b3194568b&f=1&nofb=1"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          Container(
            height: 155.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.white.withOpacity(0.3),
                  Colors.black54.withOpacity(0.3),
                  Theme.of(context).primaryColor.withOpacity(0.3),
                ],
                stops: [
                  0.1,
                  0.3,
                  0.7,
                  0.4,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 45.0,
            left: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "30% OFF",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      BoxShadow(
                        blurRadius: 6.0,
                        color: Theme.of(context).primaryColor,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  "On Your Next Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // image button
        ],
      ),
    );
  }
}
