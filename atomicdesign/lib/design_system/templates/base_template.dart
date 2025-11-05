import 'package:flutter/material.dart';

class BaseTemplate extends StatelessWidget {

  final String title;
  final Widget body;

  const BaseTemplate({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),
                    backgroundColor: Colors.lightGreen,
                    foregroundColor: Colors.white,
                    centerTitle: true,

      ),
      body: Padding(padding: EdgeInsets.all(20),
      child: body),
    );
  }
}
