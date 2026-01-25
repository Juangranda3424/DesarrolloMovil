import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testscan/data/local/database_helper.dart';
import 'package:testscan/utils/pdf_generator.dart';
import 'package:testscan/viewmodels/app_provider.dart';
import 'package:testscan/views/organisms/test/dialog_qualify.dart';
import 'package:testscan/views/organisms/test/dialog_report.dart';
import 'package:testscan/views/organisms/test/dialog_test.dart';
import 'package:testscan/views/organisms/test/test_card.dart';

class ListTests extends StatefulWidget {
  final Map<String, dynamic> materia;
  const ListTests({super.key, required this.materia});

  @override
  State<ListTests> createState() => _ListTestsState();
}

class _ListTestsState extends State<ListTests> {

  @override
  void initState() {
    super.initState();
    // Cargamos las pruebas al iniciar el widget
    _cargarDatos();
  }

  @override
  void didUpdateWidget(covariant ListTests oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si el usuario cambia de materia en el Dropdown, recargamos la lista
    if (oldWidget.materia['id'] != widget.materia['id']) {
      _cargarDatos();
    }
  }

  void _cargarDatos() {
    Future.microtask(() {
      final provider = Provider.of<AppProvider>(context, listen: false);
      provider.cargarPruebas(widget.materia['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    // Filtramos las pruebas que pertenezcan a esta materia
    final pruebasFiltradas = provider.pruebas;

    return ListView.builder(
      itemCount: pruebasFiltradas.length,
      itemBuilder: (ctx, i) {
        final p = pruebasFiltradas[i];
        return TestCard(
          prueba: p,
          onImport: () async {
            bool response = await provider.importarPreguntas(p['id']);

            if(response){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Preguntas importadas con éxito")));
            }else{
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error al importar preguntas, Intente de nuevo")));
            }
          },
          onPdf: () async {
            final preguntas = await DatabaseHelper.instance.getPreguntasByPruebaId(p['id']);
            await PdfGenerator.generarExamenPDF(
                materia: widget.materia['nombre'],
                docente: provider.docente != null ? "${provider.docente!['nombres']} ${provider.docente!['apellidos']}" : "",
                introduccion: p['introduccion'],
                preguntas: preguntas
            );
          },
          onExcel: () {
            showDialog(
              context: context,
              builder: (ctx) => DialogReport(
                pruebaId: p['id'],
                nombrePrueba: p['nombre'],
              ),
            );
          },
          onCalificar: () {
            showDialog(
              context: context,
              builder: (ctx) => DialogQualify(pruebaId: p['id']),
            );
          },
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => DialogTest(isEdit: true, test: p, materiaId: widget.materia['id'],),
            );
          },
        );
      },
    );
  }
}