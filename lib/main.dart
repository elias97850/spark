import 'package:flutter/material.dart';
import 'pages/account/SignUpPage.dart';
import 'pages/account/SignInPage.dart';
import 'pages/quiz/QuizPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //
      initialRoute: SignInPage.id,
      //
      routes: {
        SignUpPage.id: (context) => SignUpPage(),
        SignInPage.id: (context) => SignInPage(),
        QuizPage.id: (context) => QuizPage(),
      },
    );
  }
}
