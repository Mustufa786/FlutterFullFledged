import 'package:flutter/material.dart';
import '../product_manager.dart';
import './products_admin.dart';

class HomePage extends StatelessWidget {

  List<Map<String,dynamic>> _products = [];


  HomePage(this._products);

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
              onTap: () => Navigator.pushReplacementNamed(context,'/admin'),
              title: Text("Manage Products"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("EasyList"),
      ),
      body: ProductManager(_products),
    );
  }
}
