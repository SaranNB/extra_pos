import 'package:extra_pos/core/app_assets/app_assets.dart';
import 'package:flutter/material.dart';

class PageHeadingText extends StatelessWidget {

  final String? text;

  const PageHeadingText({Key? key, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    const pageHeadingStyle = TextStyle(
        color: Color(0xff3d404e),
        fontSize: 20.0,
        fontWeight: FontWeight.bold
    );

    return  Text(text!, style: pageHeadingStyle);
  }
}
