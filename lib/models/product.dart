import 'package:flutter/widgets.dart';

class Product {
  final String title;
  final String image;
  final String desc;
  final double price;

  Product(
      {@required this.title,
      @required this.desc,
      @required this.image,
      @required this.price});
}
