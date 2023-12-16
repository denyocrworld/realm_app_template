import 'package:realm/realm.dart';

import '../../config.dart';

late Realm realm;

class RealmBaseService<T extends RealmObject> {
  syncronize() async {
    if (DISCONNECTED_MODE == false) {
      for (var subscription in realm.subscriptions) {
        if (subscription.name!.contains("${this}Subscription")) {
          return;
        }
      }
    }

    String queryAllName = "${this}Subscription";

    if (DISCONNECTED_MODE == false) {
      realm.subscriptions.update((mutableSubscriptions) {
        mutableSubscriptions.add(
          realm.all<T>(),
          name: queryAllName,
          update: true,
        );
      });
      await realm.subscriptions.waitForSynchronization();
    }
  }

  Stream<RealmResultsChanges<T>> snapshot({
    String query = "",
    String? sort,
    List<Object?> arguments = const [],
  }) {
    var sortQuery = "TRUEPREDICATE SORT(${sort ?? '_id ASC'})";
    var realmQuery = sortQuery;
    if (query.isNotEmpty) {
      realmQuery = "$query && $sortQuery";
    }
    return realm.query<T>(realmQuery, arguments).changes;
  }

  RealmResults get({
    String query = "",
    List<Object?> arguments = const [],
  }) {
    var sortQuery = "TRUEPREDICATE SORT(_id ASC)";
    var realmQuery = sortQuery;
    if (query.isNotEmpty) {
      realmQuery = "$query && $sortQuery";
    }
    return realm.query<T>(realmQuery, arguments);
  }

  List<T> getList() {
    List<T> users = [];
    var res = get();
    for (var index = 0; index < res.length; index++) {
      var userProfile = res[index] as T;
      users.add(userProfile);
    }
    return users;
  }

  add(T item) {
    try {
      realm.write(() {
        realm.add<T>(item);
      });
    } on Exception catch (err) {
      print(err);
      print("Failed to add new data");
    }
  }

  update({
    required ObjectId id,
    required Function(T item) update,
  }) {
    realm.write(() {
      var items = realm.all<T>().query(
        r"id == $0",
        [id],
      );
      var current = items.first;
      update(current);
    });
  }

  delete(T item) {
    realm.write(() {
      realm.delete(item);
    });
  }

  deleteAll() {
    realm.write(() {
      var results = get();
      for (var item in results) {
        realm.delete<T>(item as T);
      }
    });
  }
}
