import 'package:flutter/material.dart';
import 'package:lab/presentation/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Productos'),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, "/detail");
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: provider.products.length,
          itemBuilder: (context, index) {
            final p = provider.products[index];
            return ListTile(
                title: Text(p.name),
                subtitle: Text("\$ ${p.price}"),
                onTap: () {
                  Navigator.pushNamed(context, "/edit", arguments: p);
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    provider.delete(p.id);
                  },
                )
            );
          }

      ),

    );
  }
}
