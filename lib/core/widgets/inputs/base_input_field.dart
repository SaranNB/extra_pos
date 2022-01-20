import 'package:extra_pos/core/widgets/spacing/app_spacing.dart';
import 'package:flutter/material.dart';

class BaseInputField extends StatelessWidget {
  final String? title;
  final String? hint;
  final String? errorText;
  final Widget? inputControl;

  const BaseInputField(
      {Key? key,
      @required this.title,
      this.hint = '',
      this.errorText = '',
      @required this.inputControl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const inputFieldErrorTextTopHeight = 4.0;
    const inputFieldErrorTextStyle =
        TextStyle(color: Colors.redAccent, fontSize: 14.0);

    const inputFieldTitleBottomHeight = 4.0;
    const inputFieldTitleStyle =
        TextStyle(color: Color(0xff9C9C9C), fontSize: 16.0);

    return AppSpacing(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title!, style: inputFieldTitleStyle),
          SizedBox(height: inputFieldTitleBottomHeight),
          inputControl!,
          (this.errorText != null && this.errorText != '')
              ? SizedBox(height: inputFieldErrorTextTopHeight)
              : Container(),
          (this.errorText != null && this.errorText != '')
              ? Text('⚠ $errorText', style: inputFieldErrorTextStyle)
              : Container(),
        ],
      ),
    );
  }
}
