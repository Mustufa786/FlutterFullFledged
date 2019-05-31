import 'package:flutter/material.dart';
import 'package:product_app/models/product.dart';
import 'package:product_app/scope_model/products.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateProductPage extends StatefulWidget {
  Function addProduct;
  Product product;
  Function updateProduct;
  int productIndex;

  CreateProductPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex});

  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final Map<String, dynamic> _formMap = {
    'title': null,
    'desc': null,
    'price': null,
    'image': 'assets/food.jpg'
  };

  String prodName, prodDesc;
  double priceValue;

  void _onSubmitForm(Function addProduct, Function updateProduct) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (widget.product == null) {
      addProduct(Product(
          title: _formMap['title'],
          desc: _formMap['desc'],
          image: _formMap['image'],
          price: _formMap['price']));
    } else {
      widget.updateProduct(
          widget.productIndex,
          Product(
              title: _formMap['title'],
              desc: _formMap['desc'],
              image: _formMap['image'],
              price: _formMap['price']));
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _submitProductButton() {
    return ScopedModelDescendant<ProductModel>(
      builder: (BuildContext context, Widget child, ProductModel model) {
        return RaisedButton(
          onPressed: () => _onSubmitForm(model.addProduct, model.updateProduct),
          child: Text("Save"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget pageContent = Container(
      margin: EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              initialValue: widget.product == null ? "" : widget.product.title,
              decoration: InputDecoration(labelText: "Product Name"),
              validator: (String value) {
                if (value.isEmpty) {
                  return "Product Name is required!";
                }
              },
              onSaved: (value) {
                _formMap['title'] = value;
              },
            ),
            TextFormField(
              initialValue: widget.product == null ? "" : widget.product.desc,
              maxLines: 4,
              decoration: InputDecoration(labelText: "Product Description"),
              validator: (String value) {
                if (value.isEmpty) {
                  return "Product description is required!";
                }
              },
              onSaved: (value) {
                _formMap['desc'] = value;
              },
            ),
            TextFormField(
              initialValue:
              widget.product == null ? "" : widget.product.price.toString(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Product Price"),
              validator: (String value) {
                if (value.isEmpty) {
                  return "Product price is required!";
                }
              },
              onSaved: (value) {
                _formMap['price'] = double.parse(value);
              },
            ),
            _submitProductButton(),
          ],
        ),
      ),
    );
    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text("Edit Product"),
            ),
            body: pageContent,
          );
  }
}
