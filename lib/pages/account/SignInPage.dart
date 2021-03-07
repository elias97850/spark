import 'package:flutter/material.dart';
import 'package:spark/components/AlertDialog.dart';
//
import 'SignUpPage.dart';
import 'package:spark/UserData.dart';
import 'package:spark/constants/Colors.dart';
import 'package:spark/components/Buttons.dart';
import 'package:spark/components/Headers.dart';
import 'package:spark/components/Scaffolds.dart';
import 'package:spark/components/TextFields.dart';
import 'package:spark/components/ScrollBehavior.dart';
import 'package:spark/pages/loading/InitialLoadingPage.dart';
//
import 'package:transition/transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spark/components/TextStyles.dart';
import 'package:string_validator/string_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignInPage extends StatefulWidget {
  //
  static final id = 'SignIn';
  //
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //
  //Booleans for Input Errors
  //
  bool showEmailError = false;
  bool showPasswordError = false;
  //
  //Database
  //
  final _auth = FirebaseAuth.instance;
  //
  //FocusNodes
  //
  FocusNode emailFocus;
  FocusNode passwordFocus;
  //
  //Modal Loading Spinner
  //
  bool showSpinner = false;
  //
  //Password vars
  //
  IconData visibilityIcon;
  bool passwordObscureText = true;
  int counter = 0;
  //
  //User Data
  //
  String email = '';
  String password = '';
  //
  //Build
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
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      opacity: 0.1,
      color: Colors.grey,
      progressIndicator: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(kSparkHeaderRed),
      ),
      child: CustomScaffold(
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
                  //TODO change after WelcomePage has been created and sizes have been taken
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
                            title: 'Email',
                            hintText: 'example_name123@woogle.com',
                            formatErrorText: 'Couldn\'t verify email',
                            showTextFormatError: showEmailError,
                            maxLength: 64,
                            currentFocus: emailFocus,
                            nextFocus: passwordFocus,
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            obscureText: false,
                            onChanged: (String value) {
                              setState(() {
                                //
                                //Validation
                                //
                                if (isEmail(trim(value))) {
                                  email = trim(value);
                                  showEmailError = false;
                                } else {
                                  email = '';
                                }
                                print(email);
                              });
                            },
                          ), //email
                          SizedBox(height: 20),
                          AccountTextField(
                            context: context,
                            title: 'Password',
                            hintText: 'We hope you remember this  O.O',
                            formatErrorText: 'At least 8 characters',
                            showTextFormatError: showPasswordError,
                            maxLength: 20,
                            currentFocus: passwordFocus,
                            textInputType: TextInputType.text,
                            obscureText: passwordObscureText,
                            icon: visibilityIcon,
                            isPasswordTextField: true,
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
                                if (trim(value).length > 7 &&
                                    isAscii(trim(value)) &&
                                    !contains(trim(value), ' ')) {
                                  password = trim(value);
                                  showPasswordError = false;
                                } else {
                                  password = '';
                                }
                                print(password);
                              });
                            },
                          ), //password
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.bottomRight,
                            transformAlignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                //TODO backend of forgot password
                                // Navigator.push(
                                //   context,
                                //   Transition(
                                //     child: SignUpPage(),
                                //     transitionEffect: TransitionEffect.leftToRight,
                                //     curve: Curves.decelerate,
                                //   ).builder(),
                                // );
                              },
                              child: Text(
                                'Forgot your password? ',
                                style: CustomTextStyle(
                                  color: kSparkHeaderRed,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ), //Forgot Password redirection
                          SizedBox(height: 90),
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
                            onTap: () async {
                              setState(() {
                                if (email == '') {
                                  showEmailError = true;
                                }
                                if (password == '') {
                                  showPasswordError = true;
                                }
                              });
                              if (email != '' && password != '') {
                                FocusScope.of(context).unfocus();
                                showSpinner = true;
                                try {
                                  final user = await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                                  //
                                  if (user != null) {
                                    setState(() {
                                      UserData.uid = user.user.uid;
                                      UserData.email = email;
                                      UserData.password = password;
                                      showSpinner = false;
                                    });
                                    Navigator.push(
                                      context,
                                      Transition(
                                        child: InitialLoadingPage(),
                                        transitionEffect: TransitionEffect.bottomToTop,
                                        curve: Curves.decelerate,
                                      ).builder(),
                                    );
                                    print('Success!');
                                  }
                                } catch (e) {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  //too-many-requests
                                  switch (e.code) {
                                    case "invalid-email":
                                      //"Your email address appears to be WEIRD."
                                      CustomAlertDialog(
                                        context: context,
                                        //
                                        title: 'Mmm wait...',
                                        content: 'Your email appears to be WEIRD',
                                      );
                                      break;
                                    case "wrong-password":
                                      //"Your password is incorrect."eliasmarrero98@gmail.com
                                      CustomAlertDialog(
                                        context: context,
                                        //
                                        title: 'Mmm wait...',
                                        content: 'Wrong password! Email\'s ok tho 👌',
                                      );
                                      break;
                                    case "user-not-found":
                                      //"User with this email already exist."
                                      CustomAlertDialog(
                                        context: context,
                                        //
                                        title: 'Mmm wait...',
                                        content: 'The account doesn\'t exist 🙃\n'
                                            'Maybe check your email!',
                                      );
                                      break;
                                    case "too-many-requests":
                                      CustomAlertDialog(
                                        context: context,
                                        //
                                        title: 'Mmm wait...',
                                        content: 'You\'ve failed too much'
                                            '\nTry the "Forgot your password?"',
                                      );
                                      break;
                                    default:
                                      //"Sorry! An error happened on our part."
                                      CustomAlertDialog(
                                        context: context,
                                        //
                                        title: 'Mmm wait...',
                                        content: 'Sorry! An error on our part 😬',
                                        buttonText: 'Try Again',
                                      );
                                      break;
                                  }
                                }
                                setState(() {
                                  showSpinner = false;
                                });
                              }
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
