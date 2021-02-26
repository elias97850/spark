import 'package:flutter/material.dart';
import 'package:spark/components/TextFields.dart';
import 'package:spark/components/Scaffolds.dart';
import 'package:spark/components/ScrollBehavior.dart';
import 'package:spark/components/Buttons.dart';
import 'package:spark/components/Headers.dart';
import 'package:spark/constants/Colors.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'SignInPage.dart';

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
  int birthdayHolder;
  String dateText;
  bool showDate = false;
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

  void birthdayError() {
    if (birthdayHolder < 18)
      setState(() {
        //TODO
        print("Must be 18 or older to register.");
      });
    else
      setState(() {
        print(birthdayHolder);
      });
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
                          currentFocus: nameFocus,
                          nextFocus: emailFocus,
                          title: 'Name',
                          hintText: 'Example Name',
                          textInputType: TextInputType.text,
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            //TODO Backend
                          },
                        ), //name
                        SizedBox(height: 20),
                        AccountTextField(
                          context: context,
                          currentFocus: emailFocus,
                          nextFocus: passwordFocus,
                          title: 'Email',
                          hintText: 'example_name123@woogle.com',
                          textInputType: TextInputType.emailAddress,
                          obscureText: false,
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
                        SizedBox(height: 20),
                        AccountTextField(
                          isBirth: true,
                          context: context,
                          currentFocus: birthFocus,
                          title: 'Birth Date',
                          hintText: dateText ?? 'dd/mm/yyyy',
                          obscureText: false,
                          onChanged: (value) {
                            //TODO Backend
                          },
                          onTapBirth: () async {
                            //TODO date popup
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
                                  dateText = '${date.day}/${date.month}/${date.year}';
                                  showDate = true;
                                  setDate(year: date.year, month: date.month, day: date.day);
                                  setAge();
                                  birthdayError();
                                }
                              });
                            });
                          },
                        ), //date of birth
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
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, SignInPage.id);
                              },
                              child: Text(
                                'Sign In!',
                                style: TextStyle(
                                  fontFamily: 'TTNorms',
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
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    birthFocus.dispose();
    super.dispose();
  }
}
