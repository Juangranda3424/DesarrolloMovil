import 'package:flutter/material.dart';
class CustomIcon extends StatelessWidget{
  final IconData icon;
  final double size;
  final Color? color;
  const CustomIcon({
    super.key,
    required this.icon,
    this.size = 20,
    this.color
  });
  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: size, color: color);
  }
}