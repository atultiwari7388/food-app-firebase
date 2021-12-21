import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/widgets/grid_view.widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridViewWidget(
      id: FirebaseAuth.instance.currentUser!.uid,
      collection: "favoriteItems",
      firebaseSubCollectionName: "wishLists",
      productCategory: "categoryName",
    );
  }
}
