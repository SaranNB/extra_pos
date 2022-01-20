import 'package:extra_pos/core/widgets/inputs/base_input_field.dart';
import 'package:flutter/material.dart';

class AppDropdownInputField extends StatefulWidget {
  final String? title;
  final String? hint;
  String? value;
  final List<DropdownModel>? list;
  final String? errorText;

  final ValueChanged<String>? onChanged;

  AppDropdownInputField(
      {Key? key,
      @required this.title,
      this.hint = '',
      this.value = '',
      this.errorText = '',
      this.list,
      this.onChanged})
      : super(key: key);

  @override
  _AppDropdownInputFieldState createState() => _AppDropdownInputFieldState();
}

class _AppDropdownInputFieldState extends State<AppDropdownInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: BaseInputField(
      title: widget.title!,
      errorText: widget.errorText!,
      inputControl: Container(
        child: InputDecorator(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              iconSize: 20,
              style: TextStyle(fontSize: 14.0, color: Colors.black),
              value: widget.value == '' ? null : widget.value,
              isDense: true,
              isExpanded: true,
              onChanged: (newValue) {
                widget.onChanged!(newValue ?? '');
              },
              items: widget.list!.map((item) {
                return DropdownMenuItem(
                  child: Text(item.value!),
                  value: item.id,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    ));
  }
}

class DropdownModel {
  DropdownModel({this.id, this.value});

  final String? id;
  final String? value;
}
