import 'package:flutter/material.dart';

class CustomCancelButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final String text;

  const CustomCancelButton({
    super.key,
    this.isLoading = false,
    this.onPressed,
    this.text = 'Cancelar',
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // Si está cargando, pasamos null para deshabilitar el botón.
      // Si no está cargando, usamos la función onPressed.
      // Si onPressed no se define, por defecto hace "atrás" (pop).
      onPressed: isLoading
          ? null
          : (onPressed ?? () => Navigator.pop(context)),

      style: TextButton.styleFrom(
        // Color del texto cuando está activo
        foregroundColor: Colors.red,
        // Color del texto cuando está deshabilitado (loading)
        disabledForegroundColor: Colors.grey.withOpacity(0.38),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        side: BorderSide(
          // Borde gris si carga, rojo si está activo
          color: isLoading ? Colors.grey[300]! : Colors.red,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}