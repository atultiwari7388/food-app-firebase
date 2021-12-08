import 'package:flutter/material.dart';

class FilledButtonWidget extends StatelessWidget {
  const FilledButtonWidget(
      {required this.btnName, required this.onPressed, Key? key})
      : super(key: key);
  final String? btnName;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
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
