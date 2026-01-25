import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testscan/viewmodels/app_provider.dart';
import 'package:testscan/views/organisms/questions/question_card.dart';
import 'package:testscan/views/organisms/questions/dialog_question.dart';

class TemplateQuestions extends StatefulWidget {
  const TemplateQuestions({super.key}); // Ya no pide materia

  @override
  State<TemplateQuestions> createState() => _TemplateQuestionsState();
}

class _TemplateQuestionsState extends State<TemplateQuestions> {
  int? selectedPruebaId;

  @override
  void initState() {
    super.initState();
    // Cargamos todas las pruebas disponibles en la App
    Future.microtask(() =>
        Provider.of<AppProvider>(context, listen: false).cargarTodasLasPruebas()
    );
  }

  void _cargarPreguntasDePrueba() {
    if (selectedPruebaId != null) {
      Future.microtask(() =>
          Provider.of<AppProvider>(context, listen: false)
              .cargarPreguntas(selectedPruebaId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      floatingActionButton: selectedPruebaId == null
          ? null
          : FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => showDialog(
            context: context,
            builder: (ctx) => DialogQuestion(pruebaId: selectedPruebaId!)
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(builder: (context, constraints) {
              return DropdownMenu<int>(
                initialSelection: selectedPruebaId,
                width: constraints.maxWidth,
                label: const Text("Selecciona un Examen"),
                leadingIcon: const Icon(Icons.assignment_turned_in_outlined),
                // Habilitamos búsqueda para que sea más fácil si hay muchas pruebas
                enableSearch: true,
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                onSelected: (int? value) {
                  setState(() => selectedPruebaId = value);
                  _cargarPreguntasDePrueba();
                },
                dropdownMenuEntries: provider.pruebas.map((p) {
                  return DropdownMenuEntry<int>(
                    value: p['id'] as int,
                    label: p['nombre'], // Aquí saldrán todos los exámenes de la BD
                    leadingIcon: const Icon(Icons.format_list_bulleted, size: 20),
                  );
                }).toList(),
              );
            }),
          ),
          Expanded(
            child: selectedPruebaId == null
                ? const Center(child: Text("Elige una prueba para gestionar sus preguntas"))
                : provider.preguntas.isEmpty
                ? const Center(child: Text("Este examen no tiene preguntas aún"))
                : ListView.builder(
              itemCount: provider.preguntas.length,
              itemBuilder: (ctx, i) {
                final q = provider.preguntas[i];
                return QuestionCard(
                  pregunta: q,
                  onEdit: () => showDialog(
                      context: context,
                      builder: (ctx) => DialogQuestion(
                          pruebaId: selectedPruebaId!, pregunta: q)),
                  onDelete: () => provider.eliminarPregunta(
                      q['id'], selectedPruebaId!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}