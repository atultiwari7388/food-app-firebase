import 'package:flutter/material.dart';
import 'package:food_app/presentation/View/Home/home.view.dart';

class SingleProductWidget extends StatelessWidget {
  const SingleProductWidget({
    Key? key,
    required this.image,
    required this.price,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  final String image;
  final double price;
  final String name;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(12.0),
            height: size!.height * 0.26 + 10,
            width: size!.width / 2 - 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
              ),
              SizedBox(width: 10),
              Text(
                "\₹$price",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
