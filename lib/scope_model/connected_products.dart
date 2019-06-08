import 'package:product_app/models/product.dart';
import 'package:product_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class ConnectedProducts extends Model {
  User _authenticatedUser;
  List<Product> _products = [];
  int _selProductIndex;

  void addProduct(String title, String desc, String image, double price) {
    Product newProduct = Product(
        title: title,
        desc: desc,
        image: image,
        price: price,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id);
    _products.add(newProduct);
    notifyListeners();
  }
}

class ProductModel extends ConnectedProducts {
  bool showFavorites = false;

  int get selectedProductIndex => _selProductIndex;

  List<Product> get allProducts {
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
    return _products[selectedProductIndex];
  }

  void deleteProduct() {
    _products.removeAt(selectedProductIndex);
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
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
        isFavorite: newStatus);

    _products[selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void updateProduct(String title, String desc, String image, double price) {
    Product newProduct = Product(
        title: title,
        desc: desc,
        image: image,
        price: price,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    _products[selectedProductIndex] = newProduct;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    notifyListeners();
  }
}

class UserModel extends ConnectedProducts {
  void login(String email, String password) {
    _authenticatedUser = User(email: email, password: password, id: "djf");
  }
}
