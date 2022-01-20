import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppHeadingText extends StatelessWidget {
  final String? name;

  const AppHeadingText({Key? key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              name!,
              style: TextStyle(
                  color: Get.theme.primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}