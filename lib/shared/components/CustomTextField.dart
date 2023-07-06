// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.cursorColor = Colors.white,
    this.labelColor = Colors.white,
    this.prefixIconColor = Colors.white,
    this.hintTextColor = Colors.white,
    this.enabledBorderColor = Colors.white,
    this.textColor = Colors.white,
    this.prefixIcon,
    this.onChanged,
  });
  String? hintText;
  String? labelText;
  Color? cursorColor;
  Color? labelColor;
  Color? hintTextColor;
  IconData? prefixIcon;
  Color? prefixIconColor;
  Color? textColor;
  Color enabledBorderColor;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: TextStyle(color: textColor),
      cursorColor: cursorColor,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: labelColor),
        prefixIcon: Icon(prefixIcon, color: prefixIconColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: enabledBorderColor,
            width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: hintTextColor),
        border: const OutlineInputBorder(),
        label: Text('$labelText'),
      ),
    );
  }
}
