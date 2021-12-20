import 'package:flutter/material.dart';
import 'package:food_app/custom/tabs_screen.dart';
import 'package:food_app/presentation/View/CheckOut/checkout.screen.dart';
import 'package:food_app/provider/cart.procider.dart';
import 'package:food_app/widgets/cart.widget.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text('Cart'),
      ),
      bottomSheet: cartProvider.getCartListData.isEmpty
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TabsScreen(),
                    ),
                    (route) => false);
              },
              child: Text("Back to Home"),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckOutScreen(),
                  ),
                );
              },
              child: Text("CHECKOUT"),
            ),
      body: cartProvider.getCartListData.isEmpty
          ? Center(
              child: Text('Cart is empty'),
            )
          : ListView.separated(
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey,
                  height: 1.0,
                );
              },
              itemCount: cartProvider.getCartListData.length,
              itemBuilder: (context, index) {
                var data = cartProvider.cartLists[index];

                // if (!streamSnapshot.hasData) {
                //   return Center(
                //     child: CircularProgressIndicator(),
                //   );
                // }

                return CartWidget(
                  productName: data.productName,
                  productImage: data.productImage,
                  productPrice: data.productPrice,
                  productQuantity: data.productQuantity,
                  productCategory: data.productCategory,
                  productId: data.productId,
                );
              },
            ),
    );
  }
}
