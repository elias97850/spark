import 'package:flutter/material.dart';
import 'package:spark/components/TextFields.dart';
import 'package:spark/components/Scaffolds.dart';
import 'package:spark/components/ScrollBehavior.dart';
import 'package:spark/components/Buttons.dart';
import 'package:spark/components/Headers.dart';
import 'package:spark/constants/Colors.dart';
import 'package:transition/transition.dart';
import 'package:spark/user.dart';
import 'package:string_validator/string_validator.dart';
import 'SignUpPage.dart';
import 'package:spark/components/TextStyles.dart';

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
  String email = '';
  String password = '';

  bool isEmailError = false;
  bool isPasswordError = false;
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
                          textInputAction: TextInputAction.next,
                          formatErrorText: 'Couldn\'t verify email',
                          isFormatErrorText: isEmailError,
                          onChanged: (String value) {
                            setState(() {
                              //
                              //Validation
                              //
                              if (isEmail(value)) {
                                email = value;
                                isEmailError = false;
                              } else {
                                email = '';
                              }
                              print(email);
                            });
                          },
                        ), //email
                        SizedBox(height: 20),
                        AccountTextField(
                          isPasswordTextField: true,
                          currentFocus: passwordFocus,
                          context: context,
                          title: 'Password',
                          hintText: 'We hope you remember this  O.O',
                          textInputType: TextInputType.text,
                          obscureText: passwordObscureText,
                          icon: visibilityIcon,
                          formatErrorText: 'At least 8 characters',
                          isFormatErrorText: isPasswordError,
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
                            setState(() {
                              //
                              //Password's Visibility Algorithm
                              //
                              if (value.length == 1 && counter == 0) {
                                //first time
                                visibilityIcon = Icons.visibility;
                                passwordObscureText = true;
                                counter++;
                              } else if (value.length == 0) {
                                visibilityIcon = null;
                                counter--;
                              }
                              //
                              //Validation
                              //
                              if (value.length > 7 && isAscii(value) && !contains(value, ' ')) {
                                password = value;
                                isPasswordError = false;
                              } else {
                                password = '';
                              }
                              print(password);
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
                                Navigator.push(
                                  context,
                                  Transition(
                                    child: SignUpPage(),
                                    transitionEffect: TransitionEffect.leftToRight,
                                    curve: Curves.decelerate,
                                  ).builder(),
                                );
                              },
                              child: Text(
                                'Sign up!',
                                style: CustomTextStyle(
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
                            setState(() {
                              if (email == '') {
                                isEmailError = true;
                              }
                              if (password == '') {
                                isPasswordError = true;
                              }
                              if (email != '' && password != '') {
                                print('Success!');
                                //TODO Backend
                              }
                            });
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
