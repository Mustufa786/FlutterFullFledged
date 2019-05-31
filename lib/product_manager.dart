import 'package:flutter/material.dart';
import './products.dart';
import 'models/product.dart';

class ProductManager extends StatelessWidget {
  List<Product> _products = [];

  ProductManager(this._products);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Products(_products),
        ),
      ],
    );
  }
}
