import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testscan/viewmodels/app_provider.dart';
import 'package:testscan/views/atoms/custom_text.dart';
import 'package:testscan/views/organisms/classes/class_card.dart';
import 'package:testscan/views/organisms/classes/dialog_classes.dart';

class ListClasses extends StatelessWidget {
  const ListClasses({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final List<Color> cardColors = [Colors.redAccent, Colors.purple.shade900, Colors.orangeAccent, Colors.teal];

    // 1. Verificamos si la lista está vacía
    if (provider.materias.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Un icono descriptivo
            Icon(Icons.school_outlined, size: 100, color: Colors.grey.shade300),
            const SizedBox(height: 20),
            const CustomText(
              text: "No hay materias registradas",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            const CustomText(
              text: "Toca el botón + para crear una materia",
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
            ),
          ],
        ),
      );
    }

    // 2. Si hay datos, mostramos el ListView normal
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.materias.length,
      itemBuilder: (ctx, i) {
        final m = provider.materias[i];
        final Color mainColor = cardColors[i % cardColors.length];

        return ClassCard(
          materia: m,
          color: mainColor,
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => DialogClasses(isEdit: true, classroom: m),
            );
          },
        );
      },
    );
  }
}