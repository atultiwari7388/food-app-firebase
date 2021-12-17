import 'package:flutter/material.dart';

class SingleProductWidget extends StatelessWidget {
  const SingleProductWidget(
      {Key? key, required this.image, required this.price, required this.name})
      : super(key: key);

  final String image;
  final double price;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(12.0),
          height: 200,
          width: 150,
          decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\₹$price",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 5),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
