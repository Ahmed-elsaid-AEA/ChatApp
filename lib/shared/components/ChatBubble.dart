import 'package:chatapp/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({
    required this.text,
    required this.email,
    this.bacgroundColor = kMainColor,

  });

  String? text;String? email;
  Color? bacgroundColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 320),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bacgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Text(
              text!,
              style: TextStyle(
                height: 1.6,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              email!,
              style: TextStyle(
                decoration: TextDecoration.overline,
                height: 1.6,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  ChatBubbleForFriend({
    required this.text,
    required this.email,
    this.bacgroundColor = Colors.orange,
  });

  String? text;
  String? email;
  Color? bacgroundColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: 320),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bacgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Text(
              text!,
              style: TextStyle(
                height: 1.6,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Text(
              email!,
              style: TextStyle(
                decoration: TextDecoration.overline,
                height: 1.6,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
