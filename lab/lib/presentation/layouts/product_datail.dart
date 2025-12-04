import 'package:flutter/material.dart';
import 'package:lab/presentation/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/product.dart';

class ProductDatailPage extends StatefulWidget {
  const ProductDatailPage({super.key});

  @override
  State<ProductDatailPage> createState() => _ProductDatailPageState();
}

class _ProductDatailPageState extends State<ProductDatailPage> {

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  String? productId;

  //Sobreescribimos el didChangeDependencies para recibir parametros
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments as Product;

    if( arg != null ){
      productId = arg.id;
      nameController.text = arg.name;
      priceController.text = arg.precio.toString();
    }
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del producto'),
      ),
      body:  Column(
        children: [
          TextField(
            controller: nameController,
            decoration:  const InputDecoration(
              labelText:  'Nombre del Producto'
            ),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 20,),
          TextField(
            controller: priceController,
            decoration:  const InputDecoration(
                labelText:  'Precio del Producto'
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
              onPressed: (){
                if( productId != null){
                  provider.add(
                    Product(
                        DateTime.now().microsecondsSinceEpoch.toString(),
                        nameController.text,
                        double.parse(priceController.text)
                    )
                  );
                }
              },
              child: Text(
                'Agregar'
              )
          )
        ],
      ),
    );
  }
}
