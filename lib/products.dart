import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  List<Map<String, dynamic>> products;

  Products(this.products);

  Widget _addItemBuilder(BuildContext context, int index) {
    return Card(
        child: Column(
      children: <Widget>[
        Image.asset(products[index]['image']),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                products[index]['title'],
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
                    "\$" + products[index]['price'].toString(),
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
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_border),
              color: Colors.red,
            ),
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
