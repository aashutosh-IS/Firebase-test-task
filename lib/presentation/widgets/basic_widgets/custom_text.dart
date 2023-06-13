import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String title;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  const CustomTextWidget(
      {super.key,
      required this.title,
      this.fontSize,
      this.color,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: fontSize ?? 18.0,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? Colors.white,
      ),
    );
  }
}
