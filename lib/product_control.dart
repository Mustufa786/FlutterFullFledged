import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  Function _addProduct;

  ProductControl(this._addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        _addProduct("Sweets");
      },
      child: Text("Add Products"),
    );
  }
}
