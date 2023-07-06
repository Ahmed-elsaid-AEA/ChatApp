// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomMaterialButton extends StatelessWidget {
  CustomMaterialButton({
    super.key,
    this.textButtonColor = Colors.black,
    this.backgroundButton = Colors.white,
    this.widthButton = double.infinity,
    this.hightButton = 50,
    this.raduisButton = 10.0,
    required this.onPressed,
    required this.textButton,
  });
  Color textButtonColor;
  double? hightButton;
  double? widthButton;
  double raduisButton;
  VoidCallback onPressed;
  String textButton;
  Color? backgroundButton;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      textColor: textButtonColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(raduisButton))),
      height: hightButton,
      minWidth: widthButton,
      color: backgroundButton,
      onPressed: onPressed,
      child: Text(textButton),
    );
  }
}
