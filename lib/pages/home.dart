import 'package:flutter/material.dart';
import 'package:product_app/scope_model/main.dart';
import '../products.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  MainModel model;

  HomePage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.model.fetchData();
    super.initState();
  }

  Widget _buildListItems() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
          Widget content = Center(
            child: Text("No Products Found"),
          );
          if (model.displayedProduct.length > 0 && !model.isLoading) {
            content = Products();
          } else if (model.isLoading) {
            content = Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(child: content, onRefresh: model.fetchData);
        });
  }

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
          ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
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
      body: _buildListItems(),
    );
  }
}
