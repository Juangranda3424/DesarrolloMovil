import 'package:flutter/material.dart';
import 'package:testscan/views/atoms/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;

  const CustomButton({super.key, required this.text, this.onPressed, this.color = const Color.fromRGBO(8, 153, 253, 1.0)});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          // Definición de colores
          backgroundColor: color,
          foregroundColor: Colors.black,
          // Ajustamos el padding (lo puedes reducir si usas width: infinity)
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          // Opcional: Define la forma (bordes redondeados)
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), 
          ),
      ),
      child: CustomText(text: text, color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500, top: 0, bottom: 0,),
    );
  }
}
