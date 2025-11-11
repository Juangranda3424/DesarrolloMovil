import 'package:examenp1/atoms/TextApp.dart';
import 'package:examenp1/organisms/Header.dart';
import 'package:examenp1/organisms/Navbar.dart';
import 'package:examenp1/templates/DefaultLayout.dart';
import 'package:flutter/material.dart';

class Statuspage extends StatelessWidget {
  const Statuspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Defaultlayout(
        body: TextApp(text: "Aquí se mostrarían los estados", size: 20),
        footer: Navbar(),
        header: Header(title: 'Estados',searchbar: false, icon: Icons.search)
    );
  }
}
