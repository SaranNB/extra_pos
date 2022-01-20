import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'base_action_fab.dart';

class DeleteActionFab extends StatelessWidget {
  final Function()? onPressed;
  final bool enabled;

  DeleteActionFab({Key? key, @required this.onPressed, this.enabled: true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionFab(
      enabled: enabled,
      text: 'Delete',
      icon: SizedBox(
          height: 24,
          width: 24,
          child: SvgPicture.asset(
            'assets/images/action_icons/delete.svg',
            color: _getIconColor(),
          )),
      borderColor: Colors.red,
      buttonColor: _getButtonColor(),
      onPressed: this.onPressed,
    );
  }

  _getButtonColor() {
    if (!enabled) return Color(0xffeeeeee);

    return Colors.red[50];
  }

  _getIconColor() {
    if (!enabled) return Colors.grey;

    return Colors.red;
  }
}
