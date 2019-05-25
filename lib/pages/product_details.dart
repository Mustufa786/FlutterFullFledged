import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  String title, imageUrl;

  ProductDetails(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset(imageUrl),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(title),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Back"),
              ),
            ),
          ],
        ),
      ),
    ), onWillPop: () {
      Navigator.pop(context, false);
    });
  }
}
