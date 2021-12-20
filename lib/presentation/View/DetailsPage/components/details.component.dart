import 'package:flutter/material.dart';
import 'package:food_app/widgets/rating_star.dart';

class DetailsComponent extends StatelessWidget {
  const DetailsComponent({
    Key? key,
    required this.productName,
    required this.productDescription,
    required this.productOldPrice,
    required this.productPrice,
    required this.productRating,
    required this.productId,
    required this.productImage,
    required this.productCategory,
  }) : super(key: key);

  final String productName;
  final String productDescription;
  final double productOldPrice;
  final double productPrice;
  final double productRating;
  final String productId;
  final String productImage;
  final String productCategory;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              Text("\₹$productOldPrice"),
              SizedBox(width: 20.0),
              Text("\₹$productPrice",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Column(
            children: [
              Divider(thickness: 2.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RatingStars(
                    productRating,
                  ),
                  Text("10 Reviews"),
                ],
              ),
              Divider(thickness: 2.0),
            ],
          ),
          Text("Description:"),
          Text(productDescription),

          SizedBox(height: 50),
          // Center(
          //   child: SizedBox(
          //     height: 44.0,
          //     width: double.infinity,
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10.0),
          //         ),
          //       ),
          //       onPressed: () {

          //       },
          //       child: Text(
          //         "Add to Cart",
          //         style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
