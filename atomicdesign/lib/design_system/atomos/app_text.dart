
import 'package:flutter/material.dart';
import '../../utils/app_styles.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const AppText(
      this.text,
      {super.key,
      this.style}
  );
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? AppStyles.text
    );
  }
}
