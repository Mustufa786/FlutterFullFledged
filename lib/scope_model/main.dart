import 'package:product_app/scope_model/connected_products.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with ConnectedProducts, ProductModel, UserModel {}
