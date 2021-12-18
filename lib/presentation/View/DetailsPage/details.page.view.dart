import 'package:flutter/material.dart';

import 'package:food_app/presentation/View/DetailsPage/components/details.component.dart';
import 'package:food_app/presentation/View/DetailsPage/components/top.component.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.productDescription,
    required this.productOldPrice,
    required this.productPrice,
    required this.productRating,
  }) : super(key: key);

  final String productImage;
  final String productName;
  final String productDescription;
  final double productOldPrice;
  final double productPrice;
  final double productRating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(productName),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TopComponent(productImage: productImage),
            DetailsComponent(
              productDescription: productDescription,
              productName: productName,
              productOldPrice: productOldPrice,
              productPrice: productPrice,
              productRating: productRating,
            ),
          ],
        ),
      ),
    );
  }
}
