import 'package:product_app/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;

  int get selectedProductIndex => _selectedProductIndex;

  List<Product> get products {
    return List.from(_products);
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) return null;
    return _products[_selectedProductIndex];
  }

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
  }
}
