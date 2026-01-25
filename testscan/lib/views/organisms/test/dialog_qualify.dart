import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:testscan/viewmodels/app_provider.dart';
import 'package:testscan/views/atoms/custom_button.dart';
import 'package:testscan/views/atoms/custom_text.dart';

class DialogQualify extends StatefulWidget {

  final int pruebaId;

  const DialogQualify({super.key, required this.pruebaId});

  @override
  State<DialogQualify> createState() => _DialogQualifyState();
}

class _DialogQualifyState extends State<DialogQualify> {

  final ImagePicker _picker = ImagePicker();
  List<File> _imagenes = [];
  Map<String, dynamic>? _resultado;
  int? _estudianteSeleccionadoId;

  Future<void> _tomarFoto(ImageSource source) async {
    final XFile? photo = await _picker.pickImage(source: source, imageQuality: 85);
    if (photo != null) {
      setState(() => _imagenes.add(File(photo.path)));
      // 2. Si la foto es nueva (de la cámara), guardarla en la galería
      if (source == ImageSource.camera) {
        try {
          // Guardamos en la galería
          await Gal.putImage(photo.path, album: 'Examenes_DroidTest');

          // Opcional: Feedback al usuario
          debugPrint("Imagen guardada en el álbum Examenes_DroidTest");
        } catch (e) {
          debugPrint("Error al guardar en galería: $e");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    // Extraemos el estado de carga para usarlo localmente
    final bool cargando = provider.isLoading;

    return AlertDialog(
      icon: const Icon(Icons.history_edu, color: Colors.black, size: 50),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Center(
        child: CustomText(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          text: 'Calificar Examen',
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Deshabilitamos el dropdown si está cargando
            AbsorbPointer(
              absorbing: cargando,
              child: Opacity(
                  opacity: cargando ? 0.5 : 1.0,
                  child: _buildStudentDropdown(provider)
              ),
            ),
            CustomText(fontSize: 14, fontWeight: FontWeight.w500, text: 'Capturar Examen'),
            _buildPhotoButtons(cargando), // Pasamos el estado a los botones de foto
            _buildPhotoPreview(),
            if (_resultado != null) _buildResultCard(),

            // Indicador de carga visual debajo de las fotos
            if (cargando)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(color: Colors.black),
                      SizedBox(height: 10),
                      Text("La IA está calificando...", style: TextStyle(fontStyle: FontStyle.italic))
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: [
        // Botón Cancelar se deshabilita si está cargando
        TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red, width: 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: cargando ? null : () => Navigator.pop(context),
            child: const Text("Cancelar")
        ),

        // Botón Calificar con lógica de loading
        SizedBox(
          width: 120,
          child: CustomButton(
            text: cargando ? '' : 'Calificar',
            color: Colors.black,
            // Si está cargando o faltan datos, el onPressed es null (se deshabilita)
            onPressed: (cargando || _estudianteSeleccionadoId == null || _imagenes.isEmpty)
                ? null
                : () async {
              final res = await provider.calificarExamen(
                  widget.pruebaId, _estudianteSeleccionadoId!, _imagenes);
              setState(() => _resultado = res);

              if(res != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Calificación completada"))
                );
              }
            },
          ),
        )
      ],
    );
  }

  // Modificamos este widget para que acepte el estado "cargando"
  Widget _buildPhotoButtons(bool cargando) => Row(
    children: [
      Expanded(
          child: IconButton(
              onPressed: cargando ? null : () => _tomarFoto(ImageSource.camera),
              icon: Icon(Icons.camera_alt_rounded, size: 50, color: cargando ? Colors.grey : Colors.black)
          )
      ),
      Expanded(
        child: IconButton(
            onPressed: cargando ? null : () => _tomarFoto(ImageSource.gallery),
            icon: Icon(Icons.photo, size: 50, color: cargando ? Colors.grey : Colors.black)
        ),
      ),
    ],
  );

  Widget _buildStudentDropdown(AppProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // constraints.maxWidth es el ancho real disponible dentro del diálogo
          return DropdownMenu<int>(
            initialSelection: _estudianteSeleccionadoId,
            // Forzamos a que use el 100% del ancho del diálogo
            width: constraints.maxWidth,
            label: const Text("Seleccionar Estudiante"),
            leadingIcon: const Icon(Icons.person_outline),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            onSelected: (int? value) {
              setState(() {
                _estudianteSeleccionadoId = value;
              });
            },
            dropdownMenuEntries: provider.estudiantes.map((e) {
              return DropdownMenuEntry<int>(
                value: e['id'] as int,
                label: "${e['nombres']} ${e['apellidos']}",
                leadingIcon: const Icon(Icons.badge_outlined, size: 20),
              );
            }).toList(),
          );
        },
      ),
    );
  }


  Widget _buildPhotoPreview() => _imagenes.isEmpty ? const SizedBox() : Container(
    height: 120,
    margin: const EdgeInsets.only(top: 15),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _imagenes.length,
      itemBuilder: (ctx, i) => Stack(
        children: [
          Padding(padding: const EdgeInsets.all(4.0), child: Image.file(_imagenes[i], width: 80, height: 120, fit: BoxFit.cover)),
          Positioned(right: 0, child: IconButton(icon: const Icon(Icons.cancel, color: Colors.red), onPressed: () => setState(() => _imagenes.removeAt(i)))),
        ],
      ),
    ),
  );

  Widget _buildResultCard() => Container(
    margin: const EdgeInsets.only(top: 20),
    child: Column(
      children: [
        Text("NOTA: ${_resultado!['nota_final']}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
      ],
    ),
  );

}
