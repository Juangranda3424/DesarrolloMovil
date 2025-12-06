import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/product.dart';
import '../providers/product_provider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // Controladores para capturar el texto que escribe el usuario
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  // Variable auxiliar para saber si estamos editando o creando.
  // Si es null = Estamos CREANDO un nuevo producto.
  // Si tiene valor = Estamos EDITANDO un producto existente.
  String? productId;

  //Sobrescribimos el metodo didChangeDependecies para recibir los argumentos
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Recibimos el argumento enviado desde la pantalla anterior (si existe).
    // "as Product?" intenta convertir el argumento a nuestro tipo de dato.
    final product = ModalRoute.of(context)?.settings.arguments as Product?;
    // Si recibimos un producto (estamos en modo EDICIÓN):
    if (product != null){
      productId = product.id;
      nameController.text = product.name;
      priceController.text = product.price.toString();
    }
  }


  @override
  Widget build(BuildContext context) {
    // Obtenemos la referencia al Provider para poder llamar a los métodos add/update.
    // listen: false, porque en este build no necesitamos redibujar si la lista cambia,
    // solo queremos disparar acciones.
    final provider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(productId == null ? 'Nuevo Producto' : 'Detalle de Producto'),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Nombre',),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: 'Precio',),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (productId== null){
                // LÓGICA DE GUARDADO
                // Si productId es null, es un NUEVO registro
                provider.add(
                  Product(DateTime.now().millisecondsSinceEpoch.toString(),
                    nameController.text,
                    double.tryParse(priceController.text) ?? 0,
                  ),
                );
              }else{
                // Si productId YA TIENE valor, es una ACTUALIZACIÓN
                provider.update(
                  Product(
                      productId!,
                      nameController.text,
                      double.tryParse(priceController.text) ?? 0),
                );
              }
              Navigator.pop(context);
            },
            child: Text(productId == null ? 'Agregar' : 'Actualizar'),
          ),
        ],
      ),
    );
  }
}
