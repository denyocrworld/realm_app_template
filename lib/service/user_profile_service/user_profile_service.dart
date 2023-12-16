import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class UserProfileService extends RealmBaseService<UserProfile> {
  static UserProfileService? _instance;
  static UserProfileService get instance => _instance ??= UserProfileService();
  static SchemaObject schema = UserProfile.schema;

  createIfNotExists(String email) {
    pg("Check if user exists: $email");
    var users = UserProfileService.instance.get();
    pg("Check if user exists: get Success");

    var user = users.where((i) => i.email == email).toList();
    if (user.isEmpty) {
      add(UserProfile(
        ObjectId(),
        email: email,
        name: email.split("@").first,
        role: email == "admin@demo.com" ? "Admin" : "User",
      ));
      pgl;
      pg("Create account!");
      pgl;
    } else {
      prl;
      pr("Account exists!");
      prl;
    }
  }

  UserProfile? getByEmail(String email) {
    var users = UserProfileService.instance.get();
    var user = users.where((i) => i.email == email).toList();
    if (user.isNotEmpty) {
      return user.first;
    }
    return null;
  }
}
