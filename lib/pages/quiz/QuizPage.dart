import 'package:flutter/material.dart';
//
import 'package:spark/constants/Colors.dart';
import 'package:spark/DatabaseFunctions.dart';
import 'package:spark/components/Scaffolds.dart';
//
import 'package:firebase_auth/firebase_auth.dart';

class QuizPage extends StatefulWidget {
  //
  static String id = 'quiz';
  //
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  //
  //Database vars
  //
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  //
  //Build
  //
  @override
  void initState() {
    super.initState();
    //
    getCurrentUser(context: context);
  }

  //
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
        child: FloatingActionButton(
          onPressed: () {
            _auth.signOut();
            Navigator.pop(context);
          },
        ),
      ), //TODO bs thingy (delete)
    );
  }
}
