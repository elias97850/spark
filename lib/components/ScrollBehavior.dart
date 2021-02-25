import 'package:flutter/material.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

///Used to eliminate the colored bounds in a ListView, or anything scrollable
class CustomScrollConfiguration extends StatelessWidget {
  //
  CustomScrollConfiguration({
    @required this.child,
  });
  //
  final Widget child;
  //
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: child,
    );
  }
}
