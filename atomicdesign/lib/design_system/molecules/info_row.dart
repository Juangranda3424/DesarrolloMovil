
import 'package:flutter/material.dart';
import '../atomos/app_text.dart';
import '../atomos/custom_icon.dart';

class InfoRow extends StatelessWidget {

  final IconData icon;
  final double spacing;
  final String text;
  final Color color;

  const InfoRow({
    super.key,
    required this.icon,
    required this.text,
    this.spacing = 0.8,
    this.color = Colors.lightGreen
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIcon(icon: icon, color: color),
        SizedBox(width: spacing),
        AppText(text)
      ],
    );
  }
}
