import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spark/constants/Colors.dart';
import 'package:spark/components/TextStyles.dart';

class AccountTextField extends StatefulWidget {
  //
  AccountTextField({
    @required this.context,
    @required this.title,
    @required this.hintText,
    @required this.formatErrorText,
    @required this.showTextFormatError,
    @required this.onChanged,
    @required this.maxLength,
    @required this.currentFocus,
    this.nextFocus,
    this.textInputType,
    this.textInputAction,
    this.obscureText,
    this.icon,
    this.onPressedPasswordIcon,
    this.onTapBirthTextField,
    this.isPasswordTextField,
    this.isBirthTextField,
  });
  //
  final BuildContext context;
  final String title;
  final String hintText;
  final String formatErrorText;
  final bool showTextFormatError;
  final Function onChanged;
  final int maxLength;
  final FocusNode currentFocus;
  final FocusNode nextFocus;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final IconData icon;
  final Function onPressedPasswordIcon;
  final Function onTapBirthTextField;
  final bool isPasswordTextField;
  final bool isBirthTextField;
  //
  @override
  _AccountTextFieldState createState() => _AccountTextFieldState();
}

class _AccountTextFieldState extends State<AccountTextField> {
  //
  InputDecoration inputDecorationChooser() {
    if (widget.isPasswordTextField == true) {
      return InputDecoration(
        suffixIcon: IconButton(
          padding: EdgeInsets.all(0),
          alignment: Alignment.centerRight,
          splashRadius: 0.1,
          iconSize: 24,
          icon: Icon(
            widget.icon,
            color: Colors.white,
          ),
          onPressed: widget.onPressedPasswordIcon,
        ),
        counterText: '',
        hintText: widget.hintText,
        hintStyle: CustomTextStyle(
          color: kTextGray,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        border: InputBorder.none,
      );
    } else {
      return InputDecoration(
        counterText: '',
        hintText: widget.hintText,
        hintStyle: CustomTextStyle(
          color: kTextGray,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        border: InputBorder.none,
      );
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              ' ${widget.title}',
              style: CustomTextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ), //Title
            SizedBox(width: 5),
            widget.showTextFormatError == true
                ? Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        widget.isPasswordTextField == true
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    ' ${widget.formatErrorText}  ',
                                    //widget.formatErrorText,
                                    style: CustomTextStyle(
                                      color: Colors.yellow,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    ' (a-z, A-Z, 0-9, symbols)  ',
                                    //widget.formatErrorText,
                                    style: CustomTextStyle(
                                      color: Colors.yellow,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                ' ${widget.formatErrorText}  ',
                                //widget.formatErrorText,
                                style: CustomTextStyle(
                                  color: Colors.yellow,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ), //Title & Error Message
        SizedBox(height: 15),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 55,
          decoration: BoxDecoration(
            color: kAppBackgroundColorLite,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: TextFormField(
            focusNode: widget.currentFocus,
            onFieldSubmitted: (term) {
              widget.currentFocus.unfocus();
              FocusScope.of(widget.context).requestFocus(widget.nextFocus);
            },
            textInputAction: widget.textInputAction ?? TextInputAction.done,
            textAlignVertical:
                widget.isPasswordTextField == true ? TextAlignVertical.center : TextAlignVertical.top,
            keyboardType: widget.textInputType ?? TextInputType.text,
            obscureText: widget.obscureText,
            maxLength: widget.maxLength,
            style: CustomTextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            decoration: inputDecorationChooser(),
            readOnly: widget.isBirthTextField == true ? true : false,
            onTap: widget.onTapBirthTextField,
            onChanged: widget.onChanged,
          ),
        ), //TextFormField
      ],
    );
  }
}
