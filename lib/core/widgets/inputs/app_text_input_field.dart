import 'package:extra_pos/core/widgets/inputs/base_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextInputField extends StatelessWidget {

  final String? title;
  final String? hint;
  final String? value;
  final String? errorText;
  final Icon? suffixIcon;
  final Function()? onTap;
  TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;

  final ValueChanged<String>? onChanged;

  AppTextInputField({Key? key,
    @required this.title,
    this.hint = '',
    this.value = '',
    this.errorText = '',
    this.onChanged,
    this.suffixIcon,
    this.onTap,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      this.controller = new TextEditingController();
    }
    return BaseInputField(
        title: this.title!,
        errorText: this.errorText!,
        inputControl: TextField(
          enabled: this.enabled,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType ?? TextInputType.text,
          controller: controller,
          onTap: onTap,
          onChanged: onChanged == null ? (value) {} : onChanged,
          decoration: InputDecoration(
              suffixIcon: this.suffixIcon,
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
        ));
  }
}
