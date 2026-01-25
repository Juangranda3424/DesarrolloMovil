import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Usamos NavigationBarTheme para personalizar los colores más a fondo si es necesario
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        // Color del texto de las etiquetas
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          // Estilo cuando esta seleccionado
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            );
          }

          // Estilo cuando no esta seleccionado
          return const TextStyle(
            color: Colors.grey,
            fontSize: 10,
          );
        }),
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        backgroundColor: Colors.black, // Fondo de toda la barra

        indicatorColor: Colors.transparent, // EL FONDO DEL ÍCONO SELECCIONADO (Estilo WhatsApp)

        // Opcional: Para hacer la barra más baja y parecida a la antigua
        height: 65,

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person, color: Colors.grey), // Ícono normal
            selectedIcon: Icon(Icons.person, color: Colors.white), // Ícono normal
            label: 'Estudiantes',
          ),
          NavigationDestination(
            icon: Icon(Icons.temple_hindu_outlined, color: Colors.grey),
            selectedIcon: Icon(Icons.temple_hindu_outlined, color: Colors.white),
            label: 'Materias',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_edu, color: Colors.grey),
            selectedIcon: Icon(Icons.history_edu, color: Colors.white),
            label: 'Pruebas',
          ),
          NavigationDestination(
            icon: Icon(Icons.question_mark, color: Colors.grey),
            selectedIcon: Icon(Icons.question_mark, color: Colors.white),
            label: 'Preguntas',
          ),
        ],
      ),
    );
  }
}