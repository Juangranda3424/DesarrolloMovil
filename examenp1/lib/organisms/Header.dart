import 'package:examenp1/atoms/ButtonOnly.dart';
import 'package:examenp1/atoms/InputText.dart';
import 'package:examenp1/atoms/TextApp.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final bool searchbar;
  final IconData icon;
  const Header({super.key, required this.title, required this.searchbar, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextApp(text: title, size: 23,),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [ Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ButtonOnly(onPressed: (){}, icon: icon),
                  SizedBox(width: 13,),
                  ButtonOnly(onPressed: (){}, icon: Icons.more_vert),
                ],
              )],
            )
          ],
        ),
        SizedBox(height: 18,),
        if(searchbar != false)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child:
                InputText()
              )
            ],
          )
      ],
    );
  }
}
