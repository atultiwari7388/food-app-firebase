import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/presentation/View/Home/Components/card_section.dart';
import 'package:food_app/widgets/drawer.dart';

late UserModel userModel;

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
        elevation: 0,
        title: Text('Explore'),
      ),
      drawer: CustomDrawer(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 20),
          CardSection(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 3,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search for food",
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
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
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Categories(
                  categoryName: "Pizza",
                  categoryImage:
                      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.uXiVr7b9UfFVgcqJUWhDjwHaE8%26pid%3DApi&f=1",
                ),
                Categories(
                  categoryName: "Burger",
                  categoryImage:
                      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcmx.weightwatchers.com%2Fassets-proxy%2Fweight-watchers%2Fimage%2Fupload%2Fv1594406683%2Fvisitor-site%2Fprod%2Fca%2Fburgers_mobile_my18jv&f=1&nofb=1",
                ),
                Categories(
                  categoryName: "Kurkure",
                  categoryImage:
                      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fmedia.naheed.pk%2Fcatalog%2Fproduct%2Fcache%2F49dcd5d85f0fa4d590e132d0368d8132%2F1%2F1%2F1138846-1.jpg&f=1&nofb=1",
                ),
                Categories(
                  categoryName: "Pepsi",
                  categoryImage:
                      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fdehayf5mhw1h7.cloudfront.net%2Fwp-content%2Fuploads%2Fsites%2F114%2F2017%2F03%2F22172858%2Fshutterstock_603255458.jpg&f=1&nofb=1",
                )
              ],
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
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                PopularBrands(
                  brandsImage:
                      "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fbolognapac.com%2Fwp-content%2Fuploads%2F2013%2F03%2Fdominos-logo.jpg&f=1&nofb=1",
                  brandsName: "Dominos",
                  brandsPrice: "30 mins",
                ),
                PopularBrands(
                  brandsImage:
                      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.dontwasteyourmoney.com%2Fwp-content%2Fuploads%2F2017%2F07%2F807807014_sandwich-subway.jpg&f=1&nofb=1",
                  brandsName: "Subway",
                  brandsPrice: "30 mins",
                ),
                PopularBrands(
                  brandsImage:
                      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimg.etimg.com%2Fthumb%2Fmsid-65851090%2Cwidth-300%2Cimgsize-129835%2Cresizemode-4%2Ffaasos.jpg&f=1&nofb=1",
                  brandsName: "Fasoos",
                  brandsPrice: "30 mins",
                ),
                PopularBrands(
                  brandsImage:
                      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fheavy.com%2Fwp-content%2Fuploads%2F2019%2F02%2Fpizza-hut-e1549119164344.jpg%3Fresize%3D2048&f=1&nofb=1",
                  brandsName: "Pizza Hut",
                  brandsPrice: "30 mins",
                ),
              ],
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
    required this.brandsPrice,
  }) : super(key: key);

  final String? brandsImage;
  final String? brandsName;
  final String? brandsPrice;

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
            brandsPrice!,
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
  }) : super(key: key);

  final String? categoryName;
  final String? categoryImage;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
