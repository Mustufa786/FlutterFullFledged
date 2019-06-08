import 'package:flutter/material.dart';
import 'package:product_app/models/product.dart';
import 'package:product_app/scope_model/main.dart';
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

  void _onSubmitForm(Function addProduct, Function updateProduct,
      int selectedProductIndex, Function setSelectProduct) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectedProductIndex == null) {
      addProduct(_formMap['title'], _formMap['desc'], _formMap['image'],
          _formMap['price']);
    } else {
      updateProduct(
          _formMap['title'],
          _formMap['desc'],
          _formMap['image'],
          _formMap['price']);
    }

    Navigator.pushReplacementNamed(context, '/products')
        .then((_) => setSelectProduct(null));
  }

  Widget _submitProductButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          onPressed: () =>
              _onSubmitForm(model.addProduct, model.updateProduct,
                  model.selectedProductIndex, model.selectProduct),
          child: Text("Save"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          final Widget pageContent = _buildContent(model.selectedProduct);
          return model.selectedProductIndex == null
              ? pageContent
              : Scaffold(
            appBar: AppBar(
              title: Text("Edit Product"),
            ),
            body: pageContent,
          );
        });
  }

  Widget _buildContent(Product product) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              initialValue: product == null ? "" : product.title,
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
              initialValue: product == null ? "" : product.desc,
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
              initialValue: product == null ? "" : product.price.toString(),
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
  }
}
