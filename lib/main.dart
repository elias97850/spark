import 'package:flutter/material.dart';
import 'pages/account/SignUpPage.dart';
import 'pages/account/SignInPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //
      initialRoute: SignUpPage.id,
      //
      routes: {
        SignUpPage.id: (context) => SignUpPage(),
        SignInPage.id: (context) => SignInPage(),
      },
    );
  }
}
