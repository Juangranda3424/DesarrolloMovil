import 'package:atomicdesign/design_system/atomos/app_text.dart';
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {

  final IconData iconData;

  const InfoRow({super.key, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(iconData, color: Colors.lightGreen,size: 200),
        AppText("Presiona el botón para tomarte una foto", size: 15,)
      ],
    );
  }
}
