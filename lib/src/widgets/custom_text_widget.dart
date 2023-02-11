import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Ktext extends StatelessWidget {
  Ktext({
    super.key,
    required this.text,
    this.fontColor = Colors.white38,
    this.fontSize = 20,
    this.fontWeight = FontWeight.normal,
  });

  String text;
  double fontSize;
  Color fontColor;
  FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize, fontWeight: fontWeight, color: fontColor),
    );
  }
}
