import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testscan/viewmodels/app_provider.dart';
import 'package:testscan/views/atoms/custom_button.dart';
import 'package:testscan/views/atoms/custom_text.dart';
import 'package:testscan/views/atoms/input_field.dart';

class DialogTest extends StatefulWidget {

  final bool isEdit;
  final Map? test;
  final int materiaId;

  const DialogTest({super.key, this.isEdit = false, required this.materiaId, this.test});


  @override
  State<DialogTest> createState() => _DialogTestState();
}

class _DialogTestState extends State<DialogTest> {

  final _nameCtrl = TextEditingController();
  final _introductionCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameCtrl.text = widget.isEdit ? widget.test!['nombre'] : '';
    _introductionCtrl.text = widget.isEdit ? widget.test!['introduccion'] : '';
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _introductionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);

    return AlertDialog(
      icon: const Icon(Icons.history_edu, color: Colors.black, size: 50),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Center(
        child: CustomText(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          text: widget.isEdit ? 'Editar Examen' : 'Nuevo Examen',
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(fontSize: 14, fontWeight: FontWeight.w500, text: 'Nombre del Examen'),
              InputField(label: 'Prueba Parcial 1', controller: _nameCtrl),
              CustomText(fontSize: 14, fontWeight: FontWeight.w500, text: 'Introducción del Examen'),
              InputField(label: 'Instrucciones...', controller: _introductionCtrl),
            ],
          ),
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
          text: widget.isEdit ? 'Actualizar' : 'Crear',
          color: Colors.black,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (widget.isEdit) {
                provider.actualizarPrueba(widget.materiaId, widget.test!['id'], _nameCtrl.text, _introductionCtrl.text);
              } else {
                provider.crearPrueba(widget.materiaId, _nameCtrl.text, _introductionCtrl.text);
              }
              Navigator.pop(context);
            }
          },
        )
      ],
    );
  }
}

