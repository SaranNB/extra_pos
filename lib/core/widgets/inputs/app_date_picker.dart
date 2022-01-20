import 'package:extra_pos/core/utils/date_time_utils.dart';
import 'package:extra_pos/core/widgets/inputs/base_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppDatePickerField extends StatelessWidget {
  final String? title;
  final String? hint;
  final String? value;
  final String? errorText;
  final DateTime? date;
  TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;

  final Function(DateTime selectedDateTime)? onChanged;

  AppDatePickerField(
      {Key? key,
      @required this.title,
      this.hint = '',
      this.value = '',
      this.errorText = '',
        this.date,
      this.onChanged,
      this.controller,
      this.keyboardType,
      this.inputFormatters,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.onChanged == null ? () {} : this.onChanged;
    if (controller == null) {
      this.controller = new TextEditingController();
    }
    controller!.text = readableDate(this.date!);
    return BaseInputField(
        title: this.title!,
        errorText: this.errorText!,
        inputControl: TextField(
          enabled: this.enabled,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType ?? TextInputType.text,
          controller: controller,
          onTap: () async {
            var selectedDateTime = await _selectDate(Get.context!);
            onChanged!(selectedDateTime);
            if(selectedDateTime != null)
            {
              controller!.text = readableDate(selectedDateTime);
            }
          },
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.date_range),
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

  Future<DateTime> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: this.date ?? currentDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if(pickedDate == null) {
      if(this.date != null)
        return this.date!;
      else
        return null!;
    } else {
      return pickedDate;
    }
  }

}
