import 'package:flutter/material.dart';
import '../atomos/primary_button.dart';
import '../molecules/info_row.dart';
import '../organisms/header_section.dart';
import '../templates/base_template.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
        title: "ATOMIC DESIGN - DEMO",
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const HeaderSection(),
            const SizedBox(height: 18,),
            const InfoRow(iconData: Icons.add_a_photo_rounded
            ),
            const SizedBox(height: 20,),
            PrimaryButton(label: "CAPTURAR", onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("LO SIENTIMOS AUN NO "
                    "ESTA IMPLEMENTADA LA FUNCIONALIDAD :,("))
              );
            })
          ],
        ));
  }
}
