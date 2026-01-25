import 'package:flutter/material.dart';
import 'package:testscan/views/atoms/custom_text.dart';

class TestCard extends StatefulWidget {

  final Map prueba;
  final VoidCallback onImport;
  final VoidCallback onPdf;
  final VoidCallback onCalificar;
  final VoidCallback onTap;
  final VoidCallback onExcel;

  const TestCard({super.key, required this.prueba, required this.onImport, required this.onPdf, required this.onCalificar, required this.onTap, required this.onExcel});

  @override
  State<TestCard> createState() => _TestCardState();
}

class _TestCardState extends State<TestCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration( // Movimos la decoración aquí
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      // Usamos Material para que el InkWell muestre el efecto visual
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20), // Para que el efecto respete las esquinas
          onTap: widget.onTap,
          child: Padding( // El padding va DENTRO del InkWell para que todo sea tocable
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        text: widget.prueba['nombre']
                    ),
                    const Icon(Icons.assignment_outlined, color: Colors.black),
                  ],
                ),
                CustomText(
                    fontSize: 14,
                    color: Colors.grey,
                    text: "Fecha: ${widget.prueba['fecha']}"
                ),
                const Divider(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _ActionButton(icon: Icons.upload_file, label: "Aiken", onTap: widget.onImport),
                    _ActionButton(icon: Icons.picture_as_pdf, label: "PDF", onTap: widget.onPdf),
                    _ActionButton(icon: Icons.file_download_outlined, label: "Notas", onTap: widget.onExcel),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                      ),
                      onPressed: widget.onCalificar,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Calificar"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.grey.shade700),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}