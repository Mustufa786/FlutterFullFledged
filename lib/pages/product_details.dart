import 'package:flutter/material.dart';
import 'package:product_app/models/product.dart';
import 'package:product_app/scope_model/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductDetails extends StatelessWidget {
  int productIndex;

  ProductDetails(this.productIndex);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          final Product product = model.allProducts[productIndex];
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
