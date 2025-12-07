  import 'package:flutter/cupertino.dart';
  import '../../domain/entities/product.dart';
  import '../../domain/usecases/add_product.dart';
  import '../../domain/usecases/delete_product.dart';
  import '../../domain/usecases/get_products.dart';
  import '../../domain/usecases/update_product.dart';


  class ProductProvider extends ChangeNotifier{
    final GetProducts getProductsUseCase;
    final AddProduct addProductUseCase;
    final UpdateProduct updateProductUseCase;
    final DeleteProduct deleteProductUseCase;

    ProductProvider({
      required this.addProductUseCase,
      required this.deleteProductUseCase,
      required this.getProductsUseCase,
      required this.updateProductUseCase
    });

    List get products => getProductsUseCase();

    void add( Product product){
      addProductUseCase(product);
      notifyListeners();
    }

    void update ( Product product ){
      updateProductUseCase(product);
      notifyListeners();
    }

    void delete (String id){
      deleteProductUseCase(id);
      notifyListeners();
    }

  }