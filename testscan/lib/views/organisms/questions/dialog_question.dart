import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testscan/viewmodels/app_provider.dart';
import 'package:testscan/views/atoms/custom_button.dart';
import 'package:testscan/views/atoms/custom_text.dart';
import 'package:testscan/views/atoms/input_field.dart';

class DialogQuestion extends StatefulWidget {
  final int pruebaId;
  final Map? pregunta; // Si viene, es edición
  const DialogQuestion({super.key, required this.pruebaId, this.pregunta});

  @override
  State<DialogQuestion> createState() => _DialogQuestionState();
}

class _DialogQuestionState extends State<DialogQuestion> {
  final _enunciadoCtrl = TextEditingController();
  final _aCtrl = TextEditingController();
  final _bCtrl = TextEditingController();
  final _cCtrl = TextEditingController();
  final _dCtrl = TextEditingController();
  final _valorCtrl = TextEditingController();
  String _correcta = 'A';


  @override
  void initState() {
    if (widget.pregunta != null) {
      // 1. Cargamos el enunciado (que en tu BD se llama 'texto')
      _enunciadoCtrl.text = widget.pregunta!['texto'] ?? '';

      // 2. Decodificamos el JSON de las opciones
      if (widget.pregunta!['opciones'] != null) {
        Map<String, dynamic> opts = jsonDecode(widget.pregunta!['opciones']);
        _aCtrl.text = opts['A'] ?? '';
        _bCtrl.text = opts['B'] ?? '';
        _cCtrl.text = opts['C'] ?? '';
        _dCtrl.text = opts['D'] ?? '';
      }

      _correcta = widget.pregunta!['respuesta_correcta'] ?? 'A';
      _valorCtrl.text = widget.pregunta!['valor']!.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);

    return AlertDialog(
      icon: const Icon(Icons.edit, color: Colors.black, size: 50),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Center(
        child: CustomText(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          text: widget.pregunta == null ? "Nueva Pregunta" : "Editar Pregunta",
          textAlign: TextAlign.center,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(fontSize: 14, fontWeight: FontWeight.w500, text: 'Enunciado'),
            const SizedBox(height: 5),
            InputField(label: "En este apartado...", controller: _enunciadoCtrl),
            const SizedBox(height: 15),
            CustomText(fontSize: 14, fontWeight: FontWeight.w500, text: 'Opciones'),
            InputField(label: "Opción A", controller: _aCtrl),
            const SizedBox(height: 5),
            InputField(label: "Opción B", controller: _bCtrl),
            const SizedBox(height: 5),
            InputField(label: "Opción C", controller: _cCtrl),
            const SizedBox(height: 5),
            InputField(label: "Opción D", controller: _dCtrl),
            const SizedBox(height: 15),
            CustomText(fontSize: 14, fontWeight: FontWeight.w500, text: 'Respuesta Correcta'),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'A', label: Text('A')),
                ButtonSegment(value: 'B', label: Text('B')),
                ButtonSegment(value: 'C', label: Text('C')),
                ButtonSegment(value: 'D', label: Text('D')),
              ],
              selected: {_correcta},
              onSelectionChanged: (val) => setState(() => _correcta = val.first),
            ),
            const SizedBox(height: 5),
            CustomText(fontSize: 14, fontWeight: FontWeight.w500, text: 'Valor'),
            InputField(label: "Valor de la pregunta", controller: _valorCtrl),
          ],
        ),
      ),
      actions: [
        TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
              side: BorderSide(
                color: Colors.red,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar")
        ),
        CustomButton(
          text: 'Registrar',
          color: Colors.black,
          onPressed: () {
            // 1. Creamos un mapa dinámico y solo agregamos lo que NO esté vacío
            Map<String, String> opcionesMap = {};

            if (_aCtrl.text.trim().isNotEmpty) opcionesMap['A'] = _aCtrl.text.trim();
            if (_bCtrl.text.trim().isNotEmpty) opcionesMap['B'] = _bCtrl.text.trim();
            if (_cCtrl.text.trim().isNotEmpty) opcionesMap['C'] = _cCtrl.text.trim();
            if (_dCtrl.text.trim().isNotEmpty) opcionesMap['D'] = _dCtrl.text.trim();

            // Validación básica: al menos deben haber opciones para guardar
            if (opcionesMap.isEmpty || _enunciadoCtrl.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("El enunciado y al menos una opción son obligatorios"))
              );
              return;
            }

            // 2. Preparamos la data para el Provider
            final data = {
              'texto': _enunciadoCtrl.text,
              'opciones': jsonEncode(opcionesMap), // Solo llevará las opciones con texto
              'respuesta_correcta': _correcta,
              'tipo': 'SELECCION_MULTIPLE',
              'prueba_id': widget.pruebaId,
              'valor': int.tryParse(_valorCtrl.text) ?? 1,
            };

            if (widget.pregunta == null) {
              provider.crearPregunta(data);
            } else {
              provider.actualizarPregunta(widget.pregunta!['id'], data);
            }
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}