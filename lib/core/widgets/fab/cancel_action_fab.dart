import 'package:flutter/material.dart';
import 'base_action_fab.dart';

class CancelActionFab extends StatelessWidget {
  final Function()? onPressed;
  final bool enabled;

  CancelActionFab({Key? key, @required this.onPressed, this.enabled: true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionFab(
      enabled: enabled,
      text: 'Cancel',
      icon: Icon(
        Icons.clear,
        size: 24,
        color: _getIconColor(),
      ),
      borderColor: Colors.red,
      buttonColor: _getButtonColor(),
      onPressed: this.onPressed,
    );
  }

  _getButtonColor() {
    if (!enabled) return Color(0xffeeeeee);

    return Colors.white;
  }

  _getIconColor() {
    if (!enabled) return Colors.grey;

    return Colors.red;
  }
}