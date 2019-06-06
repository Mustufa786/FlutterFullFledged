import 'package:flutter/material.dart';
import 'package:product_app/pages/create_product.dart';
import 'package:product_app/scope_model/main.dart';
import 'package:product_app/scope_model/products.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Center(
                child: ListView.builder(
                    itemCount: model.products.length,
                    itemBuilder: (BuildContext context, index) {
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        key: Key(model.products[index].title),
                        background: Container(
                          color: Colors.red,
                        ),
                        onDismissed: (DismissDirection direction) {
                          model.selectProduct(index);
                          model.deleteProduct();
                        },
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(model.products[index].title),
                              leading: CircleAvatar(
                                backgroundImage:
                                AssetImage(model.products[index].image),
                              ),
                              subtitle: Text(
                                  "\$" +
                                      model.products[index].price.toString()),
                              trailing: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    model.selectProduct(index);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return CreateProductPage();
                                        },
                                      ),
                                    );
                                  }),
                            ),
                            Divider(),
                          ],
                        ),
                      );
                    })),
          );
        });
  }
}
