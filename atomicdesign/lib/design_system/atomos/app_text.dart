import 'dart:ffi';

import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? size;

  const AppText(this.text,{super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: size ?? 30, color: Colors.black, fontFamily: 'Roboto'),
      textAlign: TextAlign.center,
    );
  }
}
