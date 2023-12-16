import 'package:path_provider/path_provider.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/config.dart';
import 'package:realm_app/service/auth_service/auth_service.dart';
import 'package:realm_app/service/realm_service/realm_base_service.dart';

class RealmSyncronizer {
  static iniRealmInstance() async {
    var path = await getTemporaryDirectory();

    if (DISCONNECTED_MODE) {
      realm = Realm(Configuration.disconnectedSync(
        schemaList,
        // path: "${Directory.current.path}\\local_realm",
        path: "${path.path}//yyy",
        // AuthService.currentUser!,
        // schemaList,
      ));
    } else {
      print("Syncronize: Configure Flexible Sync");
      realm = Realm(Configuration.flexibleSync(
        AuthService.currentUser!,
        schemaList,
        syncErrorHandler: (error) {
          print("Syncronize: Sync Error!");
          print("Syncronize: $error");
        },
      ));
      print("Syncronize: Configure Flexible Sync Done!");
    }

    syncronize();

    if (DISCONNECTED_MODE == false) {
      for (var subscription in realm.subscriptions) {
        if (subscription.name!.contains("${DateTime.now()}Subscription")) {
          return;
        }
      }
    }

    print("realmInstance created!");
  }

  static Future syncronize() async {
    //Must be called after login
    print("Syncronize Realm");

    if (!DISCONNECTED_MODE) {
      for (var service in services) {
        await service.syncronize();
      }
    }
    print("Syncronize Realm Done");
  }
}
