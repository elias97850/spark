import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spark/constants/Colors.dart';
import 'package:spark/components/TextStyles.dart';

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
      child: RaisedButton(
        color: kSparkHeaderRed,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
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
        ),
      ),
    );
    //   GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     height: 70,
    //     width: 300,
    //     decoration: BoxDecoration(
    //       color: kSparkHeaderRed,
    //       borderRadius: BorderRadius.all(Radius.circular(10)),
    //     ),
    //     child: Center(
    //       child: Text(
    //         title,
    //         style: CustomTextStyle(
    //           color: Colors.white,
    //           fontSize: 18,
    //           fontWeight: FontWeight.w600,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
