// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({
    required this.hintText,
    required this.labelText,
    this.cursorColor = Colors.white,
    this.labelColor = Colors.white,
    this.prefixIconColor = Colors.white,
    this.suffixIconColor  = Colors.white,
    this.hintTextColor = Colors.grey,
    this.enabledBorderColor = Colors.white,
    this.textColor = Colors.white,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.validator,
    this.onPrefixIConPressed,
    this.onSuffixIConPressed,
    this. obscureText=false,
  });
  String? hintText;
  String? labelText;
  Color? cursorColor;
  Color? labelColor;
  Color? hintTextColor;
  IconData? prefixIcon;
  Color? prefixIconColor;
  IconData? suffixIcon;
  Color? suffixIconColor;
  Color? textColor;
  Color enabledBorderColor;
  bool obscureText;
  TextEditingController? controller;
  Function(String)? onChanged;
  Function(String)? onSubmitted;
  Function()? onPrefixIConPressed;
  Function()? onSuffixIConPressed;
   String? Function(String? value)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
obscureText: obscureText,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      onChanged: onChanged,
      style: TextStyle(color: textColor),
      cursorColor: cursorColor,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: labelColor),
        prefixIcon: (prefixIcon!=null)?IconButton(onPressed:onPrefixIConPressed,icon: Icon(prefixIcon), color: prefixIconColor):null,
        suffixIcon: (suffixIcon!=null)?IconButton(onPressed:onSuffixIConPressed,icon: Icon(suffixIcon), color: suffixIconColor):null,

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
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: enabledBorderColor,
            width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
        label: Text('$labelText'),
      ),
    );
  }
}
