import '../repositories/product_repository.dart';

class GetProducts{
  final ProductRepository repository;

  GetProducts(this.repository);
  //Metodo call ejecuta la acción.
  List call()=>repository.getProducts();
}