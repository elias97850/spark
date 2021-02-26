import 'package:flutter/material.dart';
import 'package:spark/components/TextFields.dart';
import 'package:spark/components/Scaffolds.dart';
import 'package:spark/components/ScrollBehavior.dart';
import 'package:spark/components/Buttons.dart';
import 'package:spark/components/Headers.dart';
import 'package:spark/constants/Colors.dart';
import 'SignUpPage.dart';

class SignInPage extends StatefulWidget {
  //
  static final id = 'SignIn';
  //
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //
  IconData visibilityIcon;
  bool passwordObscureText = true;
  int counter = 0;
  FocusNode emailFocus;
  FocusNode passwordFocus;
  //
  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  //
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: kAppBackgroundColor,
      statusBarColor: kAppBackgroundColor,
      statusBarIconBrightness: Brightness.light,
      child: CustomScrollConfiguration(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    //width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        SparkHeader(),
                        SizedBox(height: 15),
                        Header1(title: 'Let\'s sign you in'),
                        SizedBox(height: 10),
                        Header2(title: 'Welcome back, you\'ve been missed!'),
                      ],
                    ),
                  ), //headers
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AccountTextField(
                          context: context,
                          currentFocus: emailFocus,
                          nextFocus: passwordFocus,
                          title: 'Email',
                          hintText: 'example_name123@woogle.com',
                          textInputType: TextInputType.emailAddress,
                          obscureText: false,
                          icon: null,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            //TODO Backend
                          },
                        ), //email
                        SizedBox(height: 20),
                        AccountTextField(
                          currentFocus: passwordFocus,
                          context: context,
                          title: 'Password',
                          hintText: 'Not  \"password123\"  please',
                          textInputType: TextInputType.text,
                          obscureText: passwordObscureText,
                          icon: visibilityIcon,
                          onPressedPasswordIcon: () {
                            setState(() {
                              if (visibilityIcon == Icons.visibility) {
                                //text can be read
                                visibilityIcon = Icons.visibility_off;
                                passwordObscureText = false;
                              } else {
                                //text can't be read
                                visibilityIcon = Icons.visibility;
                                passwordObscureText = true;
                              }
                            });
                          },
                          onChanged: (value) {
                            //TODO Backend
                            setState(() {
                              if (value.length == 1 && counter == 0) {
                                //first time
                                visibilityIcon = Icons.visibility;
                                passwordObscureText = true;
                                counter++;
                              } else if (value.length == 0) {
                                visibilityIcon = null;
                                counter--;
                              }
                            });
                          },
                        ), //password
                        SizedBox(height: 100),
                      ],
                    ),
                  ), //input
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Header2(title: 'Don\'t have an account?'),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, SignUpPage.id);
                              },
                              child: Text(
                                'Sign up!',
                                style: TextStyle(
                                  fontFamily: 'TTNorms',
                                  color: kSparkHeaderRed,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ), //Signup redirection
                          ],
                        ), //h2 of footer
                        SizedBox(height: 15),
                        AccountButton(
                          title: 'Sign In',
                          onTap: () {
                            //TODO Backend
                          },
                        ), //button
                        SizedBox(height: 20),
                      ],
                    ),
                  ), //footer
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //
  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }
}
