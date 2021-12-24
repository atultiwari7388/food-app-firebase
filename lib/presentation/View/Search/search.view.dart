import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/View/DetailsPage/details.page.view.dart';
import 'package:food_app/widgets/single_product.widget.dart';
import 'package:lottie/lottie.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String query = "";
  var result;

  searchProducts(query, searchList) {
    result = searchList.where((element) {
      return element["productName"].toUpperCase().contains(query) ||
          element["productName"].toLowerCase().contains(query) ||
          element["productName"].toUpperCase().contains(query) &&
              element["productName"].toLowerCase().contains(query);
    }).toList();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search for food",
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              query == ""
                  ? Lottie.asset("assets/notfo.json", fit: BoxFit.cover)
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("products")
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (!streamSnapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                          var searchData =
                              searchProducts(query, streamSnapshot.data!.docs);
                          return result.isEmpty
                              ? Container(
                                  child: Center(
                                    child: Lottie.asset(
                                      "assets/empty.json",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : GridView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: result.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5.0,
                                    mainAxisSpacing: 5.0,
                                    childAspectRatio: 0.67,
                                  ),
                                  itemBuilder: (context, index) {
                                    var data = searchData[index];
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
                                            productDescription:
                                                data["productDescription"],
                                            productOldPrice:
                                                data["productOldPrice"],
                                            productPrice: data["productPrice"],
                                            productRating:
                                                data["productRating"],
                                            productId: data["productId"],
                                            productCategory:
                                                data["productCategory"],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
