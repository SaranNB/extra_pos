import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'base_action_fab.dart';

class SaveAndContinueActionFab extends StatelessWidget {
  final Function()? onPressed;
  final bool enabled;

  SaveAndContinueActionFab({Key? key, @required this.onPressed, this.enabled: true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionFab(
      enabled: enabled,
      text: 'Sv.Cont',
      icon: SizedBox(
          height: 24,
          width: 24,
          child: SvgPicture.asset(
            'assets/images/action_icons/save_and_continue.svg',
            color: _getIconColor(),
          )),
      borderColor: Get.theme.primaryColor,
      buttonColor: _getButtonColor(),
      // iconColor: Colors.white,
      onPressed: this.onPressed,
    );
  }

  _getButtonColor() {
    if (!enabled) return Color(0xffeeeeee);

    return Get.theme.primaryColor;
  }

  _getIconColor() {
    if (!enabled) return Colors.grey;

    return Colors.white;
  }
}