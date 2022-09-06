import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  FollowButton(
      {this.function,
      required this.text,
      required this.backgroundColor,
      required this.borderColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
          width: 250,
          height: 27,
        ),
      ),
    );
  }
}
