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
        centerTitle: true,
        backgroundColor: Colors.black12,
        title: Text(productId == null ? 'NUEVO PRODUCTO' : 'DETALLE DE PRODUCTO',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 12,),
          Icon(Icons.icecream_outlined, size: 200,),
          SizedBox(height: 12,),
          Text(productId == null ? 'Ingresa un nuevo helado al inventario' : 'Actualiza los valores del helado seleccionado',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Precio',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 10),
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
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.black),

            ),
            child: Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 0),
                child:
                  Text(productId == null ? 'Agregar' : 'Actualizar', style: TextStyle(color: Colors.white),),
            )
          ),
        ],
      ),
    );
  }
}
