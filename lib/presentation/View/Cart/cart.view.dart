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

          return ListView.separated(
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
              return CartWidget(
                productName: data["productName"],
                productImage: data["productImage"],
                productPrice: data["productPrice"],
                productQuantity: data["productQuantity"],
              );
            },
          );
        },
      ),
    );
  }
}
