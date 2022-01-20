import 'package:extra_pos/core/widgets/inputs/base_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppTwoActionInputField extends StatelessWidget {
  final String? title;
  final String? hint;
  final String? value;
  final String? errorText;
  final Function()? onPrimaryActionPressed;
  final Function()? onSecondaryActionPressed;
  final Widget? primaryActionIcon;
  final Widget? secondaryActionIcon;

  AppTwoActionInputField(
      {Key? key,
      @required this.title,
      this.hint,
      this.value,
      this.errorText,
      this.onPrimaryActionPressed,
      this.onSecondaryActionPressed,
      this.primaryActionIcon,
      this.secondaryActionIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseInputField(
        title: title!,
        errorText: this.errorText!,
        inputControl: Container(
          height: 45.0,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onPrimaryActionPressed,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 8.0),
                  child: _buildPrimaryAction(),
                )),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: onSecondaryActionPressed,
                  child: Row(
                    children: [
                      VerticalDivider(),
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        child: primaryActionIcon,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _buildPrimaryAction() {
    return Row(
      children: [
        Expanded(
            child: Text((value == null || value == '') ? hint : value,
                style: (value == null || value == '')
                    ? TextStyle(color: Colors.grey[400], fontSize: 16.0)
                    : TextStyle(color: Colors.black, fontSize: 16.0))),
        secondaryActionIcon!
      ],
    );
  }
}

class VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 45.0,
      width: 1.0,
      color: Colors.grey,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}

// Container(
// child: TextField(
// controller: controller,
// decoration: InputDecoration(
// suffixIcon: Container(
// width: 100,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Icon(Icons.search),
// VerticalDivider(),
// Container(
// margin: EdgeInsets.only(right: 16),
// child: SvgPicture.asset(
// 'assets/images/action_icons/qr_scan.svg'),
// )
// ],
// ),
// ),
// contentPadding:
// EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
// border: new OutlineInputBorder(
// borderRadius: const BorderRadius.all(
// const Radius.circular(10.0),
// ),
// ),
// filled: true,
// hintStyle: new TextStyle(color: Colors.grey[400]),
// hintText: hint,
// fillColor: Colors.white70),
// readOnly: true,
// ),
// ));
