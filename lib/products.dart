import 'package:flutter/material.dart';
import 'package:product_app/scope_model/main.dart';
import 'package:product_app/scope_model/products.dart';
import 'package:product_app/widgets/product_card.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/product.dart';

class Products extends StatelessWidget {
  Widget _buildListItem(List<Product> products) {
    Widget listCard = Center(
      child: Text("No product found,Please add some"),
    );
    if (products.length > 0) {
      listCard = ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
      );
    }

    return listCard;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          return _buildListItem(model.displayedProduct);
        });
  }
}
