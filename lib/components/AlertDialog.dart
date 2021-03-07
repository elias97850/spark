import 'package:flutter/material.dart';
import 'package:spark/constants/Colors.dart';
import 'TextStyles.dart';

Future<Object> CustomAlertDialog({
  @required BuildContext context,
  @required String title,
  @required String content,
  Duration transitionDuration,
  double borderRadius,
  String buttonText,
}) {
  showGeneralDialog(
      barrierColor: Colors.grey.withOpacity(0.1), //0.5
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20))), //20
              backgroundColor: kAppBackgroundColorLite,
              title: Text(title),
              titleTextStyle: CustomTextStyle(fontSize: 20), //20
              content: Text(content),
              contentTextStyle: CustomTextStyle(fontSize: 15), //15
              elevation: 0,
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
                  ),
                )
              ],
              actionsPadding: EdgeInsets.all(10),
            ),
          ),
        );
      },
      transitionDuration: transitionDuration ?? Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {});
}
