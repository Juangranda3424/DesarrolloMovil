import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Defaultlayout extends StatelessWidget {
  final Widget? header;
  final Widget? body;
  final Widget? footer;

  const Defaultlayout({
    super.key,
    required this.body,
    required this.footer,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,

      body: AnnotatedRegion<SystemUiOverlayStyle>(
        //Si no cambio la parte donde esta la bateria y demas se hace negro
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.black, // sin fondo negro arriba
          statusBarIconBrightness: Brightness.light, // íconos blancos
        ),
        child: SafeArea(
          child: Column(
            children: [
              if (header != null)
                Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(16),
                  child: header,
                ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Colors.black87,
                  child: body,
                ),
              ),
              if (footer != null)
                Container(
                  width: double.infinity,
                  color: Colors.black,
                  padding: const EdgeInsets.all(16),
                  child: footer,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
