import 'package:flutter/material.dart';
import 'package:product_app/scope_model/main.dart';
import 'package:product_app/scope_model/products.dart';
import '../products.dart';
import './products_admin.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text("Choose"),
            ),
            ListTile(
              onTap: () => Navigator.pushReplacementNamed(context, '/admin'),
              title: Text("Manage Products"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("EasyList"),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(builder:
              (BuildContext context, Widget child, MainModel model) {
            return IconButton(
                icon: Icon(model.isDisplayedFavOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toggleShowFavState();
                });
          }),
        ],
      ),
      body: Products(),
    );
  }
}
