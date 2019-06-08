import 'package:flutter/material.dart';
import 'package:product_app/models/product.dart';
import 'package:product_app/scope_model/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCard extends StatelessWidget {
  Product product;
  int index;

  ProductCard(this.product, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: <Widget>[
        Image.network(product.image),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                product.title,
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Oswald'),
              ),
              SizedBox(
                width: 8,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: Text(
                    "\$" + product.price.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              child: Text(
                "Union Square, San Francisco",
                style: TextStyle(fontSize: 16),
              )),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pushNamed<bool>(
                  context, '/product/' + index.toString()),
              icon: Icon(Icons.info),
              color: Theme.of(context).accentColor,
            ),
            ScopedModelDescendant<MainModel>(
                builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                onPressed: () {
                  model.selectProduct(index);
                  model.toggleFavoriteStatus();
                },
                icon: Icon(model.allProducts[index].isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Colors.red,
              );
            }),
          ],
        ),
      ],
    ));
  }
}
