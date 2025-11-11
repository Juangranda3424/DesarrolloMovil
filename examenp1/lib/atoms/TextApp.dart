import 'package:flutter/material.dart';

class TextApp extends StatelessWidget {
  final String text;
  final double size;
  const TextApp({super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        backgroundColor: Colors.transparent,
        fontSize: size,
        fontWeight: FontWeight.bold
      ),
    );
  }
}
