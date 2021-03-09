import 'package:flutter/material.dart';
import 'package:spark/pages/account/SignInPage.dart';
//
import 'components/AlertDialog.dart';
//
import 'package:transition/transition.dart';
import 'package:firebase_auth/firebase_auth.dart';

//
// Database vars
//
final _auth = FirebaseAuth.instance;
User loggedInUser;
//
// Functions
//
///Function that verifies if there's a user signed in
void getCurrentUser({@required BuildContext context}) {
  try {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      //print('SUCCESS! - ${loggedInUser.email}');
    } else {
      CustomAlertDialog(
        context: context,
        title: 'Mmm wait...',
        content: 'Seems like you aren\'t -Signed In-'
            '\nSigning out...',
      );
      Navigator.pushReplacement(
        context,
        Transition(
          child: SignInPage(),
          transitionEffect: TransitionEffect.leftToRight,
          curve: Curves.decelerate,
        ).builder(),
      );
    }
  } catch (e) {
    CustomAlertDialog(
      context: context,
      title: 'Mmm wait...',
      content: 'Seems like you aren\'t -Signed In-'
          '\nSigning out...',
    );
    Navigator.pushReplacement(
      context,
      Transition(
        child: SignInPage(),
        transitionEffect: TransitionEffect.leftToRight,
        curve: Curves.decelerate,
      ).builder(),
    );
  }
}
