import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ExcelGenerator {
  static Future<void> exportarResultados(
      String nombrePrueba, List<Map<String, dynamic>> resultados) async {

    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Resultados'];

    // Encabezados
    List<String> headers = ['Estudiante', 'Código', 'Nota', 'Estado'];
    sheetObject.appendRow(headers.map((e) => TextCellValue(e)).toList());

    // Datos
    for (var row in resultados) {
      double nota = row['nota_total'] ?? 0.0;
      String estado = nota >= 7.0 ? "APROBADO" : "REPROBADO"; // Lógica ejemplo

      sheetObject.appendRow([
        TextCellValue("${row['nombres']} ${row['apellidos']}"),
        TextCellValue(row['codigo']),
        TextCellValue(nota.toStringAsFixed(2)),
        TextCellValue(estado),
      ]);
    }

    // Guardar
    final directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/Reporte_$nombrePrueba.xlsx';
    final File file = File(path);
    final List<int>? fileBytes = excel.save();

    if (fileBytes != null) {
      await file.writeAsBytes(fileBytes);
      print("Excel guardado en: $path");
      Share.shareXFiles([XFile(path)], text: 'Reporte de notas');
    }
  }
}