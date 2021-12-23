import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/View/DetailsPage/details.page.view.dart';
import 'package:food_app/widgets/single_product.widget.dart';
import 'package:lottie/lottie.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    Key? key,
    required this.id,
    required this.collection,
    required this.productCategory,
    required this.firebaseSubCollectionName,
  }) : super(key: key);

  final String? id;
  final String? collection;
  final String? productCategory;
  final String? firebaseSubCollectionName;

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          firebaseSubCollectionName!.trim().toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.3,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(collection!)
            .doc(id)
            .collection(firebaseSubCollectionName!)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return snapshot.data!.docs.isEmpty
              ? Center(
                  child: Lottie.asset(
                    "assets/notfound.json",
                    fit: BoxFit.cover,
                    repeat: true,
                    reverse: true,
                  ),
                )
              : GridView.builder(
                  physics: BouncingScrollPhysics(),
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
                            productCategory: data["productCategory"],
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
