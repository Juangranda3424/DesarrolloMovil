import 'package:flutter/material.dart';
import 'package:testscan/views/templates/template_classes.dart';

class ScreenClasses extends StatefulWidget {

  const ScreenClasses({super.key});

  @override
  State<ScreenClasses> createState() => _ScreenClassesState();
}

class _ScreenClassesState extends State<ScreenClasses> {
  @override
  Widget build(BuildContext context) {
    return TemplateClasses();
  }
}
