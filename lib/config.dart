import 'package:realm_app/model/model.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';

const String APP_ID = "realmhyperui-hzxfq";
const String APP_URL =
    "https://realm.mongodb.com/groups/656683f66101064775bf604a/apps/657bc642e8722e10cade0d16";
const bool DISCONNECTED_MODE = true;

//TODO: Setiap membuat model baru, wajib di tambahkan disini!
List<SchemaObject> schemaList = [
  //@SCHEMA_LIST
  UserProfile.schema,
  Task.schema,
  //@:SCHEMA_LIST
];

//TODO: Setiap membuat service baru, wajib di tambahkan disini!
List<RealmBaseService> services = [
  //@SERVICE_LIST
  UserProfileService.instance,
  //@:SERVICE_LIST
];
