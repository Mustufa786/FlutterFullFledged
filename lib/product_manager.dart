import 'package:flutter/material.dart';
import './products.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget {
  String startingProduct;

  ProductManager({this.startingProduct});

  @override
  _ProductManagerState createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _products = [];

  void _addProduct(String product) {
    setState(() {
      _products.add(product);
    });
  }

  @override
  void initState() {
    if (widget.startingProduct != null) _products.add(widget.startingProduct);
    super.initState();
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
          child: Products(_products),
        ),
      ],
    );
  }
}
