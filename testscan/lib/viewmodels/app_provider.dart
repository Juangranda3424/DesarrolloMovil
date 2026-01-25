import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:testscan/data/local/database_helper.dart';
import 'package:testscan/services/gemini_service.dart';
import 'package:testscan/utils/aiken_parser.dart';

class AppProvider extends ChangeNotifier {
  // Datos en memoria
  List<Map<String, dynamic>> materias = [];
  List<Map<String, dynamic>> pruebas = [];
  List<Map<String, dynamic>> estudiantes = [];
  List<Map<String, dynamic>> preguntas = [];
  bool isLoading = false;
  Map<String, dynamic>? docente;

  // Cargar datos iniciales
  Future<void> initData() async {
    isLoading = true;
    notifyListeners();
    materias = await DatabaseHelper.instance.getAllMaterias();
    estudiantes = await DatabaseHelper.instance.getAllEstudiantes();
    await cargarDocenteUnico();
    isLoading = false;
    notifyListeners();
  }

  // --- Lógica Materias ---
  Future<void> agregarMateria(String nombre, String codigo) async {
    await DatabaseHelper.instance.createMateria({'nombre': nombre, 'codigo': codigo});
    await initData();
  }

  Future<void> actualizarMateria(int id, String nombre, String codigo) async {
    await DatabaseHelper.instance.updateMateria({'id': id, 'nombre': nombre, 'codigo': codigo});
    await initData();
  }

  // --- Lógica Pruebas ---
  Future<void> cargarPruebas(int materiaId) async {
    pruebas = await DatabaseHelper.instance.getPruebasByMateriaId(materiaId);
    notifyListeners();
  }

  Future<void> cargarTodasLasPruebas() async {
    pruebas = await DatabaseHelper.instance.getAllPruebas();
    notifyListeners();
  }

  Future<void> crearPrueba(int materiaId, String nombre, String intro) async {
    await DatabaseHelper.instance.createPrueba({
      'materia_id': materiaId,
      'nombre': nombre,
      'fecha': DateTime.now().toString(),
      'introduccion': intro
    });
    await cargarPruebas(materiaId);
  }

  Future<void> actualizarPrueba(int materiaId, int id, String nombre, String intro) async {
    await DatabaseHelper.instance.updatePrueba({'id': id, 'nombre': nombre, 'introduccion': intro});
    await cargarPruebas(materiaId);
  }


  // --- Lógica Importar AIKEN ---
  Future<bool> importarPreguntas(int pruebaId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      String content = await file.readAsString();

      // Usamos tu parser
      List<Map<String, dynamic>> preguntas = AikenParser.parse(content);

      // Guardamos en BD
      for (var p in preguntas) {
        await DatabaseHelper.instance.createPregunta({
          'prueba_id': pruebaId,
          'texto': p['texto'],
          'tipo': p['tipo'],
          'opciones': jsonEncode(p['opciones']), // Convertir map a JSON string
          'respuesta_correcta': p['respuesta_correcta'],
          'valor': 1
        });
      }
      notifyListeners();

      return true;

    }
    return false;
  }

  // --- Lógica Calificación con IA ---
  Future<Map<String, dynamic>?> calificarExamen(
      int pruebaId, int estudianteId, List<File> imagenes) async {

    isLoading = true;
    notifyListeners();

    try {
      // 1. Obtener preguntas correctas de la BD
      final preguntasDB = await DatabaseHelper.instance.getPreguntasByPruebaId(pruebaId);

      // Formatear para enviar a Gemini como contexto
      StringBuffer contexto = StringBuffer();
      for (var p in preguntasDB) {
        contexto.writeln("ID: ${p['id']} - Pregunta: ${p['texto']} - Respuesta Correcta: ${p['respuesta_correcta']}");
      }

      // 2. Llamar a tu servicio Gemini
      GeminiService gemini = GeminiService();
      String? jsonResultado = await gemini.analizarExamen(
          imagenes: imagenes,
          listaPreguntasYRespuestas: contexto.toString()
      );

      if (jsonResultado != null) {
        // Parsear JSON
        Map<String, dynamic> data = jsonDecode(jsonResultado);

        // 3. Guardar en BD
        List<String> paths = imagenes.map((e) => e.path).toList();

        await DatabaseHelper.instance.createResultado({
          'prueba_id': pruebaId,
          'estudiante_id': estudianteId,
          'nota_total': data['nota_final'],
          'respuesta_json': jsonResultado,
          'imagenes_paths': jsonEncode(paths),
          'fecha_calificacion': DateTime.now().toString()
        });

        isLoading = false;
        notifyListeners();
        return data;
      }
    } catch (e) {
      print("Error calificando: $e");
    }

    isLoading = false;
    notifyListeners();
    return null;
  }

  // Logica de estudiantes

  Future<void> agregarEstudiante(String nombres, String apellidos, String codigo) async {
    await DatabaseHelper.instance.createEstudiante({'nombres': nombres, 'apellidos': apellidos, 'codigo': codigo});
    await initData();
  }

  Future<void> actualizarEstudiante(int id, String nombres, String apellidos, String codigo) async {
    await DatabaseHelper.instance.updateEstudiante({'id': id, 'nombres': nombres, 'apellidos': apellidos, 'codigo': codigo});
    await initData();
  }

  // Logica de preguntas

  // 1. Cargar preguntas de una prueba específica
  Future<void> cargarPreguntas(int pruebaId) async {
    isLoading = true;
    notifyListeners();
    preguntas = await DatabaseHelper.instance.getPreguntasByPruebaId(pruebaId);
    isLoading = false;
    notifyListeners();
  }

  // 2. Crear pregunta manual
  Future<void> crearPregunta(Map<String, dynamic> data) async {
    // Asegúrate de que el map contenga 'texto', 'tipo', 'opciones', 'respuesta_correcta', 'valor' y 'prueba_id'
    await DatabaseHelper.instance.createPregunta(data);
    await cargarPreguntas(data['prueba_id']); // Recargar la lista
  }

  // 3. Actualizar pregunta
  Future<void> actualizarPregunta(int id, Map<String, dynamic> data) async {
    data['id'] = id;
    await DatabaseHelper.instance.updatePregunta(data);
    await cargarPreguntas(data['prueba_id']);
  }

  // 4. Eliminar pregunta
  Future<void> eliminarPregunta(int id, int pruebaId) async {
    await DatabaseHelper.instance.deletePregunta(id);
    await cargarPreguntas(pruebaId);
  }

  //Logica de docente

  // Intentar cargar al docente con ID 1
  Future<void> cargarDocenteUnico() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> res = await db.query(
        'docentes',
        where: 'id = ?',
        whereArgs: [1]
    );

    if (res.isNotEmpty) {
      docente = res.first;
    } else {
      docente = null;
    }
    notifyListeners();
  }
  // Guardar o actualizar siempre el registro 1
  Future<void> actualizarDocenteUnico(String nombres, String apellidos, String codigo) async {
    final db = await DatabaseHelper.instance.database;

    Map<String, dynamic> datos = {
      'nombres': nombres,
      'apellidos': apellidos,
      'codigo': codigo
    };

    if (docente == null) {
      await db.insert('docentes', datos);
    } else {
      await db.update('docentes', datos, where: 'id = ?', whereArgs: [1]);
    }
    await cargarDocenteUnico();
  }

}