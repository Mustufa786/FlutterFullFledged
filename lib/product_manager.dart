import 'package:flutter/material.dart';
import './products.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget {
  Map<String, String> startingProduct;

  ProductManager({this.startingProduct});

  @override
  _ProductManagerState createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  List<Map<String, String>> _products = [];

  void _addProduct(Map<String, String> product) {
    setState(() {
      _products.add(product);
    });
  }

  @override
  void initState() {
    if (widget.startingProduct != null) _products.add(widget.startingProduct);
    super.initState();
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.all(10),
          child: ProductControl(_addProduct),
        ),
        Expanded(
          child: Products(_products, deleteProduct: _deleteProduct),
        ),
      ],
    );
  }
}
