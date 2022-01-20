import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {

  final Function()? onPressed;
  final String? text;

  const SecondaryButton({Key? key, this.onPressed, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: onPressed!,
        child: Text(text!),
        color: Colors.redAccent,
        textColor: Colors.white);
  }
}