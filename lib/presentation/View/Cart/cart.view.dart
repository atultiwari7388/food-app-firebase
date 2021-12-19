import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/widgets/cart.widget.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text('Cart'),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {},
        child: Text("CHECKOUT"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("cart")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("userCart")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (!streamSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            );
          }

          return streamSnapshot.data!.docs.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your cart is empty",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Start adding some items to your cart",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey,
                      height: 1.0,
                    );
                  },
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = streamSnapshot.data!.docs[index];

                    if (!streamSnapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return CartWidget(
                      productName: data["productName"],
                      productImage: data["productImage"],
                      productPrice: data["productPrice"],
                      productQuantity: data["productQuantity"],
                      productCategory: data["productCategory"],
                      productId: data["productId"],
                    );
                  },
                );
        },
      ),
    );
  }
}
