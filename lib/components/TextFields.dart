import 'package:flutter/material.dart';
import 'package:spark/constants/Colors.dart';

class AccountTextField extends StatefulWidget {
  //
  AccountTextField({
    @required this.hintText,
    @required this.title,
    @required this.onChanged,
    @required this.currentFocus,
    @required this.context,
    this.nextFocus,
    this.textInputType,
    this.icon,
    this.textInputAction,
    this.onPressedPasswordIcon,
    this.onTapBirth,
    this.obscureText,
    this.isBirth,
  });
  //
  final String hintText;
  final TextInputType textInputType;
  final String title;
  final IconData icon;
  final Function onPressedPasswordIcon;
  final Function onChanged;
  final Function onTapBirth;
  final FocusNode currentFocus;
  final FocusNode nextFocus;
  final BuildContext context;
  final TextInputAction textInputAction;
  final bool isBirth;
  bool obscureText;
  //
  @override
  _AccountTextFieldState createState() => _AccountTextFieldState();
}

class _AccountTextFieldState extends State<AccountTextField> {
  //
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ' ${widget.title}',
          style: TextStyle(
            fontFamily: 'TTNorms',
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ), //Title
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
            textAlignVertical: TextAlignVertical.center,
            keyboardType: widget.textInputType ?? TextInputType.text,
            obscureText: widget.obscureText,
            maxLength: 64,
            style: TextStyle(
              fontFamily: 'TTNorms',
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            decoration: InputDecoration(
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
              hintStyle: TextStyle(
                fontFamily: 'TTNorms',
                color: kTextGray,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              border: InputBorder.none,
            ),
            readOnly: widget.isBirth == true ? true : false,
            onTap: widget.onTapBirth,
            onChanged: widget.onChanged,
          ),
        ), //TextFormField
      ],
    );
  }
}
