import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class ProductService extends RealmBaseService<Product> {
  static ProductService? _instance;
  static ProductService get instance => _instance ??= ProductService();
  static SchemaObject schema = Product.schema;
}
