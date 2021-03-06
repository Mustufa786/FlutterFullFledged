import 'package:product_app/models/product.dart';
import 'package:product_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConnectedProducts extends Model {
  User _authenticatedUser;
  List<Product> _products = [];
  int _selProductIndex;
  bool _isLoading = false;

  Future<Null> addProduct(String title, String desc, String image,
      double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> map = {
      'title': title,
      'desc': desc,
      'image':
      'https://i.ndtvimg.com/i/2015-09/cocoa-beans_625x350_41442094065.jpg',
      'price': price,
      'userID': _authenticatedUser.id,
      'userEmail': _authenticatedUser.email
    };

    return http
        .post('https://flutter-product-app-e96e0.firebaseio.com/products.json',
        body: json.encode(map))
        .then((http.Response response) {
      final Map<String, dynamic> productData = json.decode(response.body);
      Product newProduct = Product(
          id: productData['name'],
          title: title,
          desc: desc,
          image: image,
          price: price,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
    });
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

  Future<Null> fetchData() {
    _isLoading = true;
    notifyListeners();
    return http
        .get('https://flutter-product-app-e96e0.firebaseio.com/products.json')
        .then((http.Response response) {
      final Map<String, dynamic> productData = json.decode(response.body);
      final List<Product> fetchedProductList = [];
      if (productData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      productData.forEach((String id, dynamic data) {
        Product products = Product(
            title: data['title'],
            id: id,
            desc: data['desc'],
            image: data['image'],
            price: data['price'],
            userEmail: _authenticatedUser.email,
            userId: _authenticatedUser.id);
        fetchedProductList.add(products);
      });
      _products = fetchedProductList;
      _isLoading = false;
      notifyListeners();
    });
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
    _isLoading = true;
    final productId = selectedProduct.id;
    _products.removeAt(selectedProductIndex);
    _selProductIndex = null;
    notifyListeners();
    http.delete(
        'https://flutter-product-app-e96e0.firebaseio.com/products/${productId}.json');

    _isLoading = false;

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

  Future<Null> updateProduct(String title, String desc, String image,
      double price) {
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> updatedMap = {
      'title': title,
      'desc': desc,
      'image': image,
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId
    };
    return http
        .put(
        'https://flutter-product-app-e96e0.firebaseio.com/products/${selectedProduct
            .id}.json',
        body: json.encode(updatedMap))
        .then((http.Response response) {
      _isLoading = false;
      Product newProduct = Product(
          id: selectedProduct.id,
          title: title,
          desc: desc,
          image: image,
          price: price,
          userEmail: selectedProduct.userEmail,
          userId: selectedProduct.userId);
      _products[selectedProductIndex] = newProduct;
      notifyListeners();
    });
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

class UtilityModel extends ConnectedProducts {
  bool get isLoading => _isLoading;
}
