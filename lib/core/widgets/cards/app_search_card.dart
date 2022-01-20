import 'package:flutter/material.dart';

class AppSearchCard extends StatelessWidget {

  final Widget? child;

  const AppSearchCard({Key? key, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow:[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: this.child
    );
  }
}