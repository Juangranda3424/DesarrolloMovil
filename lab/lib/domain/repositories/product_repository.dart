
import '../entities/product.dart';

//Se define el Qué se puede hacer con el repositorio
//Implementa la capa de datos
abstract class ProductRepository {
  List<Product> getProducts();
  void addProduct(Product product);
  void updateProduct(Product product);
  void deleteProduct(String id);
}