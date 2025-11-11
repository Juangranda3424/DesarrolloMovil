import 'package:examenp1/organisms/ChatList.dart';
import 'package:examenp1/organisms/Header.dart';
import 'package:examenp1/organisms/Navbar.dart';
import 'package:examenp1/templates/DefaultLayout.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatelessWidget {
  //dynamic es para declarar una variable que puede cambiar en tiempo de ejecion su valor
  final List<Map<String, dynamic>> chats = [
    {
      "name": "Juan",
      "msj": "Hola, tenia una duda",
      "time": "10:34"
    },
    {
      "name": "Carlos",
      "msj": "Hola, tenia una duda",
      "time": "10:34"
    },
    {
      "name": "Pedro",
      "msj": "Hola, tenia una duda",
      "time": "10:34"
    },
    {
      "name": "Marcos",
      "msj": "Hola, tenia una duda pero no se como lo tomaras",
      "time": "10:34"
    },
    {
      "name": "Mateo",
      "msj": "Hola, tenia una duda",
      "time": "10:34"
    }
  ];

  Chatpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Defaultlayout(
        body: Chatlist(chats: chats,),
        footer: Navbar(),
        header: Header(title: 'Chats',searchbar: true, icon: Icons.camera_alt_outlined)
    );
  }
}
