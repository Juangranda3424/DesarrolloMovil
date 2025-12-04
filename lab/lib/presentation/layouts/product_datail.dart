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
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  String? productId;

  //sobrescribimos el m'etodo didChangeDependecies para recibir los argumentos
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //recibir los argumentos
    final product = ModalRoute.of(context)?.settings.arguments as Product?;
    if (product != null){
      productId = product.id;
      nameController.text = product.name;
      priceController.text = product.precio.toString();
    }
  }


  @override
  Widget build(BuildContext context) {
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
                provider.add(
                  Product(DateTime.now().millisecondsSinceEpoch.toString(),
                    nameController.text,
                    double.tryParse(priceController.text) ?? 0,
                  ),
                );
              }else{
                provider.update(
                  Product(
                      DateTime.now().millisecondsSinceEpoch.toString(),
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
