import 'package:extra_pos/core/app_assets/app_assets.dart';
import 'package:flutter/material.dart';

class PageSubHeadingText extends StatelessWidget {

  final String? text;

  const PageSubHeadingText({Key? key, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    const pageSubHeadingStyle = TextStyle(
        color: Color(0xff3d404e),
        fontSize: 18.0,
        fontWeight: FontWeight.bold
    );

    return  Text(text!, style: pageSubHeadingStyle);
  }
}
