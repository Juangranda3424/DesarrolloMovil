import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white10,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        hintText: 'Pregunta a Meta IA o buscar',
      ),
      onSubmitted: (value) {
        print(value);
      },
    );
  }
}


