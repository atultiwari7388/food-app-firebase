import 'package:flutter/material.dart';

class TopComponent extends StatelessWidget {
  const TopComponent({
    Key? key,
    required this.productImage,
  }) : super(key: key);

  final String productImage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(productImage), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
