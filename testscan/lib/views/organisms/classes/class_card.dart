import 'package:flutter/material.dart';
import 'package:testscan/views/atoms/custom_text.dart';

class ClassCard extends StatefulWidget {
  final Map materia;
  final Color color;
  final VoidCallback onTap;

  const ClassCard({
    super.key,
    required this.materia,
    required this.color,
    required this.onTap,
  });

  @override
  State<ClassCard> createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [widget.color.withOpacity(0.8), widget.color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Icono decorativo
                Icon(Icons.temple_hindu, color: Colors.white, size: 30),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        textAlign: TextAlign.center,
                        text: widget.materia['nombre'],
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.9),
                        textAlign: TextAlign.center,
                        text: "NRC: ${widget.materia['codigo']}"
                      )
                    ],
                  ),
                ),
                const Icon(Icons.edit_note, color: Colors.white, size: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

