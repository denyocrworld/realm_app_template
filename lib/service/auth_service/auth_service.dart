import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:realm_app/model/model.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';

UserProfile? userProfile;
bool get isAdmin => userProfile?.role == "Admin";
bool get isUser => userProfile?.role == "User";

class AuthService {
  static User? _currentUser;

  static User? get currentUser {
    _currentUser ??= RealmAppService.app.currentUser;
    return _currentUser;
  }

  static cleanUserData() async {
    var users = UserProfileService.instance.get();
    for (var user in users) {
      await UserProfileService.instance.delete(user);
    }
  }

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    pg("email: $email");
    pg("password: $password");
    try {
      _currentUser = await RealmAppService.app.logIn(
        Credentials.emailPassword(email, password),
      );

      await RealmSyncronizer.iniRealmInstance();

      if (DISCONNECTED_MODE == false) {
        await realm.subscriptions.waitForSynchronization();
      }

      UserProfileService.instance.createIfNotExists(email);
      userProfile = UserProfileService.instance.getByEmail(email);
      return true;
    } on Exception catch (error) {
      await deleteTemporaryData();
      print(error);
      return false;
    }
  }

  static Future<bool> register({
    required String email,
    required String password,
  }) async {
    EmailPasswordAuthProvider authProvider =
        EmailPasswordAuthProvider(RealmAppService.app);
    try {
      await authProvider.registerUser(email, password);
    } on Exception catch (e) {
      print("Failed to register");
      print(e.toString());
      print("---");
      return false;
    }
    return true;
  }

  static Future logout() async {
    await RealmAppService.app.currentUser?.logOut();
  }

  static bool get isNotLoggedIn => !isLoggedIn;
  static bool get isLoggedIn {
    bool isLoggedIn = RealmAppService.app.currentUser != null;
    if (isLoggedIn) {
      AuthService._currentUser = RealmAppService.app.currentUser;
    }
    return isLoggedIn;
  }

  static Future<void> deleteTemporaryData() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempDirContents = tempDir.listSync(recursive: true);
      for (var entity in tempDirContents) {
        if (entity is File) {
          await entity.delete();
        } else if (entity is Directory) {
          await entity.delete(recursive: true);
        }
      }
      print('Temporary data deleted successfully');
    } catch (e) {
      print('Error deleting temporary data: $e');
    }
  }
}
