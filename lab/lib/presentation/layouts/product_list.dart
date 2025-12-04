import 'package:flutter/material.dart';
import 'package:lab/presentation/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductListPage  extends StatefulWidget {
  const ProductListPage ({super.key});

  @override
  State<ProductListPage > createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage > {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Lista de productos")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/detail");
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: provider.products.length,
        itemBuilder: (context, index) {
          final product = provider.products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text(product.price.toString()),
            onTap: () {
              Navigator.pushNamed(context, "/edit", arguments: product);
            },
          );
        },
      ),
    );
  }
}
