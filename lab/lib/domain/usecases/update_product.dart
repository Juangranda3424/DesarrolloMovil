import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProduct{

  final ProductRepository repository;
  UpdateProduct(this.repository);
  //Metodo call ejecuta la acción.
  void call(Product product) => repository.updateProduct(product);

}