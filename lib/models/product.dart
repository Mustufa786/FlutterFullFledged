import 'package:flutter/widgets.dart';

class Product {
  final String title;
  final String image;
  final String desc;
  final double price;
  final bool isFavorite;

  Product(
      {@required this.title,
      @required this.desc,
      @required this.image,
        @required this.price,
        this.isFavorite = false});
}
