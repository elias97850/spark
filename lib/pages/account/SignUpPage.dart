import 'package:flutter/material.dart';
import 'package:spark/components/TextFields.dart';
import 'package:spark/components/Scaffolds.dart';
import 'package:spark/components/ScrollBehavior.dart';
import 'package:spark/components/Buttons.dart';
import 'package:spark/components/Headers.dart';
import 'package:spark/constants/Colors.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:transition/transition.dart';
import 'package:spark/components/TextStyles.dart';
import 'SignInPage.dart';
import 'package:string_validator/string_validator.dart';
import 'package:spark/user.dart';

class SignUpPage extends StatefulWidget {
  //
  static final id = 'SignUp';
  //
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //
  IconData visibilityIcon;
  bool passwordObscureText = true;
  int counter = 0;
  FocusNode nameFocus;
  FocusNode emailFocus;
  FocusNode passwordFocus;
  FocusNode birthFocus;
  int dateYear;
  int dateMonth;
  int dateDay;
  bool showDate = false;
  //
  String dateText;
  int birthdayHolder;

  bool showNameError = false;
  bool showEmailError = false;
  bool showPasswordError = false;
  bool showBirthDateError = false;
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
                            //TODO animate appearance of error
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
                                  User.name = trim(value);
                                  showNameError = false;
                                } else {
                                  User.name = '';
                                }
                              });
                              print(User.name);
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
                                User.email = trim(value);
                                showEmailError = false;
                              } else {
                                User.email = '';
                              }
                              print(User.email);
                            });
                          },
                        ), //email
                        SizedBox(height: 20),
                        AccountTextField(
                          context: context,
                          title: 'Password',
                          hintText: 'Not  \"password123\"  please',
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
                                User.password = trim(value);
                                showPasswordError = false;
                              } else {
                                User.password = '';
                              }
                              print(User.password);
                            });
                          },
                        ), //password
                        SizedBox(height: 20),
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
                                    User.birthDate = dateText;
                                    User.age = birthdayHolder;
                                    showBirthDateError = false;
                                  } else {
                                    User.birthDate = '';
                                    User.age = 0;
                                  }
                                  print(User.birthDate);
                                  print(User.age);
                                }
                              });
                            });
                          },
                        ), //birth date
                        SizedBox(height: 50),
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
                          onTap: () {
                            setState(() {
                              if (User.name == '') {
                                showNameError = true;
                              }
                              if (User.email == '') {
                                showEmailError = true;
                              }
                              if (User.password == '') {
                                showPasswordError = true;
                              }
                              if (User.age == 0) {
                                showBirthDateError = true;
                              }
                              if (User.name != '' &&
                                  User.email != '' &&
                                  User.password != '' &&
                                  User.age >= 18) {
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
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    birthFocus.dispose();
    super.dispose();
  }
}
