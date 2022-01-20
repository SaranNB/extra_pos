import 'package:flutter/material.dart';

class BaseActionBottomBar extends StatelessWidget {

  final List<Widget>? children;

  const BaseActionBottomBar({
    Key? key, this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.only(top: 8),
        height: 96.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children!
        ));
  }
}
