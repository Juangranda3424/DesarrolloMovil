import 'package:atomicdesign/design_system/atomos/app_text.dart';
import 'package:atomicdesign/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../atomos/primary_button.dart';
import '../atomos/custom_icon.dart';
import '../molecules/info_row.dart';
import '../organisms/header_section.dart';
import '../templates/base_template.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
        title: "ATOMIC DESIGN APPLICATION ",
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const HeaderSection(),
            const SizedBox(height: 20),

            Column(children: [

                CustomIcon(icon: Icons.add_a_photo_rounded,size: 150 ,color: Colors.lightGreen),
                AppText("Tomate una foto", style: AppStyles.h2,)
            ]),
            const SizedBox(height: 20,),

            PrimaryButton(label: "CAPTURAR", onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("LO SIENTIMOS AUN NO "
                    "ESTA IMPLEMENTADA LA FUNCIONALIDAD "))
              );
            })
          ],
        ));
  }
}
