import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testscan/viewmodels/app_provider.dart';
import 'package:testscan/views/atoms/custom_button.dart';
import 'package:testscan/views/atoms/custom_text.dart';
import 'package:testscan/views/atoms/input_field.dart';

class DialogStudent extends StatefulWidget {
  final bool isEdit;
  final Map? student;

  const DialogStudent({super.key, this.isEdit = false, this.student});

  @override
  State<DialogStudent> createState() => _DialogStudentState();
}

class _DialogStudentState extends State<DialogStudent> {
  final _nameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameCtrl.text = widget.isEdit ? widget.student!['nombres'] : '';
    _lastNameCtrl.text = widget.isEdit ? widget.student!['apellidos'] : '';
    _codeCtrl.text = widget.isEdit ? widget.student!['codigo'] : '';
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _lastNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    return AlertDialog(
      icon: const Icon(Icons.badge, color: Colors.black, size: 50),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Center(
        child: CustomText(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          text: widget.isEdit ? 'Editar Estudiante' : 'Nuevo Estudiante',
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(fontSize: 14, fontWeight: FontWeight.w500, text: 'Nombres del Estudiante'),
              InputField(label: 'Juan Carlos', controller: _nameCtrl),
              CustomText(fontSize: 14, fontWeight: FontWeight.w500, text: 'Apellidos del Estudiante'),
              InputField(label: 'Granda Arcos', controller: _lastNameCtrl),
              CustomText(fontSize: 14, fontWeight: FontWeight.w500, text: 'Código del Estudiante'),
              InputField(label: '234kj324', controller: _codeCtrl),
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
          text: widget.isEdit ? 'Actualizar' : 'Registrar',
          color: Colors.black,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (widget.isEdit) {
                provider.actualizarEstudiante(widget.student!['id'], _nameCtrl.text, _lastNameCtrl.text, _codeCtrl.text);
              } else {
                provider.agregarEstudiante(_nameCtrl.text, _lastNameCtrl.text, _codeCtrl.text);
              }
              Navigator.pop(context);
            }
          },
        )
      ],
    );
  }
}