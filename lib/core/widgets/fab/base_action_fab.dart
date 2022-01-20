import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ActionFab extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Widget? icon;
  final Color? buttonColor;
  final Color? borderColor;
  final bool? enabled;

  ActionFab({
    Key? key,
    @required this.onPressed,
    @required this.text,
    @required this.icon,
    this.buttonColor,
    this.borderColor,
    this.enabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: borderColor != null
              ? BoxDecoration(
                  border: Border.all(
                    color: _getBorderColor(),
                  ),
                  shape: BoxShape.circle,
                )
              : null,
          child: MaterialButton(
            elevation: 5.0,
            onPressed: _getPressedEvent(),
            color: _getButtonColor(),
            // textColor: this.iconColor != null ? this.iconColor : Colors.grey,
            child: icon,
            padding: EdgeInsets.all(16),
            shape: CircleBorder(),
          ),
        ),
        Container(margin: EdgeInsets.only(top: 8), child: Text(text!)),
      ],
    );
  }

  _getPressedEvent() {
    if(!enabled!) return () {};

    return onPressed ?? () {};
  }

  Color _getBorderColor() {
    if(!this.enabled!) return Color(0xffeeeeee);

    return this.borderColor!;
  }

  Color _getButtonColor() {
    if(!this.enabled!) return Color(0xffeeeeee);

    if(this.buttonColor != null) return this.buttonColor!;
    return Colors.white;
  }
}
