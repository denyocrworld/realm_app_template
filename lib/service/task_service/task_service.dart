import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class TaskService extends RealmBaseService<Task> {
  static TaskService? _instance;
  static TaskService get instance => _instance ??= TaskService();
  static SchemaObject schema = Task.schema;
}
