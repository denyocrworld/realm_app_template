import 'dart:math';

import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class AdminUserListView extends StatefulWidget {
  const AdminUserListView({Key? key}) : super(key: key);

  Widget build(context, AdminUserListController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("AdminUserList"),
        actions: const [],
      ),
      body: RealmListView<UserProfile>(
        stream: UserProfileService.instance.snapshot(),
        padding: const EdgeInsets.all(0.0),
        itemBuilder: (item, index) {
          return QDismissible(
            onDismiss: () => controller.delete(item),
            child: ListTile(
              title: Text(item.name ?? "-"),
              subtitle: Text(item.email ?? "-"),
              trailing: Text(
                "${item.role}",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              onTap: () async {
                await Get.to(AdminUserFormView(
                  item: item,
                ));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        heroTag: Key("${Random().nextInt(10000)}"),
        onPressed: () async {
          await Get.to(AdminUserFormView());
        },
      ),
    );
  }

  @override
  State<AdminUserListView> createState() => AdminUserListController();
}
