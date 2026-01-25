import 'package:flutter/material.dart';
import 'package:testscan/views/organisms/students/list_students.dart';

import '../organisms/students/dialog_student.dart';

class TemplateStudents extends StatefulWidget {
  const TemplateStudents({super.key});

  @override
  State<TemplateStudents> createState() => _TemplateStudentsState();
}

class _TemplateStudentsState extends State<TemplateStudents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 0,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          showDialog(context: context, builder: (ctx) => const DialogStudent());
        },
      ),
      body: const ListStudents(),
    );
  }
}
