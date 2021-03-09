import 'package:flutter/material.dart';

///A customizable TextStyle that has the TTNorms font already
TextStyle CustomTextStyle({Color color, double fontSize, FontWeight fontWeight}) {
  return TextStyle(
    letterSpacing: .5,
    fontFamily: 'TTNorms',
    color: color ?? Colors.white,
    fontSize: fontSize ?? 15,
    fontWeight: fontWeight ?? FontWeight.normal,
  );
}
