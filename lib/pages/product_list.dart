import 'package:flutter/material.dart';
import 'package:product_app/pages/create_product.dart';
import 'package:product_app/scope_model/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;

  ProductListPage(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductListPageState();
  }
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    widget.model.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Center(
                child: ListView.builder(
                    itemCount: model.allProducts.length,
                    itemBuilder: (BuildContext context, index) {
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        key: Key(model.allProducts[index].title),
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
                              title: Text(model.allProducts[index].title),
                              leading: CircleAvatar(
                                backgroundImage:
                                NetworkImage(model.allProducts[index].image),
                              ),
                              subtitle: Text(
                                  "\$" + model.allProducts[index].price
                                      .toString()),
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
