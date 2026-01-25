import 'package:flutter/material.dart';
import 'package:testscan/views/atoms/custom_text.dart';

class StudentCard extends StatelessWidget {
  final Map estudiante;
  final Color color;
  final VoidCallback onTap;

  const StudentCard({
    super.key,
    required this.estudiante,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Icon(Icons.person, color: Colors.white, size: 40),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        text: "${estudiante['nombres']} ${estudiante['apellidos']}",
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.8),
                        text: "ID: ${estudiante['codigo']}",
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