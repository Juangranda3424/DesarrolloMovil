import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final FontStyle fontStyle;
  final double top;
  final double bottom;
  const CustomText({super.key, required this.text, required this.fontSize, this.color = Colors.black, this.fontWeight = FontWeight.bold, this.textAlign = TextAlign.start, this.fontStyle = FontStyle.normal, this.top = 10, this.bottom = 5});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top, bottom: bottom),
      child: Text(
          text,
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color, fontStyle: fontStyle),
          textAlign: textAlign
      ),
    );
  }
}
