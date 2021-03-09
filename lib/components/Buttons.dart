import 'package:flutter/material.dart';
//
import 'package:spark/constants/Colors.dart';
import 'package:spark/components/TextStyles.dart';

///Bottom Button for the Account pages (SignUp & SignIn)
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
    return Container(
      height: 70,
      width: 300,
      decoration: BoxDecoration(
        color: kSparkHeaderRed,
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSparkHeaderRed,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onTap,
        child: Center(
          child: Text(
            title,
            style: CustomTextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ), // Text/Label
      ),
    );
  }
}
