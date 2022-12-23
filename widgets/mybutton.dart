import 'dart:ui';

import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback works;
  Mybutton(
      {required this.text,
      required this.buttonColor,
      required this.textColor,
      required this.works});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: works,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 20),
      ),
    );
  }
}
