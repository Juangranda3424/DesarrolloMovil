import 'package:flutter/material.dart';
import '../providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LISTA DE HELADOS',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.black12,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, "/detail");
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: ListView.builder(
          itemCount: provider.products.length,
          itemBuilder: (context, index) {
            final p = provider.products[index];
            return Card(
              color: Colors.black,
              child: ListTile(
                leading: Icon(
                  Icons.icecream_outlined,
                  size: 50.0,
                  color: Colors.white,
                ),
                title: Text(p.name, style: TextStyle(color: Colors.white),),
                subtitle: Text("\$ ${p.price}", style: TextStyle(color: Colors.white),),
                onTap: () {
                  Navigator.pushNamed(context, "/edit", arguments: p);
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red,),
                  onPressed: () {
                    provider.delete(p.id);
                  },
                ),
              ),
            );
          }

      ),

    );
  }
}
