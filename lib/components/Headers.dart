import 'package:flutter/material.dart';
//
import 'package:spark/constants/Colors.dart';
import 'package:spark/components/TextStyles.dart';
//
import 'package:animated_text_kit/animated_text_kit.dart';

///Small and red Spark label
class SparkHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'SPARK',
      style: CustomTextStyle(
        color: kSparkHeaderRed,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
    //  TypewriterAnimatedTextKit(
    //   text: [
    //     "SPARK",
    //   ],
    //   textStyle: TextStyle(
    //     fontFamily: 'TTNorms',
    //     color: kSparkHeaderRed,
    //     fontSize: 15,
    //     fontWeight: FontWeight.bold,
    //   ),
    //   textAlign: TextAlign.start,
    //   //isRepeatingAnimation: false,
    //   speed: Duration(milliseconds: 500),
    //   pause: Duration(milliseconds: 500),
    // ),
  }
}

///Big white header
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
      style: CustomTextStyle(
        color: Colors.white,
        fontSize: 29,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

///Small gray header
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
        style: CustomTextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
