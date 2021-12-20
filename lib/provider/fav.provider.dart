import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class FavoritesProvider with ChangeNotifier {
  void favoriteBtn({
    required productId,
    required productCategory,
    required productImage,
    required productName,
    required productPrice,
    required productOldPrice,
    required productRating,
    required productFavorite,
  }) {
    FirebaseFirestore.instance
        .collection("favoriteItems")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userFavorite")
        .doc(productId)
        .set({
      "productId": productId,
      "productCategory": productCategory,
      "productImage": productImage,
      "productName": productName,
      "productPrice": productPrice,
      "productOldPrice": productOldPrice,
      "productRating": productRating,
      "productFavorite": productFavorite,
    });
  }
}
