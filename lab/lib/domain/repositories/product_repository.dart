
import '../entities/product.dart';

abstract class ProductRepository {
  List<Product> getProducts();
  void addProduct(Product product);
  void updateProduct(Product product);
  void deleteProduct(String id);
}


//Contrato del repositorio
//Implementa la capa de datos