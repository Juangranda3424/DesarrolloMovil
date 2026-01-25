import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {

  final String apiKey = dotenv.get('API_KEY_GEMINI');


  Future<String?> analizarExamen({
    required List<File> imagenes,
    required String listaPreguntasYRespuestas,
  }) async {

    final model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
    );

    // 1. PROCESAR MÚLTIPLES IMÁGENES
    // Convertimos cada File en un DataPart (bytes)
    List<Part> imageParts = [];
    for (var archivo in imagenes) {
      final bytes = await archivo.readAsBytes();
      imageParts.add(DataPart('image/jpeg', bytes));
    }

    // 2. PROMPT AJUSTADO PARA MÚLTIPLES PÁGINAS
    final prompt = TextPart('''
      Actúa como un profesor asistente experto.
      
      CONTEXTO:
      Te estoy enviando ${imagenes.length} imágenes que corresponden a las páginas de un examen contestado por un estudiante.
      Abajo te proveo la lista de preguntas y las respuestas correctas esperadas:
      $listaPreguntasYRespuestas
      
      TAREA:
      1. Analiza TODAS las imágenes en conjunto como un solo examen.
      2. Identifica las marcas del estudiante (círculos, equis, texto escrito).
      3. Compara las respuestas del estudiante con las correctas.
      4. Calcula el puntaje total.
      
      FORMATO DE SALIDA (ESTRICTO JSON):
      Debes responder ÚNICAMENTE con un JSON válido con esta estructura:
      {
        "estudiante_detectado": "nombre si es legible en alguna página",
        "detalles": [
           {"pregunta_id": 1, "respuesta_detectada": "A", "es_correcta": true, "puntaje": 1},
           {"pregunta_id": 2, "respuesta_detectada": "V", "es_correcta": false, "puntaje": 0}
        ],
        "nota_final": 8.5
      }
       IMPORTANTE: No añadas bloques de código markdown (```json), solo el texto plano del JSON y califica con el puntaje no le modifiques.
    ''');

    try {
      // 3. ENVIAR PROMPT + TODAS LAS IMÁGENES
      final response = await model.generateContent([
        Content.multi([prompt, ...imageParts]) // Spread operator (...) para unir todo
      ]);

      String? text = response.text;

      // 4. LIMPIEZA DE SEGURIDAD
      // A veces Gemini pone ```json al principio, esto lo elimina para evitar errores al decodificar
      if (text != null) {
        text = text.replaceAll('```json', '').replaceAll('```', '').trim();
      }

      return text;

    } catch (e) {
      print('Error con Gemini: $e');
      return null;
    }
  }
}