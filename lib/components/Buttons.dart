import 'package:flutter/material.dart';
import 'package:spark/constants/Colors.dart';

class AccountButton extends StatelessWidget {
  //
  AccountButton({
    @required this.title,
    @required this.onTap,
  });
  //
  final String title;
  final Function onTap;
  //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: 300,
        decoration: BoxDecoration(
          color: kSparkHeaderRed,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
