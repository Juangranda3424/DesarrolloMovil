import 'package:lab/domain/repositories/product_repository.dart';

class DeleteProduct{

  final ProductRepository repository;
  DeleteProduct(this.repository);
  //Metodo call ejecuta la acción.

  void call(String id) => repository.deleteProduct(id);
}