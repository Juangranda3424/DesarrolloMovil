class AikenParser {

  // Convierte texto AIKEN plano a lista de objetos Map

  static List<Map<String, dynamic>> parse(String contenidoArchivo) {
    List<Map<String, dynamic>> preguntas = [];
    List<String> lineas = contenidoArchivo.split('\n');

    String? preguntaActual;
    Map<String, String> opciones = {};
    String? respuestaCorrecta;

    for (var linea in lineas) {
      linea = linea.trim();
      if (linea.isEmpty) continue;

      // Detectar respuesta correcta (formato "ANSWER: A")

      if (linea.startsWith('ANSWER:')) {
        respuestaCorrecta = linea.split(':')[1].trim();

        if (preguntaActual != null) {
          preguntas.add({
            'texto': preguntaActual,
            'opciones': opciones, // Convertir a JSON string al guardar
            'respuesta_correcta': respuestaCorrecta,
            'tipo': 'SELECCION_MULTIPLE'
          });
        }
        // Reiniciar variables

        preguntaActual = null;
        opciones = {};
      }
      // Detectar opción (A. xxx, B) xxx)
      else if (RegExp(r'^[A-Z][\).]\s').hasMatch(linea)) {
        String letra = linea.substring(0, 1);
        String texto = linea.substring(3).trim();
        opciones[letra] = texto;
      }
      // Es una nueva pregunta
      else {
        preguntaActual = linea;
      }
    }
    return preguntas;
  }
}