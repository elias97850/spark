import 'package:flutter/material.dart';
//
import 'SignInPage.dart';
import 'package:spark/UserData.dart';
import 'package:spark/constants/Colors.dart';
import 'package:spark/components/Headers.dart';
import 'package:spark/components/Buttons.dart';
import 'package:spark/pages/quiz/QuizPage.dart';
import 'package:spark/components/Scaffolds.dart';
import 'package:spark/components/TextFields.dart';
import 'package:spark/components/TextStyles.dart';
import 'package:spark/components/ScrollBehavior.dart';
//
import 'package:transition/transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:string_validator/string_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';

class SignUpPage extends StatefulWidget {
  //
  static final id = 'SignUp';
  //
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //
  //Booleans for Input Errors
  //
  bool showNameError = false;
  bool showEmailError = false;
  bool showPasswordError = false;
  bool showBirthDateError = false;
  //
  //Database
  //
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  //
  //Date vars
  //
  int dateDay;
  int dateYear;
  int dateMonth;
  int birthdayHolder;
  String dateText;
  bool showDate = false;
  //
  //FocusNodes
  //
  FocusNode nameFocus;
  FocusNode emailFocus;
  FocusNode passwordFocus;
  FocusNode birthFocus;
  //
  //Modal Loading Spinner
  //
  bool showSpinner = false;
  //
  //Password vars
  //
  int counter = 0;
  String passwordHolder;
  IconData visibilityIcon;
  bool passwordObscureText = true;
  double passwordStrengthHolder = 0;
  //
  //User Data
  //
  int age = 0;
  String name = '';
  String email = '';
  String password = '';
  String birthDate = '';
  //
  //Functions
  //
  ///Sets the date into the vars
  void setDate({year, month, day}) {
    dateYear = year;
    dateMonth = month;
    dateDay = day;
  }

  ///Formats the age and adds it into the vars
  void setAge() {
    if ((DateTime.now().month - dateMonth) < 0)
      birthdayHolder = ((DateTime.now().year - dateYear) - 1);
    else if ((DateTime.now().month - dateMonth) == 0) {
      if ((DateTime.now().day - dateDay) < 0) birthdayHolder = ((DateTime.now().year - dateYear) - 1);
      if ((DateTime.now().day - dateDay) >= 0) birthdayHolder = (DateTime.now().year - dateYear);
    } else if ((DateTime.now().month - dateMonth) > 0) birthdayHolder = (DateTime.now().year - dateYear);
  }

  //
  //Build
  //
  @override
  void initState() {
    super.initState();
    nameFocus = FocusNode();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    birthFocus = FocusNode();
  }

  //
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      opacity: .1,
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
                          Header1(title: 'Let\'s create your Spark account'),
                        ],
                      ),
                    ), //headers
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AccountTextField(
                              context: context,
                              title: 'F. Name',
                              hintText: 'Example Name',
                              formatErrorText: 'Only letters (a-z, A-Z)',
                              showTextFormatError: showNameError,
                              maxLength: 15,
                              currentFocus: nameFocus,
                              nextFocus: emailFocus,
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              onChanged: (value) {
                                setState(() {
                                  //
                                  //Validation
                                  //
                                  if (isAlpha(trim(value))) {
                                    name = trim(value);
                                    showNameError = false;
                                  } else {
                                    name = '';
                                  }
                                });
                                print(name);
                              } // cleans the vars
                              ), //name
                          SizedBox(height: 20),
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
                            hintText: 'Not  \"password123\"  please',
                            formatErrorText: '(a-z, A-Z, 0-9, symbols)',
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
                                passwordHolder = value;
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
                                    !contains(trim(value), ' ') &&
                                    passwordStrengthHolder > 0.5) {
                                  password = trim(value);
                                  showPasswordError = false;
                                } else {
                                  password = '';
                                }
                                print(password);
                              });
                            },
                          ), //password
                          SizedBox(height: 5),
                          Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: FlutterPasswordStrength(
                                strengthCallback: (value) {
                                  passwordStrengthHolder = value;
                                },
                                backgroundColor: kAppBackgroundColor,
                                password: passwordHolder,
                                radius: 10,
                                strengthColors: TweenSequence<Color>(
                                  [
                                    TweenSequenceItem(
                                      weight: 1.0,
                                      tween: ColorTween(
                                        begin: Colors.red,
                                        end: Colors.yellow,
                                      ),
                                    ),
                                    TweenSequenceItem(
                                      weight: 1.0,
                                      tween: ColorTween(
                                        begin: Colors.yellow,
                                        end: Colors.green,
                                      ),
                                    ),
                                    TweenSequenceItem(
                                      weight: 1.0,
                                      tween: ColorTween(
                                        begin: Colors.green,
                                        end: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ), //password strength bar
                          SizedBox(height: 15),
                          AccountTextField(
                            context: context,
                            title: 'Birth Date',
                            hintText: dateText ?? 'dd/mm/yyyy',
                            formatErrorText: 'Only for 18+',
                            showTextFormatError: showBirthDateError,
                            maxLength: 15,
                            currentFocus: birthFocus,
                            obscureText: false,
                            isBirthTextField: true,
                            onChanged: (value) {},
                            onTapBirthTextField: () async {
                              await DatePicker.showSimpleDatePicker(
                                context,
                                looping: true,
                                backgroundColor: kAppBackgroundColor,
                                textColor: Colors.white,
                                titleText: 'Select your Birth Date',
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now(),
                                dateFormat: "dd-MMMM-yyyy",
                                //looping: true,
                              ).then((date) {
                                setState(() {
                                  if (date != null) {
                                    //
                                    //Date Calculation
                                    //
                                    dateText = '${date.day}/${date.month}/${date.year}';
                                    showDate = true;
                                    setDate(year: date.year, month: date.month, day: date.day);
                                    setAge();
                                    //
                                    //Validation
                                    //
                                    if (birthdayHolder >= 18) {
                                      birthDate = dateText;
                                      age = birthdayHolder;
                                      showBirthDateError = false;
                                    } else {
                                      birthDate = '';
                                      age = 0;
                                    }
                                    print(birthDate);
                                    print(age);
                                  }
                                });
                              });
                            },
                          ), //birth date
                          SizedBox(height: 40),
                        ],
                      ),
                    ), //input
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Header2(title: 'Already have an account?'),
                              SizedBox(width: 5),
                              // OpenContainer(
                              //   transitionType: ContainerTransitionType.fade,
                              //   closedElevation: 0,
                              //   openElevation: 0,
                              //   closedColor: kAppBackgroundColor,
                              //   openColor: kAppBackgroundColor,
                              //   transitionDuration: Duration(milliseconds: 800),
                              //   closedBuilder: (context, openWidget) {
                              //     //Normal Widget
                              //     return Text(
                              //       'Sign In!',
                              //       style: TextStyle(
                              //         fontFamily: 'TTNorms',
                              //         color: kSparkHeaderRed,
                              //         fontSize: 15,
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     );
                              //   },
                              //   openBuilder: (context, closedWidget) {
                              //     //New Widget
                              //     return SignInPage();
                              //   },
                              // ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    Transition(
                                      child: SignInPage(),
                                      transitionEffect: TransitionEffect.rightToLeft,
                                      curve: Curves.decelerate,
                                    ).builder(),
                                  );
                                },
                                child: Text(
                                  'Sign In!',
                                  style: CustomTextStyle(
                                    color: kSparkHeaderRed,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ), //SignIn redirection
                            ],
                          ), //h2 of footer
                          SizedBox(height: 15),
                          AccountButton(
                            title: 'Sign Up',
                            onTap: () async {
                              setState(() {
                                if (name == '') {
                                  showNameError = true;
                                }
                                if (email == '') {
                                  showEmailError = true;
                                }
                                if (password == '') {
                                  showPasswordError = true;
                                }
                                if (age == 0) {
                                  showBirthDateError = true;
                                }
                              });
                              if (name != '' && email != '' && password != '' && age >= 18) {
                                FocusScope.of(context).unfocus();
                                showSpinner = true;
                                try {
                                  final newUser = await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                                  //
                                  //Save the User.vars in the DB
                                  //
                                  if (newUser != null) {
                                    setState(() {
                                      UserData.uid = newUser.user.uid;
                                      UserData.name = name;
                                      UserData.email = email;
                                      UserData.password = password;
                                      UserData.birthDate = birthDate;
                                      UserData.age = age;
                                      //We upload this vars to the db to keep track of the account's completion
                                      UserData.quizCompleted = false;
                                      UserData.tagsCompleted = false;
                                      UserData.setUpCompleted = false;
                                      //
                                      try {
                                        _firestore.collection('users').doc(UserData.uid).set({
                                          'uid': UserData.uid,
                                          'name': UserData.name,
                                          'email': UserData.email,
                                          'password': UserData.password,
                                          'birthDate': UserData.birthDate,
                                          'age': UserData.age,
                                          'quizCompleted': UserData.quizCompleted,
                                          'tagsCompleted': UserData.tagsCompleted,
                                          'setUpCompleted': UserData.setUpCompleted,
                                        });
                                      } catch (e) {
                                        //TODO handle error, maybe knowing what the type of errors are (e), then if else for every option
                                      }
                                      //
                                      showSpinner = false;
                                    });
                                    //
                                    Navigator.push(
                                      context,
                                      Transition(
                                        child: QuizPage(),
                                        transitionEffect: TransitionEffect.scale,
                                        curve: Curves.decelerate,
                                      ).builder(),
                                    );
                                    //
                                    print('Success!');
                                  }
                                } catch (e) {
                                  setState(() {
                                    showSpinner = false;
                                  });

                                  print(e);
                                  //TODO handle error, maybe knowing what the type of errors are (e), then if else for every option
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
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    birthFocus.dispose();
    super.dispose();
  }
}
