import 'package:realm/realm.dart';

part 'model.g.dart';
/*
@RealmModel()
class _UserProfile {
  @MapTo("_id")
  @PrimaryKey()
  late ObjectId id;
  
  //buat field2 yang dibutuhkan dibawah sini
}
*/

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

  @MapTo("created_at")
  late DateTime? createdAt;

  @MapTo("task_name")
  late String? taskName;

  @MapTo("description")
  late String? description;

  @MapTo("status")
  late String? status;
}
