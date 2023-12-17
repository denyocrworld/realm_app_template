import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/service/task_service/task_service.dart';

Widget RealmDelete(RealmBaseService obj) {
  if (kDebugMode)
    return IconButton(
      onPressed: () {
        obj.deleteAll();
      },
      icon: Icon(
        Icons.delete_forever,
        size: 24.0,
      ),
    );
  return Container();
}
