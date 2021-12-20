import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String productId;
  final String productName;
  final String productImage;
  final String productCategory;
  final double productPrice;
  final int productQuantity;

  CartModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productCategory,
    required this.productPrice,
    required this.productQuantity,
  });

  factory CartModel.fromDocument(QueryDocumentSnapshot doc) {
    return CartModel(
      productName: doc["productName"],
      productImage: doc["productImage"],
      productPrice: doc["productPrice"],
      productQuantity: doc["productQuantity"],
      productCategory: doc["productCategory"],
      productId: doc["productId"],
    );
  }
}
