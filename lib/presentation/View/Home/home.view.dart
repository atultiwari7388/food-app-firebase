import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/presentation/View/Home/Components/card_section.dart';
import 'package:food_app/widgets/grid_view.widget.dart';
import 'package:food_app/widgets/single_product.widget.dart';

UserModel? userModel;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<dynamic> getCurrentUserData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        userModel = UserModel.fromDocument(snapshot);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No such document"),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUserData();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('Explore'),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 20),
          CardSection(),
          SizedBox(height: 20),
          ListTile(
            leading: Text(
              "Categories",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),

          // get category data

          Container(
            height: 100,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("categories")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (!streamSnapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    ),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Categories(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GridViewWidget(
                              collection: streamSnapshot.data!.docs[index]
                                  ["categoryName"],
                              id: streamSnapshot.data!.docs[index].id,
                            ),
                          ),
                        );
                      },
                      categoryName: streamSnapshot.data!.docs[index]
                          ["categoryName"],
                      categoryImage: streamSnapshot.data!.docs[index]
                          ["categoryImage"],
                    );
                  },
                );
              },
            ),
          ),

          ListTile(
            leading: Text(
              "Popular Brands",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),

// get popular product data
          Container(
            height: 180,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("popularBrands")
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (!streamSnapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = streamSnapshot.data!.docs[index];
                      return PopularBrands(
                        brandsImage: data["popularImage"],
                        brandsName: data["popularName"],
                        brandsTiming: data["popularTiming"],
                      );
                    },
                  );
                }),
          ),

          ListTile(
            leading: Text(
              "Picked For You",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),

          // get picked for you data

          Container(
            height: 280,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("products").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (!streamSnapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    ),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return SingleProductWidget(
                      name: streamSnapshot.data!.docs[index]["productName"],
                      image: streamSnapshot.data!.docs[index]["productImage"],
                      price: streamSnapshot.data!.docs[index]["productPrice"],
                    );
                  },
                );
              },
            ),
          ),

          SizedBox(height: 100),
        ],
      ),
    );
  }
}

class PopularBrands extends StatelessWidget {
  const PopularBrands({
    Key? key,
    required this.brandsImage,
    required this.brandsName,
    required this.brandsTiming,
  }) : super(key: key);

  final String? brandsImage;
  final String? brandsName;
  final String? brandsTiming;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 200,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: Colors.red,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Container(
              height: 90,
              width: 95,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    brandsImage!,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            brandsName!,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "$brandsTiming min",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.categoryName,
    required this.categoryImage,
    required this.onTap,
  }) : super(key: key);

  final String? categoryName;
  final String? categoryImage;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(12.0),
        height: 100,
        width: 140,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(categoryImage!), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            categoryName!,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
