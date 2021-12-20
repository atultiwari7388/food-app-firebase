import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/models/cart.model.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartLists = [];
  CartModel? cartModel;

  Future getCartData() async {
    final List<CartModel> newCartLists = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .get();

    querySnapshot.docs.forEach((element) {
      // print(element.data());
      cartModel = CartModel.fromDocument(element);
      notifyListeners();
      newCartLists.add(cartModel!);
    });

    cartLists = newCartLists;
    notifyListeners();
  }

  List<CartModel> get getCartListData {
    return cartLists;
  }
}
