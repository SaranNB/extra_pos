import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_action_fab.dart';

class AddActionFab extends StatelessWidget {
  final Function()? onPressed;
  final bool enabled;

  AddActionFab({Key? key, @required this.onPressed, this.enabled: true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionFab(
      enabled: enabled,
      text: 'Add',
      icon: Icon(
        Icons.add,
        size: 24,
        color: _getIconColor(),
      ),
      borderColor: Get.theme.primaryColor,
      buttonColor: _getButtonColor(),
      onPressed: this.onPressed!,
    );
  }

  _getButtonColor() {
    if (!enabled) return Color(0xffeeeeee);

    return Colors.white;
  }

  _getIconColor() {
    if (!enabled) return Colors.grey;

    return Get.theme.primaryColor;
  }
}
