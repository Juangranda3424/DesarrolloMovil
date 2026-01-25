import 'dart:convert'; // Necesario para decodificar las opciones JSON
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfGenerator {

  static Future<void> generarExamenPDF({
    required String materia,
    required String docente,
    required String introduccion,
    required List<Map<String, dynamic>> preguntas, // Recibe la lista de la BD
  }) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return [
            // 1. ENCABEZADO
            _buildHeader(materia, docente, introduccion),

            pw.SizedBox(height: 20),
            pw.Divider(),
            pw.SizedBox(height: 20),

            // 2. LISTA DE PREGUNTAS
            ...preguntas.asMap().entries.map((entry) {
              int index = entry.key + 1; // Número de pregunta (1, 2, 3...)
              Map<String, dynamic> pregunta = entry.value;

              return _buildPreguntaItem(index, pregunta);
            }).toList(),
          ];
        },
      ),
    );

    // Guardar y compartir/imprimir
    await Printing.sharePdf(bytes: await pdf.save(), filename: 'examen_$materia.pdf');
  }

  // Widget para el Encabezado
  static pw.Widget _buildHeader(String materia, String docente, String introduccion) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Center(
          child: pw.Text("UNIVERSIDAD DE LAS FUERZAS ARMADAS - ESPE",
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("Materia: $materia", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text("Fecha: ______________"),
            ]
        ),
        pw.SizedBox(height: 5),
        pw.Text("Docente: $docente"),
        pw.SizedBox(height: 5),
        pw.Text("NRC: ______________"),
        pw.SizedBox(height: 5),
        pw.Text("Estudiante: __________________________________________________"),
        pw.SizedBox(height: 5),
        pw.Text("Instrucciones: $introduccion"),
      ],
    );
  }

  // Widget para cada Pregunta
  static pw.Widget _buildPreguntaItem(int numero, Map<String, dynamic> data) {
    // Las opciones vienen como String JSON en SQLite "{\"A\":\"...\"}", hay que convertirlas.
    Map<String, dynamic> opciones = {};
    if (data['opciones'] != null) {
      try {
        opciones = jsonDecode(data['opciones']);
      } catch (e) {
        opciones = {"Error": "No se pudieron cargar las opciones"};
      }
    }

    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 10), // Espacio entre preguntas
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Texto de la pregunta
          pw.Text(
            "$numero. ${data['texto']}",
            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 5),

          // Renderizar opciones (A, B, C...)
          if (data['tipo'] == 'SELECCION_MULTIPLE')
            ...opciones.entries.map((op) {
              return pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 5, left: 10),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Círculo de la letra (ej: ( A )) para que el alumno encierre
                    pw.Text(
                        "( ${op.key} )",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)
                    ),
                    pw.SizedBox(width: 5),
                    // Texto de la respuesta
                    pw.Expanded(
                      child: pw.Text(
                        "${op.value}",
                        style: const pw.TextStyle(fontSize: 7),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

          // Espacio visual para separar preguntas claramente para la IA
          pw.SizedBox(height: 1),
        ],
      ),
    );
  }
}