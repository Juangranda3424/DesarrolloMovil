import 'package:examenp1/pages/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyExam());
}

class MyExam extends StatelessWidget {
  const MyExam({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp',
      home: Scaffold(
        body: SafeArea(
          child: Homepage(),
        ),
      ),
    );
  }
}
