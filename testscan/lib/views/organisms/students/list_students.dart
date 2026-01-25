import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testscan/viewmodels/app_provider.dart';
import 'package:testscan/views/atoms/custom_text.dart';
import 'package:testscan/views/organisms/students/student_card.dart';
import 'package:testscan/views/organisms/students/dialog_student.dart';

class ListStudents extends StatelessWidget {
  const ListStudents({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    // Colores con tonos diferentes para variar de las materias
    final List<Color> studentColors = [
      Colors.blueAccent, Colors.indigo.shade700, Colors.cyan.shade600, Colors.blueGrey
    ];

    // 1. Verificamos si la lista de estudiantes está vacía
    if (provider.estudiantes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono relacionado con estudiantes
            Icon(Icons.person_off_outlined, size: 100, color: Colors.grey.shade300),
            const SizedBox(height: 20),
            const CustomText(
              text: "No hay estudiantes",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            const CustomText(
              text: "Agrega alumnos a esta materia con el botón +",
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
            ),
          ],
        ),
      );
    }

    // 2. Si hay datos, mostramos la lista
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.estudiantes.length,
      itemBuilder: (ctx, i) {
        final student = provider.estudiantes[i];
        final Color cardColor = studentColors[i % studentColors.length];

        return StudentCard(
          estudiante: student,
          color: cardColor,
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => DialogStudent(isEdit: true, student: student),
            );
          },
        );
      },
    );
  }
}