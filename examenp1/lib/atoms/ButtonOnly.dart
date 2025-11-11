import 'package:flutter/material.dart';

class ButtonOnly extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  const ButtonOnly({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
            minimumSize: Size(0, 0), // elimina tamaño mínimo
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // reduce área táctil
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24,),
          ],
        )
    );
  }
}
