import 'package:flutter/material.dart';

class AppSpacing extends StatelessWidget {
  final Widget? child;

  const AppSpacing({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 14.0), child: this.child);
  }
}
