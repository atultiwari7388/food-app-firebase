import 'package:flutter/material.dart';
import 'package:food_app/custom/tabs_screen.dart';
import 'package:food_app/provider/cart.procider.dart';
import 'package:food_app/widgets/cart.widget.dart';
import 'package:provider/provider.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();

    //get subtotal func

    double subTotal = cartProvider.subTotal();
    double discountPrice = 18.0;
    int shippingCharges = 40;

    double discountValue = (subTotal * discountPrice) / 100;

    double total = subTotal - discountValue + shippingCharges;

    if (cartProvider.getCartListData.isEmpty) {
      setState(() {
        total = 0.0;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("CheckOut"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: cartProvider.getCartListData.isEmpty
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
          ),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  leading: Text("SubTotal"),
                  trailing: Text(
                    "\₹$subTotal",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: Text("Discount"),
                  trailing: Text("\₹$discountValue"),
                ),
                ListTile(
                  leading: Text("Shipping Charges"),
                  trailing: Text("\₹$shippingCharges"),
                ),
                Divider(thickness: 3.0),
                ListTile(
                  leading: Text("Total Price"),
                  trailing: Text("\₹$total"),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: cartProvider.getCartListData.isEmpty
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.0),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TabsScreen(),
                    ),
                    (route) => false);
              },
              child: Text(
                "Add Items",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.0),
              ),
              onPressed: () {},
              child: Text(
                "Pay",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
    );
  }
}
