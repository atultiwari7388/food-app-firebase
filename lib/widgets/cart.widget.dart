import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productCategory,
    required this.productQuantity,
    required this.productId,
    Key? key,
  }) : super(key: key);

  final String productName;
  final String productImage;
  final double productPrice;
  final String productCategory;
  final int productQuantity;
  final String productId;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int quantity = 1;

  void quantityCounter() async {
    await FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(widget.productId)
        .update({
      "productQuantity": quantity,
    });
  }

  void removeProductfromCart() async {
    await FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(widget.productId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    // print(quantity);
    return Container(
      margin: EdgeInsets.all(12.0),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.productImage),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.productName,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      widget.productCategory,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      "\₹${widget.productPrice * widget.productQuantity}",
                      style: TextStyle(),
                    ),
                    Container(
                      width: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 0.9, color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                  quantityCounter();
                                });
                              }
                            },
                            child: Text(
                              "-",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            widget.productQuantity.toString(),
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                                quantityCounter();
                              });
                            },
                            child: Text(
                              "+",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text(
                            "Are you sure you want to remove this item from cart?"),
                        actions: [
                          CupertinoDialogAction(
                            child: Text("Yes"),
                            onPressed: () {
                              Navigator.pop(context);
                              removeProductfromCart();
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });

                // showDialog(
                //     context: context,
                //     builder: (context) {
                //       return AlertDialog(
                //         title: Text("Remove Product"),
                //         content: Text(
                //             "Are you sure you want to remove this product from cart?"),
                //         actions: [
                //           FlatButton(
                //             onPressed: () {
                //               Navigator.of(context).pop();
                //             },
                //             child: Text("No"),
                //           ),
                //           FlatButton(
                //             onPressed: () {
                //               Navigator.of(context).pop();
                //               removeProductfromCart();
                //             },
                //             child: Text("Yes"),
                //           ),
                //         ],
                //       );
                //     });
              },
              icon: Icon(
                IconlyBold.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
