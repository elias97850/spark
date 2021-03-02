import 'package:flutter/material.dart';
import 'package:spark/components/Scaffolds.dart';
import 'package:spark/constants/Colors.dart';

class QuizPage extends StatefulWidget {
  //
  static String id = 'quiz';
  //
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      statusBarColor: kAppBackgroundColor,
      statusBarIconBrightness: Brightness.light,
      backgroundColor: kAppBackgroundColor,
      child: Container(
        color: kSparkHeaderRed,
        width: 20,
        height: 20,
      ),
    );
  }
}
