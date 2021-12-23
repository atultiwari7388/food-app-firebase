import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/presentation/View/DetailsPage/details.page.view.dart';
import 'package:food_app/presentation/View/Home/Components/card_section.dart';
import 'package:food_app/presentation/View/Profile/profile.view.dart';
import 'package:food_app/widgets/grid_view.widget.dart';
import 'package:food_app/widgets/single_product.widget.dart';

late UserModel userModel;

Size? size;

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

  Widget getCategoriesData() {
    return Column(
      children: [
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
          height: size!.height * 0.14,
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("categories").snapshots(),
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
                            collection: "categories",
                            id: streamSnapshot.data!.docs[index].id,
                            productCategory: streamSnapshot.data!.docs[index]
                                ["categoryName"],
                            firebaseSubCollectionName: streamSnapshot
                                .data!.docs[index]["categoryName"],
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
      ],
    );
  }

  Widget getPopularProduct(
      {required Stream<QuerySnapshot<Map<String, dynamic>>>? stream}) {
    return Container(
      // FirebaseFirestore.instance.collection("popularBrands").snapshots(),
      height: 180,
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
        },
      ),
    );
  }

  Widget getAllProductData(
      {required Stream<QuerySnapshot<Map<String, dynamic>>>? stream}) {
    return Container(
      height: size!.height / 2 - 90,
      child: StreamBuilder(
        stream: stream,
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
              var data = streamSnapshot.data!.docs[index];
              return SingleProductWidget(
                name: data["productName"],
                image: data["productImage"],
                price: data["productPrice"],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      productImage: data["productImage"],
                      productName: data["productName"],
                      productDescription: data["productDescription"],
                      productOldPrice: data["productOldPrice"],
                      productPrice: data["productPrice"],
                      productRating: data["productRating"],
                      productId: data["productId"],
                      productCategory: data["productCategory"],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUserData();
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('Explore'),
        actions: [
          PopupMenuButton<int>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(IconlyBold.profile, color: Colors.green),
                        const SizedBox(width: 12),
                        Text("Profile"),
                      ],
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(IconlyBold.logout, color: Colors.red),
                        const SizedBox(width: 12),
                        Text("LogOut"),
                      ],
                    ),
                  ),
                ];
              })
        ],
      ),
      body: ListView(
        // physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 20),
          CardSection(),
          SizedBox(height: 20),
          //categories data
          getCategoriesData(),
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
          getPopularProduct(
            stream: FirebaseFirestore.instance
                .collection("popularBrands")
                .snapshots(),
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

          getAllProductData(
            stream:
                FirebaseFirestore.instance.collection("products").snapshots(),
          ),

          ListTile(
            leading: Text(
              "Best Rating",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),

          // get best selling product

          getAllProductData(
            stream: FirebaseFirestore.instance
                .collection("products")
                .where("productRating", isGreaterThan: 3.5)
                .orderBy("productRating", descending: true)
                .snapshots(),
          ),

          SizedBox(height: 100),
        ],
      ),
    );
  }
}

// onselected function for appbar

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileView(),
        ),
      );
      break;

    case 1:
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("LogOut"),
            content: Text("Are you sure you want to logout?"),
            actions: [
              CupertinoDialogAction(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                child: Text("Logout"),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  FirebaseAuth.instance.signOut().then(
                        (value) => Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/welcome",
                          (route) => false,
                        ),
                      );
                },
              ),
            ],
          );
        },
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
      // height: 200,
      width: size!.width / 2 - 80,
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
        width: size!.width / 2 - 10,
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
