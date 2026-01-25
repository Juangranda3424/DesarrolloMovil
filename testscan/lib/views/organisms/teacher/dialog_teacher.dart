import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testscan/viewmodels/app_provider.dart';
import 'package:testscan/views/atoms/custom_button.dart';
import 'package:testscan/views/atoms/custom_text.dart';
import 'package:testscan/views/atoms/input_field.dart';

class DialogTeacher extends StatefulWidget {
  const DialogTeacher({super.key});

  @override
  State<DialogTeacher> createState() => _DialogTeacherState();
}

class _DialogTeacherState extends State<DialogTeacher> {
  final _nomCtrl = TextEditingController();
  final _apeCtrl = TextEditingController();
  final _codCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Cargamos los datos actuales del provider al abrir el modal
    final d = Provider.of<AppProvider>(context, listen: false).docente;
    if (d != null) {
      _nomCtrl.text = d['nombres'] ?? '';
      _apeCtrl.text = d['apellidos'] ?? '';
      _codCtrl.text = d['codigo'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);

    return AlertDialog(
      icon: const Icon(Icons.person, color: Colors.black, size: 50),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Center(
        child: CustomText(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          text: "Configuración del Docente",
          textAlign: TextAlign.center,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(fontSize: 14, fontWeight: FontWeight.w500, text: 'Nombres del Docente'),
            InputField(label: "Juan Carlos", controller: _nomCtrl),
            CustomText(fontSize: 14, fontWeight: FontWeight.w500, text: 'Apellidos del Docente'),
            InputField(label: "Granda Arcos", controller: _apeCtrl),
            CustomText(fontSize: 14, fontWeight: FontWeight.w500, text: 'Código del Docente'),
            InputField(label: "12343jer", controller: _codCtrl),
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
          onPressed: () async {
            await provider.actualizarDocenteUnico(
                _nomCtrl.text,
                _apeCtrl.text,
                _codCtrl.text
            );
            if (context.mounted) Navigator.pop(context);
          },
        )
      ],
    );
  }
}
