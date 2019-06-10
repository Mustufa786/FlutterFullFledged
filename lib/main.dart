import 'package:flutter/material.dart';
import 'package:product_app/pages/auth.dart';
import 'package:product_app/pages/products_admin.dart';
import 'package:product_app/scope_model/main.dart';
import './pages/home.dart';
import './pages/product_details.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        title: "Products App",
        home: AuthPage(),
        routes: {
          '/products': (BuildContext context) => HomePage(model),
          '/admin': (BuildContext context) => ProductAdmin(model)
        },
        onGenerateRoute: (RouteSettings setting) {
          final List<String> pathElements = setting.name.split("/");
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'product') {
            final int index = int.parse(pathElements[2]);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductDetails(index),
            );
          }
        },
      ),
    );
  }
}
