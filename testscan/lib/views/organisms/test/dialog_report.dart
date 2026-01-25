import 'package:flutter/material.dart';
import 'package:testscan/data/local/database_helper.dart';
import 'package:testscan/utils/excel_generator.dart';
import 'package:testscan/views/atoms/custom_text.dart';

class DialogReport extends StatelessWidget {
  final int pruebaId;
  final String nombrePrueba;

  const DialogReport({
    super.key,
    required this.pruebaId,
    required this.nombrePrueba
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.analytics, color: Colors.black, size: 50),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Column(
        children: [
          CustomText(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            text: 'Resultados',
          ),
          CustomText(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
            text: nombrePrueba,
          ),
        ],
      ),
      content: SizedBox(
        // Le damos un ancho fijo para que no se deforme el diálogo
        width: MediaQuery.of(context).size.width * 0.9,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: DatabaseHelper.instance.getResultadosByPruebaId(pruebaId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator(color: Colors.black)),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const SizedBox(
                height: 100,
                child: Center(child: Text("No hay calificaciones aún")),
              );
            }

            final resultados = snapshot.data!;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(),
                // Lista de notas (limitamos la altura para que el diálogo no se salga de la pantalla)
                Flexible(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: resultados.length,
                      itemBuilder: (ctx, i) {
                        final r = resultados[i];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const CircleAvatar(
                            backgroundColor: Colors.black12,
                            child: Icon(Icons.person, color: Colors.black54),
                          ),
                          title: Text(
                            "${r['nombres']} ${r['apellidos']}",
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              r['nota_total'].toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Botón de exportar integrado en el contenido
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.table_chart),
                    label: const Text("Exportar a Excel"),
                    onPressed: () async {
                      await ExcelGenerator.exportarResultados("Reporte_$pruebaId", resultados);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Excel generado con éxito"))
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}