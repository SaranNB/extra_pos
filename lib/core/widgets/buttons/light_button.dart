import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LightButton extends StatelessWidget {

  final Function()? onPressed;
  final String? text;

  const LightButton({Key? key, required this.onPressed, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: onPressed!,
        child: Text(text!),
        color: Colors.white,
        textColor: Get.theme.primaryColor);
  }
}