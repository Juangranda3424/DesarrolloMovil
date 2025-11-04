import 'package:flutter/material.dart';
import '../atomos/app_text.dart';


class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        AppText("TOMATE UNA FOTO PARA EL RECUERDO")
      ],
    );
  }
}
