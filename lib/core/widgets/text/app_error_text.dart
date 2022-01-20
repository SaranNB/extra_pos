import 'package:extra_pos/core/app_assets/app_assets.dart';
import 'package:flutter/material.dart';

class AppErrorText extends StatelessWidget {


  final String? text;

  const AppErrorText({Key? key, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    const errorTextStyle = TextStyle(
        color: Colors.redAccent,
        fontSize: 14.0
    );

    return Text('⚠ $text', style: errorTextStyle);
  }
}
