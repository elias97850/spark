import 'package:flutter/material.dart';
import 'package:spark/constants/Colors.dart';

class SparkHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'SPARK',
      style: TextStyle(
        fontFamily: 'TTNorms',
        color: kSparkHeaderRed,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class Header1 extends StatelessWidget {
  //
  Header1({this.title});
  //
  final String title;
  //
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'TTNorms',
        color: Colors.white,
        fontSize: 29,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class Header2 extends StatelessWidget {
  //
  Header2({this.title});
  //
  final String title;
  //
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .65,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'TTNorms',
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
