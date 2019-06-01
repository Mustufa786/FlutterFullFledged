import 'package:flutter/material.dart';
import 'package:product_app/models/product.dart';
import 'package:product_app/scope_model/products.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductDetails extends StatelessWidget {
  int productIndex;

  ProductDetails(this.productIndex);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, ProductModel model) {
          final Product product = model.products[productIndex];
          return Scaffold(
            appBar: AppBar(
              title: Text(product.title),
              centerTitle: true,
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  Image.asset(product.image),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(product.title),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text("Back"),
                    ),
                  ),
                ],
              ),
            ),
          );
        }), onWillPop: () {
      Navigator.pop(context, false);
    });
  }
}
