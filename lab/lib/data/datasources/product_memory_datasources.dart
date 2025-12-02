import '../../domain/entities/product.dart';

class ProductMemoryDataSources {

  final List<Product> _products = [];

  //Cargamos toda la lista
  List<Product> getAll() => _products;

  //Agregar el producto
  void add(Product product) => _products.add(product);

  //Actualizar el producto
  void update(Product product){
    final index = _products.indexWhere(
        (e)=> e.id == product.id
    );

    if (index != -1) _products[index] = product;

  }

  //Eliminar el producto
  void delete(String id){
    _products.removeWhere(
        (e) => e.id == id
    );


  }


}

//cuando utilizamos una variable dentro de la funcion es con _ basjo al inicio _products
//cuando viene de afuera de usa al final products_
