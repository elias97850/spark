import 'package:flutter/material.dart';
//
import 'TextStyles.dart';
import 'package:spark/constants/Colors.dart';

///Well... a customizable Alert Dialog xD. You can display information or errors with this, like "the password is incorrect"
Future<Object> CustomAlertDialog({
  @required BuildContext context,
  @required String title,
  @required String content,
  Duration transitionDuration,
  double borderRadius,
  String buttonText,
}) {
  showGeneralDialog(
      barrierColor: Colors.grey.withOpacity(0.1),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,

            child: AlertDialog(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20))),
              backgroundColor: kAppBackgroundColorLite,
              title: Text(title),
              titleTextStyle: CustomTextStyle(fontSize: 20), //20
              content: Text(content),
              contentTextStyle: CustomTextStyle(fontSize: 15), //15
              elevation: 0,
              //Dialog's button configuration
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      buttonText ?? 'OK',
                      style: CustomTextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ), //button customization
                ) //the button
              ],
              actionsPadding: EdgeInsets.all(10),
            ), //the actual alert dialog
          ),
        ); //animation
      },
      transitionDuration: transitionDuration ?? Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {});
}
