import 'package:flutter/material.dart';

import './pages/product_details.dart';

class Products extends StatelessWidget {
  List<String> products;

  Products(this.products);

  Widget _addItemBuilder(BuildContext context, int index) {
    return Card(
        child: Column(
      children: <Widget>[
        Image.asset('assets/food.jpg'),
        Text(products[index]),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ProductDetails(),
                      ),
                    ),
                child: Text("Details"))
          ],
        )
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
