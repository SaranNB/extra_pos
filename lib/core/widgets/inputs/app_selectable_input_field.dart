import 'package:extra_pos/core/widgets/inputs/base_input_field.dart';
import 'package:flutter/material.dart';

class AppSelectableInputField extends StatelessWidget {
  final String? title;
  final String? hint;
  final String? value;
  final String? errorText;
  final Function()? onTap;
  final Widget? suffixIcon;
  TextEditingController? controller;
  final bool enabled;

  AppSelectableInputField(
      {Key? key,
      @required this.title,
      this.hint,
      this.value,
      this.errorText,
      this.onTap,
      this.controller,
      this.suffixIcon,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      this.controller = TextEditingController();
    }
    controller!.text = value!;
    return BaseInputField(
        title: title!,
        errorText: errorText!,
        inputControl: TextField(
          enabled: this.enabled,
          onTap: onTap,
          controller: controller,
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              filled: true,
              hintStyle: new TextStyle(color: Colors.grey[400]),
              hintText: hint,
              fillColor: Colors.white70),
          readOnly: true,
        ));
  }
}
