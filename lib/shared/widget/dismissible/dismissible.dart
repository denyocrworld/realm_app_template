import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';

Widget QDismissible({
  required Function onDismiss,
  required Widget child,
}) {
  return Dismissible(
    key: UniqueKey(),
    onDismissed: (detail) => onDismiss(),
    confirmDismiss: (direction) async {
      bool confirm = false;
      await showDialog<void>(
        context: Get.currentContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Are you sure you want to delete this item?'),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[600],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () {
                  confirm = true;
                  Navigator.pop(context);
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
      if (confirm) {
        onDismiss();
        return Future.value(true);
      }
      return Future.value(false);
    },
    child: child,
  );
}
