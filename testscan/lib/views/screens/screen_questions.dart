import 'package:flutter/material.dart';
import 'package:testscan/views/templates/template_questions.dart';

class ScreenQuestions extends StatefulWidget {
  const ScreenQuestions({super.key});

  @override
  State<ScreenQuestions> createState() => _ScreenQuestionsState();
}

class _ScreenQuestionsState extends State<ScreenQuestions> {
  @override
  Widget build(BuildContext context) {
    return TemplateQuestions();
  }
}
