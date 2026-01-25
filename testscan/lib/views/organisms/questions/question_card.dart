import 'dart:convert'; // ¡No olvides este import!
import 'package:flutter/material.dart';
import 'package:testscan/views/atoms/custom_text.dart';

class QuestionCard extends StatelessWidget {
  final Map pregunta;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const QuestionCard({
    super.key,
    required this.pregunta,
    required this.onEdit,
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    // 1. DECODIFICAR LAS OPCIONES
    // Si 'opciones' es un String (JSON de la BD), lo convertimos a Map.
    // Si por alguna razón es nulo, usamos un mapa vacío para evitar el crash.
    final Map<String, dynamic> opciones = pregunta['opciones'] is String
        ? jsonDecode(pregunta['opciones'])
        : (pregunta['opciones'] ?? {});

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.help_outline, color: Colors.indigo, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: CustomText(
                  // En tu BD se llama 'texto', no 'enunciado'
                    text: pregunta['texto'] ?? "Sin enunciado",
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
              IconButton(onPressed: onEdit, icon: const Icon(Icons.edit, size: 30, color: Colors.black)),
              IconButton(onPressed: onDelete, icon: const Icon(Icons.delete_outline, size: 30, color: Colors.redAccent)),
            ],
          ),
          const SizedBox(height: 10),

          // 2. MOSTRAR LAS OPCIONES USANDO EL MAPA DECODIFICADO
          _OptionItem(
              label: "A",
              text: opciones['A']?.toString() ?? "",
              isCorrect: pregunta['respuesta_correcta'] == 'A'
          ),
          _OptionItem(
              label: "B",
              text: opciones['B']?.toString() ?? "",
              isCorrect: pregunta['respuesta_correcta'] == 'B'
          ),
          _OptionItem(
              label: "C",
              text: opciones['C']?.toString() ?? "",
              isCorrect: pregunta['respuesta_correcta'] == 'C'
          ),
          _OptionItem(
              label: "D",
              text: opciones['D']?.toString() ?? "",
              isCorrect: pregunta['respuesta_correcta'] == 'D'
          ),
        ],
      ),
    );
  }
}

// El widget _OptionItem se mantiene igual...
class _OptionItem extends StatelessWidget {
  final String label;
  final String text;
  final bool isCorrect;

  const _OptionItem({required this.label, required this.text, required this.isCorrect});

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return const SizedBox(); // Si no hay texto en esa opción, no la mostramos

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: isCorrect ? Colors.green : Colors.grey.shade200,
            child: Text(label, style: TextStyle(fontSize: 12, color: isCorrect ? Colors.white : Colors.black)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
                text,
                style: TextStyle(
                    color: isCorrect ? Colors.green.shade700 : Colors.black87,
                    fontWeight: isCorrect ? FontWeight.bold : FontWeight.normal
                )
            ),
          ),
        ],
      ),
    );
  }
}