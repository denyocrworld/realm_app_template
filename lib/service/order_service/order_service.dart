import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class OrderService extends RealmBaseService<Order> {
  static OrderService? _instance;
  static OrderService get instance => _instance ??= OrderService();
  static SchemaObject schema = Order.schema;
}
