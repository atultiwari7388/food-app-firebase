import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/custom/tabs_screen.dart';
import 'package:food_app/provider/cart.provider.dart';
import 'package:food_app/widgets/cart.widget.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  late Razorpay razorpay;
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_xLObtDVYuUA0Ry',
      'amount': num.parse(totalPrice.toString()).toInt() * 100,
      'name': 'Food Order',
      'description': 'Product Description',
      'prefill': {
        'contact': '+916307537145',
        'email': 'tiwariatul9526@gmail.com',
      },
      'external': {
        'wallets': ['paytm', 'phonepe', 'googlepay'],
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Payment Successful'),
          content: Text('Your order has been placed successfully'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Payment Failed'),
          content: Text('Your order has been failed'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Something Error'),
          content: Text('External Error'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();

    //get subtotal func

    double subTotal = cartProvider.subTotal();
    double discountPrice = 18.0;
    int shippingCharges = 1;

    double discountValue = (subTotal * discountPrice) / 100;

    totalPrice = subTotal - discountValue + shippingCharges;

    if (cartProvider.getCartListData.isEmpty) {
      setState(() {
        totalPrice = 0.0;
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
                  leading: Text(
                    "SubTotal",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Text(
                    "\???$subTotal",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: Text(
                    "Discount",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Text(
                    "\???$discountValue",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: Text(
                    "Shipping Charges",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Text(
                    "\???$shippingCharges",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(thickness: 3.0),
                ListTile(
                  leading: Text(
                    "Your Price",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "\???$totalPrice",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
              onPressed: () {
                openCheckout();
              },
              child: Text(
                "Pay",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
    );
  }
}
