import 'package:flutter/material.dart';
import 'package:testscan/views/organisms/classes/dialog_classes.dart';
import 'package:testscan/views/organisms/classes/list_classes.dart';

class TemplateClasses extends StatefulWidget {
  const TemplateClasses({super.key});

  @override
  State<TemplateClasses> createState() => _TemplateClassesState();
}

class _TemplateClassesState extends State<TemplateClasses> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 0,
        child: const Icon(Icons.add, color: Colors.white,),
        onPressed: () {
          showDialog(context: context, builder: (ctx) => DialogClasses());
        },
      ),
      body: ListClasses(),
    );
  }
}
