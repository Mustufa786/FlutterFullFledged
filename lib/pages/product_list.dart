import 'package:flutter/material.dart';
import 'package:product_app/pages/create_product.dart';

class ProductListPage extends StatelessWidget {
  List<Map<String, dynamic>> products = [];
  Function updateProduct, deleteProduct;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Center(
          child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: Key(products[index]['title']),
                  background: Container(
                    color: Colors.red,
                  ),
                  onDismissed: (DismissDirection direction) {
                    deleteProduct(index);
                  },
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(products[index]['title']),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(products[index]['image']),
                        ),
                        subtitle:
                            Text("\$" + products[index]['price'].toString()),
                        trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return CreateProductPage(
                                      updateProduct: updateProduct,
                                      product: products[index],
                                      productIndex: index,
                                    );
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
  }
}
