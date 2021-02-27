import 'package:flutter/material.dart';

TextStyle CustomTextStyle({Color color, double fontSize, FontWeight fontWeight}) {
  return TextStyle(
    letterSpacing: .5,
    fontFamily: 'TTNorms',
    color: color ?? Colors.white,
    fontSize: fontSize ?? 15,
    fontWeight: fontWeight ?? FontWeight.normal,
  );
}
