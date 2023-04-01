import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';

class ElevateButton extends StatelessWidget {
  ElevateButton({
    Key? key,
    this.title,
    this.fontSize,
    this.fontWeight,
    this.fontColor,
    this.buttonColor,
    required this.height,
    required this.width,
    this.onPressed,
  }) : super(key: key);
  final String? title;
  final double? fontSize;
  final fontWeight;
  final Color? buttonColor;
  final Color? fontColor;
  final double? height;
  final double? width;
  final dynamic onPressed;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      onPrimary: buttonColor,
      primary: buttonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: Text(
          title!,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}
