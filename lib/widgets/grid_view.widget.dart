import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/View/DetailsPage/details.page.view.dart';
import 'package:food_app/widgets/single_product.widget.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    Key? key,
    required this.id,
    required this.collection,
  }) : super(key: key);

  final String? id;
  final String? collection;

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          collection!.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.3,
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("categories")
            .doc(id)
            .collection(collection!)
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.builder(
            physics: BouncingScrollPhysics(),
            // scrollDirection: Axis.vertical,
            // shrinkWrap: true,
            // itemCount: snapshot.data?.docs.length ?? 0,
            itemCount: snapshot.data!.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
            ),
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index];
              return SingleProductWidget(
                image: data["productImage"],
                name: data["productName"],
                price: data["productPrice"],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      productName: data["productName"],
                      productPrice: data["productPrice"],
                      productImage: data["productImage"],
                      productDescription: data["productDescription"],
                      productOldPrice: data["productOldPrice"],
                      productRating: data["productRating"],
                      productId: data["productId"],
                    ),
                  ),
                ),
              );
            },

            // SizedBox(height: 200),
          );
        },
      ),
    );
  }
}
