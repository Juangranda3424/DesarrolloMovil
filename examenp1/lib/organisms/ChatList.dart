import 'package:flutter/material.dart';

class Chatlist extends StatelessWidget {
  //dynamic es para declarar una variable que puede cambiar en tiempo de ejecion su valor
  final List<Map<String, dynamic>> chats;

  const Chatlist({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.black,
        child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index){
              final chat = chats[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                ),
                title: Text(
                  chat["name"],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  chat["msj"],
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: Text(
                  chat["time"],
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
                onTap: () {
                  //Para ir a la ventana donde estaria el chat
                },
              );
            }),
      )
    );
  }
}
