import 'package:product_app/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;
  bool showFavorites = false;

  int get selectedProductIndex => _selectedProductIndex;

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get displayedProduct {
    if (showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  void toggleShowFavState() {
    showFavorites = !showFavorites;
    notifyListeners();
  }

  bool get isDisplayedFavOnly {
    return showFavorites;
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
    notifyListeners();
  }

  void toggleFavoriteStatus() {
    bool isCurrentlyFav = selectedProduct.isFavorite;
    bool newStatus = !isCurrentlyFav;
    final Product updatedProduct = Product(
        title: selectedProduct.title,
        desc: selectedProduct.desc,
        image: selectedProduct.image,
        price: selectedProduct.price,
        isFavorite: newStatus);

    _products[_selectedProductIndex] = updatedProduct;
    _selectedProductIndex = null;
    notifyListeners();
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
    notifyListeners();
  }
}
