import 'package:examenp1/atoms/ButtonOnly.dart';
import 'package:examenp1/atoms/TextApp.dart';
import 'package:examenp1/pages/CallsPage.dart';
import 'package:examenp1/pages/ChatPage.dart';
import 'package:examenp1/pages/HomePage.dart';
import 'package:examenp1/pages/StatusPage.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonOnly(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Homepage())
              );
            }, icon: Icons.home),
            TextApp(text: 'Home', size: 15)
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonOnly(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Chatpage())
              );
            }, icon: Icons.message_rounded),
            TextApp(text: 'Chats', size: 15)
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonOnly(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Statuspage())
              );
            }, icon: Icons.mark_chat_unread_outlined),
            TextApp(text: 'Estados', size: 15)
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonOnly(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Callspage())
              );
            }, icon: Icons.call_outlined),
            TextApp(text: 'Llamadas', size: 15)
          ],
        ),
      ],
    );
  }
}
