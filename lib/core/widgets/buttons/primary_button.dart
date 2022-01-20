import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final double? height;

  const PrimaryButton({Key? key, this.onPressed, @required this.text, this.height: 48})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.height,
      child: RaisedButton(
        onPressed: onPressed!,
        child: Text(text!, style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold)),
        color: Get.theme.primaryColor,
        textColor: Colors.white,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            // side: BorderSide(color: Colors.white)
        ),
      ),
    );
  }
}
