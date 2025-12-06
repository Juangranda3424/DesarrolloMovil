import '../../domain/repositories/product_repository.dart';
import '../../domain/entities/product.dart';
import '../datasources/product_memory_datasources.dart';

class ProductRepositoryImpl implements ProductRepository
{
  final ProductMemoryDataSources dataSources;

  ProductRepositoryImpl(this.dataSources);

  @override
  List<Product> getProducts() => dataSources.getAll();

  @override
  void addProduct(Product product) => dataSources.add(product);

  @override
  void updateProduct(Product product) => dataSources.update(product);

  @override
  void deleteProduct(String id) => dataSources.delete(id);
}