import 'package:flutter/material.dart';

import './pages/product_details.dart';

class Products extends StatelessWidget {
  List<Map<String, String>> products;
  Function deleteProduct;

  Products(this.products, {this.deleteProduct});

  Widget _addItemBuilder(BuildContext context, int index) {
    return Card(
        child: Column(
      children: <Widget>[
        Image.asset(products[index]['image']),
        Text(products[index]['title']),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                onPressed: () =>
                    Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProductDetails(
                                products[index]['title'],
                                products[index]['image']),
                      ),
                    ).then((bool value) {
                      if (value) deleteProduct(index);
                    }),
                child: Text("Details"))
          ],
        ),
      ],
    ));
  }

  Widget _buildListItem() {
    Widget listCard = Center(
      child: Text("No product found,Please add some"),
    );
    if (products.length > 0) {
      listCard = ListView.builder(
          itemCount: products.length, itemBuilder: _addItemBuilder);
    }

    return listCard;
  }

  @override
  Widget build(BuildContext context) {
    return _buildListItem();
  }
}
