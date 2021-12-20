import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food_app/presentation/View/Cart/cart.view.dart';
import 'package:food_app/presentation/View/Home/home.view.dart';
import 'package:food_app/presentation/View/Search/search.view.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int currentIndex = 0;

  final screens = [
    HomeView(),
    SearchView(),
    CartView(),
    // ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(currentIndex == 0 ? IconlyBold.home : IconlyLight.home),
            label: "Home",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(
                currentIndex == 1 ? IconlyBold.search : IconlyLight.search),
            label: "Search",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(currentIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
            label: "Cart",
            backgroundColor: Colors.blue,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //       currentIndex == 3 ? IconlyBold.profile : IconlyLight.profile),
          //   label: "Profile",
          //   backgroundColor: Colors.blue,
          // ),
        ],
      ),
    );
  }
}
