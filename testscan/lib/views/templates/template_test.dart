import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testscan/viewmodels/app_provider.dart';
import 'package:testscan/views/organisms/test/dialog_test.dart';
import 'package:testscan/views/organisms/test/list_tests.dart';

class TemplateTest extends StatefulWidget {
  const TemplateTest({super.key});

  @override
  State<TemplateTest> createState() => _TemplateTestState();
}

class _TemplateTestState extends State<TemplateTest> {
  int? selectedMateriaId;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    // Buscamos la materia seleccionada para pasarla a la lista
    final selectedMateria = selectedMateriaId == null
        ? null
        : provider.materias.cast<Map<String, dynamic>?>().firstWhere(
          (m) => m?['id'] == selectedMateriaId,
      orElse: () => null,
    );

    return Scaffold(
      floatingActionButton: selectedMateriaId == null
          ? null
          : FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.note_add_outlined, color: Colors.white),
        onPressed: () => showDialog(
          context: context,
          builder: (ctx) => DialogTest(materiaId: selectedMateriaId!),
        ),
      ),
      body: Column(
        children: [
          // SECCIÓN DROPDOWN MENU (Estilo Material 3)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownMenu<int>(
              initialSelection: selectedMateriaId,
              width: MediaQuery.of(context).size.width - 32, // Ocupa todo el ancho
              label: const Text("Selecciona una Materia"),
              leadingIcon: const Icon(Icons.book_outlined),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              onSelected: (int? value) {
                setState(() {
                  selectedMateriaId = value;
                });
              },
              dropdownMenuEntries: provider.materias.map((m) {
                return DropdownMenuEntry<int>(
                  value: m['id'] as int,
                  label: m['nombre'],
                  leadingIcon: const Icon(Icons.subtitles_outlined, size: 20),
                );
              }).toList(),
            ),
          ),

          // LISTA DE PRUEBAS
          Expanded(
            child: selectedMateria == null
                ? const Center(child: Text("Elige una materia para ver sus exámenes"))
                : ListTests(materia: selectedMateria),
          ),
        ],
      ),
    );
  }
}