import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food_app/presentation/View/Cart/cart.view.dart';

import 'package:food_app/presentation/View/DetailsPage/components/details.component.dart';
import 'package:food_app/presentation/View/DetailsPage/components/top.component.dart';
import 'package:food_app/provider/fav.provider.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productDescription,
    required this.productOldPrice,
    required this.productPrice,
    required this.productRating,
    required this.productCategory,
  }) : super(key: key);

  final String productId;
  final String productImage;
  final String productName;
  final String productDescription;
  final double productOldPrice;
  final double productPrice;
  final double productRating;
  final String productCategory;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    FavoritesProvider favProvider =
        Provider.of<FavoritesProvider>(context, listen: false);

    FirebaseFirestore.instance
        .collection("favoriteItems")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userFavorite")
        .doc(widget.productId)
        .get()
        .then((value) {
      if (this.mounted) {
        if (value.exists) {
          setState(() {
            isFavorite = value.get("productFavorite");
          });
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(widget.productName),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TopComponent(productImage: widget.productImage),
            DetailsComponent(
              productDescription: widget.productDescription,
              productName: widget.productName,
              productImage: widget.productImage,
              productOldPrice: widget.productOldPrice,
              productPrice: widget.productPrice,
              productRating: widget.productRating,
              productId: widget.productId,
              productCategory: widget.productCategory,
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              style: TextButton.styleFrom(minimumSize: Size(185, 50)),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("cart")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("userCart")
                    .doc(widget.productId)
                    .set({
                  "productId": widget.productId,
                  "productName": widget.productName,
                  "productImage": widget.productImage,
                  "productCategory": widget.productCategory,
                  "productPrice": widget.productPrice,
                  "productDescription": widget.productDescription,
                  "productQuantity": 1,
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartView(),
                  ),
                );
              },
              icon: Icon(IconlyLight.buy),
              label: Text(
                "GO TO CART",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(minimumSize: Size(160, 50)),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;

                  if (isFavorite == true) {
                    favProvider.favoriteBtn(
                      productId: widget.productId,
                      productCategory: widget.productCategory,
                      productImage: widget.productImage,
                      productName: widget.productName,
                      productPrice: widget.productPrice,
                      productOldPrice: widget.productOldPrice,
                      productRating: widget.productRating,
                      productFavorite: true,
                    );
                  } else if (isFavorite == false) {
                    FirebaseFirestore.instance
                        .collection("favoriteItems")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("userFavorite")
                        .doc(widget.productId)
                        .delete();
                  }
                });
              },
              icon: isFavorite
                  ? Icon(
                      IconlyBold.heart,
                      color: Colors.red,
                    )
                  : Icon(
                      IconlyBold.heart,
                      color: Colors.grey,
                    ),
              label: Text(
                "ADD TO FAVORITES",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
