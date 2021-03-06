import 'package:flutter/material.dart';
import 'TextStyles.dart';

Future<Object> CustomAlertDialog({
  @required Color barrierColor,
  @required Color backgroundColor,
  @required BuildContext context,
  @required double opacity,
  @required String title,
  @required double titleFontSize,
  @required String content,
  @required double contentFontSize,
  Duration transitionDuration,
  double borderRadius,
  String buttonText,
}) {
  showGeneralDialog(
      barrierColor: barrierColor.withOpacity(opacity), //0.5
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20))), //20
              backgroundColor: backgroundColor,
              title: Text(title),
              titleTextStyle: CustomTextStyle(fontSize: titleFontSize), //20
              content: Text(content),
              contentTextStyle: CustomTextStyle(fontSize: contentFontSize), //15
              elevation: 0,
              actions: [
                Container(
                  child: GestureDetector(
                    child: Text(
                      buttonText ?? 'OK',
                      style: CustomTextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                )
              ],
              actionsPadding: EdgeInsets.all(10),
            ),
          ),
        );
      },
      transitionDuration: transitionDuration ?? Duration(milliseconds: 500),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {});
}
