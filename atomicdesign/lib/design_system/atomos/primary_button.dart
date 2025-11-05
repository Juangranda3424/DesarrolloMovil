import 'package:flutter/material.dart';
import '../../utils/app_styles.dart';
class PrimaryButton extends StatelessWidget {

  final String label;
  final VoidCallback onPressed;

  const PrimaryButton(
      {super.key,
        required this.label,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: AppStyles.Stbutton,
        child: Text(label),
    );
  }
}
