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
    required productDescription,
  }) {
    FirebaseFirestore.instance
        .collection("favoriteItems")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("wishLists")
        .doc(productId)
        .set({
      "productId": productId,
      "productDescription": productDescription,
      "productCategory": productCategory,
      "productImage": productImage,
      "productName": productName,
      "productPrice": productPrice,
      "productOldPrice": productOldPrice,
      "productRating": productRating,
      "productFavorite": productFavorite,
    });
  }

  void deleteFavoriteItem({required String productId}) {
    FirebaseFirestore.instance
        .collection("favoriteItems")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("wishLists")
        .doc(productId)
        .delete();
    notifyListeners();
  }
}
