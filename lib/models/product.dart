import 'package:flutter/widgets.dart';

class Product {
  final String title;
  final String id;
  final String image;
  final String desc;
  final String userEmail;
  final String userId;
  final double price;
  final bool isFavorite;

  Product(
      {@required this.title,
        @required this.id,
      @required this.desc,
      @required this.image,
        @required this.price,
        @required this.userEmail,
        @required this.userId,
        this.isFavorite = false});
}
