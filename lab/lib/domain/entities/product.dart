// Entidad: Objeto que representa un componente del negocio (Producto).
// Se mantiene limpia de dependencias externas (Frameworks o DB).
// Solo contiene datos y validaciones propias del negocio.
class Product {
  String id;
  String name;
  double price;
  Product(this.id, this.name, this.price){
    if (price < 0) throw Exception("El precio no puede ser negativo");
  }
}
