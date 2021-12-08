import 'package:flutter/material.dart';

class OutlineButtonWidget extends StatelessWidget {
  const OutlineButtonWidget({
    Key? key,
    required this.btnName,
    required this.onPressed,
  }) : super(key: key);

  final String? btnName;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 45,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          btnName!,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
