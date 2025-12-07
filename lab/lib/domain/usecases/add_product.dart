import '../entities/product.dart';
import '../repositories/product_repository.dart';

class AddProduct{

  final ProductRepository repository;
  AddProduct(this.repository);
  //Metodo call ejecuta la acción.
  void call(Product product) => repository.addProduct(product);
}