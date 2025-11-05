import 'package:flutter/material.dart';

class AppStyles{
  static final ButtonStyle Stbutton = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
  );
  static const TextStyle text = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontFamily: 'Roboto'
  );
  static const TextStyle h2 = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontFamily: 'Roboto'
  );
}