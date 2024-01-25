import 'package:realm/realm.dart';
import 'package:realm_app/model/model_util.dart';
part 'model.g.dart';

@RealmModel()
class _UserProfile {
  @MapTo("_id")
  @PrimaryKey()
  late ObjectId id;

  @MapTo("name")
  late String? name;

  @MapTo("email")
  late String? email;

  @MapTo("password")
  late String? password;

  @MapTo("role")
  late String? role;

  @MapTo("photo")
  late String? photo;
}

@RealmModel()
class _Task {
  @MapTo("_id")
  @PrimaryKey()
  late ObjectId id;

  @MapTo("created_by")
  late _UserProfile? createdBy;

  @MapTo("assigned_to")
  late _UserProfile? assignedTo;

  @MapTo("created_at")
  late DateTime? createdAt;

  @MapTo("task_name")
  late String? taskName;

  @MapTo("description")
  late String? description;

  @MapTo("status")
  late String? status;
}

@RealmModel()
class _Product {
  @MapTo("_id")
  @PrimaryKey()
  late ObjectId id;

  @MapTo("created_by")
  late _UserProfile? createdBy;

  @MapTo("photo")
  late String? photo;

  @MapTo("product_name")
  late String? productName;

  @MapTo("price")
  late double? price;

  @MapTo("stock")
  late double? stock;

  @MapTo("description")
  late String? description;
}

@RealmModel()
class _Order {
  @MapTo("_id")
  @PrimaryKey()
  late ObjectId id;

  @MapTo("created_by")
  late _UserProfile? createdBy;

  @MapTo("created_at")
  late DateTime? createdAt;

  @MapTo("customer_name")
  late String? customerName;

  @MapTo("products")
  List<_Product>? items;

  @MapTo("total")
  late double? total;

  @MapTo("pay_amount")
  late double? payAmount;

  @MapTo("return_amount")
  late double? returnAmount;
}
