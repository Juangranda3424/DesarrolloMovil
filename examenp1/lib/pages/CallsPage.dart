import 'package:examenp1/atoms/TextApp.dart';
import 'package:examenp1/organisms/Header.dart';
import 'package:examenp1/organisms/Navbar.dart';
import 'package:examenp1/templates/DefaultLayout.dart';
import 'package:flutter/material.dart';

class Callspage extends StatelessWidget {
  const Callspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Defaultlayout(
        body: TextApp(text: "Historial de llamadas (simulado)", size: 20),
        footer: Navbar(),
        header: Header(title: 'Llamadas', searchbar: false, icon: Icons.search)
    );
  }
}
