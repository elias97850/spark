import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///Simple Scaffold that has control of the statusBar
///(on the phone, where the signal, battery percentage and time are)
class CustomScaffold extends StatelessWidget {
  //
  CustomScaffold({
    @required this.statusBarColor,
    @required this.statusBarIconBrightness,
    @required this.backgroundColor,
    @required this.child,
  });
  //
  final Color statusBarColor;
  final Brightness statusBarIconBrightness;
  final Color backgroundColor;
  final Widget child;
  //
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      ///This edits the overlay where the signal, time, and notifications show at the top
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor.withOpacity(0),
        statusBarIconBrightness: statusBarIconBrightness,
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: child,
        ),
      ),
    );
  }
}
