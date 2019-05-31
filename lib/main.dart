import 'package:flutter/material.dart';
import 'package:product_app/models/product.dart';
import 'package:product_app/pages/auth.dart';
import 'package:product_app/pages/products_admin.dart';
import './pages/home.dart';
import './pages/product_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      title: "Products App",
      home: AuthPage(),
      routes: {
        '/products': (BuildContext context) => HomePage(products),
        '/admin': (BuildContext context) =>
            ProductAdmin(_deleteProduct, _addProduct,_updateProduct,products)
      },
      onGenerateRoute: (RouteSettings setting) {
        final List<String> pathElements = setting.name.split("/");
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductDetails(
                products[index].title, products[index].image),
          );
        }
      },
    );
  }
}
