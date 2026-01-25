import 'package:flutter/material.dart';
import 'package:testscan/views/templates/template_students.dart';

class ScreenStudents extends StatefulWidget {
  const ScreenStudents({super.key});

  @override
  State<ScreenStudents> createState() => _ScreenStudentsState();
}

class _ScreenStudentsState extends State<ScreenStudents> {
  @override
  Widget build(BuildContext context) {
    return TemplateStudents();
  }
}
