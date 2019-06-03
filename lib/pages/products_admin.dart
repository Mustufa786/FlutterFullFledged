import 'package:flutter/material.dart';
import 'package:product_app/models/product.dart';

import './home.dart';
import './create_product.dart';
import './product_list.dart';

class ProductAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text("Choose"),
              ),
              ListTile(
                onTap: () =>
                    Navigator.pushReplacementNamed(context, '/products'),
                title: Text("All Products"),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Manage Products"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: "Create Product",
              ),
              Tab(
                icon: Icon(Icons.list),
                text: "My Products",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CreateProductPage(),
            ProductListPage()
          ],
        ),
      ),
    );
  }
}
