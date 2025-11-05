import 'package:flutter/material.dart';
import '../atomos/app_text.dart';
import '../molecules/info_row.dart';

class HeaderSection extends StatelessWidget {
    final double spacing;
    const HeaderSection({this.spacing = 16,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        InfoRow(
          icon: Icons.home_rounded,
          text: "Inicio",
          color: Colors.blueAccent, // 🔵
        ),
        SizedBox(width: spacing)
        ,
        InfoRow(
          icon: Icons.search_rounded,
          text: "Buscar",
          color: Colors.orangeAccent, // 🟠
        ),
        SizedBox(width: 100)
        ,
        InfoRow(
          icon: Icons.person_rounded,
          text: "Perfil",
          color: Colors.purpleAccent, // 🟣
        ),
      ],
    );
  }
}
