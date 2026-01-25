import 'package:flutter/material.dart';
import 'package:testscan/views/atoms/custom_text.dart';
import 'package:testscan/views/molecules/navbar.dart';
import 'package:testscan/views/organisms/teacher/dialog_teacher.dart';
import 'package:testscan/views/screens/screen_classes.dart';
import 'package:testscan/views/screens/screen_questions.dart';
import 'package:testscan/views/screens/screen_students.dart';
import 'package:testscan/views/screens/screen_test.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  //Aqui van la lista de las paginas a donde quiero dirijirme
  final List<Widget> _pages = [
    ScreenStudents(),
    ScreenClasses(),
    ScreenTest(),
    ScreenQuestions()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,

        // 1. Lado IZQUIERDO (Icono + Texto)
        title: Row(
          mainAxisSize: MainAxisSize.min, // Ocupa solo el espacio necesario
          children: [
            Icon(
              Icons.android,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 5), // Un pequeño espacio entre el icono y el texto
            CustomText(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              textAlign: TextAlign.center,
              text: 'DroidTest',
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: (){
            showDialog(
              context: context,
              builder: (context) => const DialogTeacher(),
            );
          }, icon: Icon(Icons.settings, color: Colors.white,))
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),

      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}


