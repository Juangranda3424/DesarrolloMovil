import 'package:examenp1/atoms/TextApp.dart';
import 'package:examenp1/organisms/Header.dart';
import 'package:examenp1/organisms/Navbar.dart';
import 'package:examenp1/templates/DefaultLayout.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Defaultlayout(
        body: Icon(Icons.home_filled, color: Colors.white, size:  250,),
        footer: Navbar(),
        header: Header(title: 'WhatsApp', searchbar: false, icon: Icons.camera_alt_outlined)
    );
  }
}
