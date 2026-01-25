import 'package:flutter/material.dart';
import 'package:testscan/views/templates/template_test.dart';

class ScreenTest extends StatefulWidget {
  const ScreenTest({super.key});

  @override
  State<ScreenTest> createState() => _ScreenTestState();
}

class _ScreenTestState extends State<ScreenTest> {
  @override
  Widget build(BuildContext context) {
    return TemplateTest();
  }
}
