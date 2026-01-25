import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testscan/viewmodels/app_provider.dart';
import 'package:testscan/views/atoms/custom_button.dart';
import 'package:testscan/views/atoms/custom_text.dart';
import 'package:testscan/views/atoms/input_field.dart';

class DialogClasses extends StatefulWidget {

  final bool isEdit;
  final Map? classroom;


  const DialogClasses({super.key, this.isEdit = false, this.classroom});

  @override
  State<DialogClasses> createState() => _DialogClassesState();
}

class _DialogClassesState extends State<DialogClasses> {

  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  //Llave del formulario
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameCtrl.text = widget.isEdit ? widget.classroom!['nombre'] : '';
    _codeCtrl.text = widget.isEdit ? widget.classroom!['codigo'] : '';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameCtrl.dispose();
    _codeCtrl.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return AlertDialog(
      icon: const Icon(Icons.school, color: Colors.black, size: 50),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Center(
        child: CustomText(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          text: widget.isEdit ? 'Editar Materia' : 'Nueva Materia',
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(fontSize: 14, fontWeight: FontWeight.w500, text: 'Nombre de la Materia'),
              InputField(label: 'Ejem: Programación II', controller: _nameCtrl,),
              CustomText(fontSize: 14, fontWeight: FontWeight.w500, text: 'Código de la Materia'),
              InputField(label: 'Ejem: 4566', controller: _codeCtrl,),
              const SizedBox(height: 10),
            ],
          )
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
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
          child: Text("Cancelar"),
        ),
        CustomButton(
          text: widget.isEdit ? 'Actualizar' : 'Guardar',
          color: Colors.black,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (widget.isEdit) {
                provider.actualizarMateria(widget.classroom!['id'], _nameCtrl.text, _codeCtrl.text);
              }else{
                provider.agregarMateria(_nameCtrl.text, _codeCtrl.text);
              }
              Navigator.pop(context);
            }
          }
        )
      ],
    );
  }
}
