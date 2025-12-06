import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/layouts/product_datail.dart';
import 'presentation/layouts/product_list.dart';
import 'presentation/providers/product_provider.dart';

import 'data/repositories/product_repository_impl.dart';
import 'data/datasources/product_memory_datasources.dart';

import 'domain/usecases/add_product.dart';
import 'domain/usecases/delete_product.dart';
import 'domain/usecases/get_products.dart';
import 'domain/usecases/update_product.dart';

void main() {
  //Creamos la Fuente de Datos (La memoria RAM)
  final datasource  = ProductMemoryDataSources();
  // Creamos el Repositorio e inyectamos la Fuente de Datos
  // El repositorio ahora sabe que debe guardar en memoria.
  final repository = ProductRepositoryImpl(datasource);
  // Creamos el Provider (Gestor de Estado)
  // Aquí inyectamos los 4 Casos de Uso, y a cada Caso de Uso le damos el Repositorio.
  // Esto crea la cadena: Provider -> UseCase -> Repository -> DataSource

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>
          ProductProvider(
            getProductsUseCase: GetProducts(repository),
            addProductUseCase: AddProduct(repository),
            updateProductUseCase: UpdateProduct(repository),
            deleteProductUseCase: DeleteProduct(repository),
          ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean Architecture - productos',
      initialRoute: '/',
      routes: {
        // Pantalla Principal (Lista)
        '/': (context) => const ProductListPage(),
        // Pantalla de Detalle (Para CREAR)
        '/detail': (context) => const ProductDetailPage(),
        // Pantalla de Detalle (Para EDITAR)
        '/edit': (context) => const ProductDetailPage(),
      }
    );
  }
}
