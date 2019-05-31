import 'package:flutter/material.dart';
import 'package:product_app/models/product.dart';
import '../products.dart';
import './products_admin.dart';

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
              onTap: () => Navigator.pushReplacementNamed(context,'/admin'),
              title: Text("Manage Products"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("EasyList"),
      ),
      body: Products(),
    );
  }
}
