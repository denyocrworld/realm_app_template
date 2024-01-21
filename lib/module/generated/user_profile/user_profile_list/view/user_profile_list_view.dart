import 'package:flutter/material.dart';
import 'package:realm_app/core.dart';
import 'package:realm_app/model/model.dart';

class UserProfileListView extends StatefulWidget {
  UserProfileListView({Key? key}) : super(key: key);

  Widget build(context, UserProfileListController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile List"),
        actions: [
          RealmDelete(UserProfileService.instance),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RealmListView<UserProfile>(
              stream: UserProfileService.instance.snapshot(query: ""),
              padding: EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              itemBuilder: (item, index) {
                return QDismissible(
                  onDismiss: () => controller.delete(item),
                  child: ListTile(
                    title: Text(item.name ?? "-"),
                    subtitle: Text(item.email ?? "-"),
                    onTap: () => Get.to(UserProfileFormView(item: item)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingAction(
        onPressed: () async {
          await Get.to(UserProfileFormView());
        },
      ),
    );
  }

  @override
  State<UserProfileListView> createState() => UserProfileListController();
}
